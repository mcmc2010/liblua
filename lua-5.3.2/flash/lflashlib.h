/*
** $Id: lflashlib.h, v 1.00 2016/08/06 silly
** Lua Flash library
** 
*/


#ifndef lflashlib_h
#define lflashlib_h

#include "lua.h"

//flash 
#define LUA_FLASHLIBNAME	"flash"
LUAMOD_API int (luaopen_flash) (lua_State *L);


#endif //lflashlib_h