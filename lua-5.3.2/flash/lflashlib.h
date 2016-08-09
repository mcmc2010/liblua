/*
** $Id: lflashlib.h, v 1.00 2016/08/06 silly
** Lua Flash library
** 
*/


#ifndef lflashlib_h
#define lflashlib_h

#include "lua.h"

//lua
#undef lua_pop
LUA_API void 			lua_pop(lua_State *L, int n);

#undef lua_tonumber
LUA_API lua_Number 		lua_tonumber(lua_State *L, int i);
#undef lua_tostring
LUA_API const char * 		lua_tostring(lua_State *L, int i);
#undef lua_tointeger
LUA_API lua_Integer 		lua_tointeger(lua_State *L, int i);

#undef lua_newtable
LUA_API void 			lua_newtable(lua_State *L);
#undef lua_call
LUA_API void  			lua_call(lua_State *L, int n, int r);
#undef lua_pcall
LUA_API int   			lua_pcall(lua_State *L, int n, int r, int f);

//lualib
#undef luaL_loadfile
LUA_API int 			luaL_loadfile(lua_State *L, const char *f);

//flash 
LUA_API void			flash_newclassmeta(lua_State *L, const char *name);
LUA_API void*			flash_pushreference(lua_State *L, const char *name);

#define LUA_FLASHLIBNAME	"flash"
LUAMOD_API int 	(luaopen_flash) (lua_State *L);

LUALIB_API void 	(luaL_open_all_libs) (lua_State *L) ;
LUALIB_API void 	(luaL_open_min_libs) (lua_State *L) ;

//
#endif //lflashlib_h