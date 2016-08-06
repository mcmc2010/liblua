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

#define lbitlib_c
#define LUA_LIB

#include "AS3/AS3.h"
#include "lua.h"

#include "lauxlib.h"
#include "lualib.h"
#include "lflashlib.h"

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

//
static const luaL_Reg flashlib[] = 
{
	{"trace", flash_trace},
	{NULL, NULL}
};

//
LUAMOD_API int luaopen_flash (lua_State *L) 
{
	luaL_newlib(L, flashlib);

	//
	luaL_newmetatable(L, "flash");
	lua_pop(L, 1);

	//
	return 1;
}