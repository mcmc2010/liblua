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
#ifdef SWIG

%module LuaLibModule


//
%typemap(astype) 	void* 	"Number";
%typemap(in) 		void* 	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 		void*
{
    AS3_DeclareVar($result, Number);
    AS3_CopyScalarToVar($result, $1);
}

//x32 为uint32, x64 为uint64
%typemap(astype) 	size_t 	"uint";
%typemap(in) 		size_t 	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 		size_t
{
    AS3_DeclareVar($result, uint);
    AS3_CopyScalarToVar($result, $1);
}

//將lua的狀態機指針，轉換成NUMBER存放，按8字節來處理
%typemap(astype) 	lua_State* 	"Number";
%typemap(in) 		lua_State* 	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 	lua_State*
{
    AS3_DeclareVar($result, Number);
    AS3_CopyScalarToVar($result, $1);
}

//
%typemap(astype) 	lua_Number	"Number";
%typemap(in) 		lua_Number	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 		lua_Number
{
    AS3_DeclareVar($result, Number);
    AS3_CopyScalarToVar($result, $1);
}

//
%typemap(astype) 	lua_Integer	"int";
%typemap(in) 		lua_Integer	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 		lua_Integer
{
    AS3_DeclareVar($result, int);
    AS3_CopyScalarToVar($result, $1);
}


%{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "lflashlib.h"
#include "AS3/AS3.h"

int 	main() 
{ 
	AS3_GoAsync(); 
}

//--------------------------------------------------------------------------
#undef lua_pop
void lua_pop(lua_State *L, int n) 
{ 
	lua_settop(L, -(n)-1); 
}

#undef lua_tonumber
lua_Number lua_tonumber(lua_State *L, int i)
{
	lua_tonumberx(L,i,NULL);
}

#undef lua_tointeger
lua_Integer lua_tointeger(lua_State *L, int i)
{
	lua_tointegerx(L,i,NULL);
}

#undef lua_tostring
const char * lua_tostring(lua_State *L, int i)	
{
	lua_tolstring(L, i, NULL);
}

#undef lua_newtable
void lua_newtable(lua_State *L)
{
	lua_createtable(L, 0, 0);
}

#undef lua_call
void  lua_call(lua_State *L, int n, int r)
{
	lua_callk(L, n, r, 0, NULL);
}

#undef lua_pcall
int lua_pcall(lua_State *L, int n, int r, int f)
{	
	lua_pcallk(L, n, r, f, 0, NULL);
}

//
#undef luaL_loadfile
int luaL_loadfile(lua_State *L, const char *f)	
{
	luaL_loadfilex(L,f,NULL);
}


//flash
int flash_pushreferencex(lua_State *L, const char *name)
{
	// Push the new userdata onto the stack
	int result = (int)lua_newuserdata(L, 4);
	luaL_getmetatable(L, name);
	lua_setmetatable(L, -2);
	return result;
}

int flash_pushreference(lua_State *L)
{
	return flash_pushreferencex(L, "flash");
}

%}

%include "lua.h"
%include "lauxlib.h"
%include "lualib.h"
%include "lflashlib.h"

#else //SWIG

#define  SWIGPP
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "lflashlib.h"

//
#undef lua_pop
LUA_API void 			lua_pop(lua_State *L, int n);

#undef lua_tonumber
LUA_API lua_Number 		lua_tonumber(lua_State *L, int i);
#undef lua_tostring
LUA_API const char * 	lua_tostring(lua_State *L, int i);
#undef lua_tointeger
LUA_API lua_Integer 	lua_tointeger(lua_State *L, int i);

#undef lua_newtable
LUA_API void 			lua_newtable(lua_State *L);
#undef lua_call
LUA_API void  			lua_call(lua_State *L, int n, int r);
#undef lua_pcall
LUA_API int   			lua_pcall(lua_State *L, int n int r, int f);

//
#undef luaL_loadfile
LUA_API int 			luaL_loadfile(lua_State *L, const char *f);

//flash
LUA_API int 			flash_pushreference(lua_State *L);
LUA_API int 			flash_pushreferencex(lua_State *L, const char *name);

//
#endif //SWIG
