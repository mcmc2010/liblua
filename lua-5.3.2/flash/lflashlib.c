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

LUA_API void* flash_pushreference(lua_State *L, const char *name)
{
	// Push the new userdata onto the stack
	void* result = lua_newuserdata(L, sizeof(void *));
	luaL_getmetatable(L, name);
	lua_setmetatable(L, -2);
	return result;
}

// class_name : the class name and script table name.
// object_name : the object name is script object name.
LUA_API void flash_pushobject(lua_State *L, const char* class_name, const char* object_name, void* object)
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
	int result = 0;
	inline_nonreentrant_as3("import flash.utils.getTimer;\n%0 = getTimer();\n" : "=r"(result));
	lua_pushinteger(L, result);
	return 1;
}

/*
//
static const luaL_Reg flashmeta[] = 
{
	{"__gc",        	flash_gc},
	{"__tostring",  	flash_tostring},
	{"__index",     	flash_getprop},
	{"__newindex",  flash_setprop},
	{"__call",      	flash_apply},
	{0, 0}
};
*/
//
static const luaL_Reg flashlib[] = 
{
	{"trace", 	flash_trace},
	{"gettimer", 	flash_gettimer},	
	{NULL, NULL}
};

//
LUAMOD_API int luaopen_flash (lua_State *L) 
{
	luaL_newlib(L, flashlib);

	//
	return 1;
}