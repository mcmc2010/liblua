/*
** ADOBE SYSTEMS INCORPORATED
** Copyright 2012 Adobe Systems Incorporated
** All Rights Reserved.
**
** NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
** terms of the Adobe license agreement accompanying it.  If you have received this file from a
** source other than Adobe, then your use, modification, or distribution of it requires the prior
** written permission of Adobe.
*/
// Flash Runtime interop

#define lflashlib_c
#define LUA_LIB

#include <stdlib.h>
#include <memory.h>

#include "AS3/AS3.h"
#include "lua.h"

#include "lauxlib.h"
#include "lualib.h"
#include "lflashlib.h"


//----------------------------------------------------------------------------------------------------------------------------------------
//lua
LUA_API void lua_pop(lua_State *L, int n) 
{ 
	lua_settop(L, -(n)-1); 
}

LUA_API lua_Number lua_tonumber(lua_State *L, int i)
{
	return lua_tonumberx(L,i,NULL);
}

LUA_API lua_Integer lua_tointeger(lua_State *L, int i)
{
	return lua_tointegerx(L,i,NULL);
}

LUA_API const char * lua_tostring(lua_State *L, int i)	
{
	return lua_tolstring(L, i, NULL);
}

LUA_API void lua_newtable(lua_State *L)
{
	lua_createtable(L, 0, 0);
}

LUA_API void  lua_call(lua_State *L, int n, int r)
{
	lua_callk(L, n, r, 0, NULL);
}

LUA_API int lua_pcall(lua_State *L, int n, int r, int f)
{	
	return lua_pcallk(L, n, r, f, 0, NULL);
}

//lualib
LUA_API int luaL_loadfile(lua_State *L, const char *f)	
{
	return luaL_loadfilex(L,f,NULL);
}

LUA_API int luaL_getmetatable(lua_State *L, const char *n)	
{
	return lua_getfield(L, LUA_REGISTRYINDEX, (n));
}

//
static const luaL_Reg loaded_all_libs[ ] = 
{
	{"_G", 				luaopen_base},
	{LUA_LOADLIBNAME, 		luaopen_package},
	{LUA_COLIBNAME, 		luaopen_coroutine},
	{LUA_TABLIBNAME, 		luaopen_table},
	{LUA_IOLIBNAME, 		luaopen_io},
	{LUA_OSLIBNAME, 		luaopen_os},
	{LUA_STRLIBNAME, 		luaopen_string},
	{LUA_MATHLIBNAME, 		luaopen_math},
	{LUA_UTF8LIBNAME, 		luaopen_utf8},
	{LUA_DBLIBNAME, 		luaopen_debug},
//	{LUA_BITLIBNAME, 		luaopen_bit32},
	{LUA_FLASHLIBNAME, 		luaopen_flash},
	{NULL, NULL}
};

static const luaL_Reg loaded_min_libs[ ] = 
{
	{"_G", 				luaopen_base},
	{LUA_LOADLIBNAME, 		luaopen_package},
	{LUA_COLIBNAME, 		luaopen_coroutine},
	{LUA_TABLIBNAME, 		luaopen_table},
	{LUA_STRLIBNAME, 		luaopen_string},
	{LUA_MATHLIBNAME, 		luaopen_math},
	{LUA_FLASHLIBNAME, 		luaopen_flash},
	{NULL, NULL}
};

LUALIB_API void luaL_open_all_libs (lua_State *L) 
{
	const luaL_Reg *lib = loaded_all_libs;
	for ( ; lib->func; lib++) 
	{
		luaL_requiref(L, lib->name, lib->func, 1);
		lua_pop(L, 1);  
	}
}

LUALIB_API void luaL_open_min_libs (lua_State *L) 
{
	const luaL_Reg *lib = loaded_min_libs;
	for ( ; lib->func; lib++) 
	{
		luaL_requiref(L, lib->name, lib->func, 1);
		lua_pop(L, 1);  
	}
}

//----------------------------------------------------------------------------------------------------------------------------------------
//flash
LUA_API void	flash_newclassmeta(lua_State *L, const char *name)
{
	luaL_newmetatable(L, name);	
	lua_pushstring(L, "__index");
	lua_pushvalue(L, -2);
	lua_settable(L, -3);
	lua_pop(L, 1);	
}

LUA_API void* 	flash_pushreference(lua_State *L, const char *name)
{
	// Push the new userdata onto the stack
	void* result = lua_newuserdata(L, sizeof(void *));
	luaL_getmetatable(L, name);
	lua_setmetatable(L, -2);
	return result;
}

// class_name : the class name and script table name.
// object_name : the object name is script object name.
LUA_API void flash_pushcppobject(lua_State *L, const char* class_name, const char* object_name, void* object)
{
	void*	data = flash_pushreference(L, class_name);
	if(data != NULL)
	{
		memcpy(data, &object, sizeof(void*));
		lua_setglobal(L, object_name);
	}
}


//----------------------------------------------------------------------------------------------------------------------------------------
//
static int flash_trace (lua_State *L) 
{
	size_t 		length 	= 0;
	const char* 	text 	= luaL_checklstring(L, 1, &length);

	AS3_DeclareVar(str, String);
	AS3_CopyCStringToVar(str, text, length);

	lua_pop(L, 1);

	//
	inline_nonreentrant_as3("trace(str);\n");
	return 1;
}

static int flash_gettimer (lua_State *L) 
{
	lua_Integer result = 0;
	inline_nonreentrant_as3("import flash.utils.getTimer;\n%0 = getTimer();\n" : "=r"(result));
	lua_pushinteger(L, result);
	return 1;
}

// getters
static int flash_getprop (lua_State *L) 
{
	int stack = lua_gettop(L);
	if(lua_type(L, -1) != LUA_TUSERDATA)
	{
		lua_pop(L, stack);
		return 1; 
	}
	if(lua_type(L, -2) == LUA_TSTRING)
	{
		lua_pop(L, stack);
		return 1; 
	}

	// //
	// AS3_DeclareVar(lua_state_value_t, Number);
	// AS3_CopyScalarToVar(lua_state_value_t, L);

	//
	void*		data	= lua_touserdata(L, -1);

	//
	size_t 		length	= 0;
	const char*	text 	= lua_tolstring(L, -2, &length);
	AS3_DeclareVar(prop_name, String);
	AS3_CopyCStringToVar(prop_name, text, length);

	inline_as3(
		"var lua_state_t:* = mxlib.lua.__lua_state_list[%0];\n"
		"var prop_name_t:* = lua_state_t.real_ObjectList[%1][prop_name];\n" 
		"lua_state_t.luaAS3_newclassmetaByObject(prop_name_t);\n"
		"lua_state_t.luaAS3_pushobject(prop_name_t, prop_name);\n"
		: : "r"(L), "r"(data)
	);
	
	lua_pop(L, 2);

	//
	return 1;
}

static int flash_getnumber (lua_State *L) 
{
	int stack = lua_gettop(L);
	if(lua_type(L, -1) != LUA_TUSERDATA)
	{
		lua_pop(L, stack);
		return 1; 
	}
	if(lua_type(L, -2) == LUA_TSTRING)
	{
		lua_pop(L, stack);
		return 1; 
	}

	//
	void*		data	= lua_touserdata(L, -1);

	//
	size_t 		length	= 0;
	const char*	text 	= lua_tolstring(L, -2, &length);
	AS3_DeclareVar(prop_name, String);
	AS3_CopyCStringToVar(prop_name, text, length);

  	lua_pop(L, 2);
  	
  	//
  	lua_Number result = 0;
  	inline_as3(
		"var lua_state_t:* = mxlib.lua.__lua_state_list[%1];\n"
		"var prop_name_t:* = lua_state_t.real_ObjectList[%2][prop_name];\n" 
		"%0 = Number(prop_name_t);\n\n"
		: "=r"(result): "r"(L), "r"(data)
	);

	//
	lua_pushnumber(L, result);
	return 1;
}

static int flash_getint (lua_State *L) 
{
	int stack = lua_gettop(L);
	if(lua_type(L, -1) != LUA_TUSERDATA)
	{
		lua_pop(L, stack);
		return 1; 
	}
	if(lua_type(L, -2) == LUA_TSTRING)
	{
		lua_pop(L, stack);
		return 1; 
	}

	//
	void*		data	= lua_touserdata(L, -1);

	//
	size_t 		length	= 0;
	const char*	text 	= lua_tolstring(L, -2, &length);
	AS3_DeclareVar(prop_name, String);
	AS3_CopyCStringToVar(prop_name, text, length);

  	lua_pop(L, 2);
  	
  	//
  	lua_Integer result = 0;
  	inline_as3(
		"var lua_state_t:* = mxlib.lua.__lua_state_list[%1];\n"
		"var prop_name_t:* = lua_state_t.real_ObjectList[%2][prop_name];\n" 
		"%0 = int(prop_name_t);\n\n"
		: "=r"(result): "r"(L), "r"(data)
	);

	//
	lua_pushinteger(L, result);
	return 1;
}

static int flash_getstring (lua_State *L) 
{
	int stack = lua_gettop(L);
	if(lua_type(L, -1) != LUA_TUSERDATA)
	{
		lua_pop(L, stack);
		return 1; 
	}
	if(lua_type(L, -2) == LUA_TSTRING)
	{
		lua_pop(L, stack);
		return 1; 
	}

	//
	void*		data	= lua_touserdata(L, -1);

	//
	size_t 		length	= 0;
	const char*	text 	= lua_tolstring(L, -2, &length);
	AS3_DeclareVar(prop_name, String);
	AS3_CopyCStringToVar(prop_name, text, length);

  	lua_pop(L, 2);
  	
  	//
  	const char* result = 0;
  	inline_as3(
		"var lua_state_t:* = mxlib.lua.__lua_state_list[%1];\n"
		"var prop_name_t:* = lua_state_t.real_ObjectList[%2][prop_name];\n" 
		"%0 = CModule.mallocString(prop_name_t);\n\n"
		: "=r"(result): "r"(L), "r"(data)
	);

	//
	lua_pushfstring(L, "%s", result);
	free((void*)result);
	return 1;
}


//
static const luaL_Reg flashlib[] = 
{
	{"trace", 		flash_trace},
	{"gettimer", 	flash_gettimer},	

	{"getprop", 	flash_getprop},
	{"getint", 		flash_getint},
	{"getnumber", 	flash_getnumber},
	{"getstring", 	flash_getstring},

	{NULL, NULL}
};

//
LUAMOD_API int luaopen_flash (lua_State *L) 
{
	luaL_newlib(L, flashlib);

	//
	return 1;
}