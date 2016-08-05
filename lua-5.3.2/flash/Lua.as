package com.adobe.flascc.swig 
{
	import flash.utils.Dictionary;
	import com.adobe.flascc.CModule;
};

package mxlib
{
	// 必須加這個，C++的代理函數被放在這個包下面
	import C_Run.*;

	//
	import com.adobe.flascc.swig.*;
	import flash.utils.ByteArray;

	// 用來存放LUA的狀態機
	public class Lua_State
	{
		private var _real_LuaState:Number = 0;
		public function get real_LuaState() : Number { return this._real_LuaState;  }
		public function Lua_State(open_all:Boolean = false)
		{
			this._real_LuaState = Lua.luaL_newstate();
			if(open_all)
			{ 
				Lua.luaL_openlibs(this._real_LuaState); 
				
				trace("[Lua_State] open all librarys.");
			}
			else
			{
				Lua.luaopen_base(this._real_LuaState);
				Lua.luaopen_math(this._real_LuaState);
				Lua.luaopen_package(this._real_LuaState);
				Lua.luaopen_string(this._real_LuaState);

				trace("[Lua_State] open mini librarys.");
			}
		}

		public function dispose() : void
		{
			if(this._real_LuaState != 0)
			{
				Lua.lua_close(this._real_LuaState);
				this._real_LuaState = 0;
			}
		}
	};

	// 用來操作LUA的基本類庫
	public class Lua
	{
		// 版本宏
		public static function get LUA_VERSION_MAJOR():String { return _wrap_LUA_VERSION_MAJOR(); }
		public static function get LUA_VERSION_MINOR():String { return _wrap_LUA_VERSION_MINOR(); }
		public static function get LUA_VERSION():String { return _wrap_LUA_VERSION(); }
		public static function get LUA_RELEASE():String { return _wrap_LUA_RELEASE(); }
		public static function get LUA_COPYRIGHT():String { return _wrap_LUA_COPYRIGHT(); }
		public static function get LUA_AUTHORS():String { return _wrap_LUA_AUTHORS(); }
		public static function get LUA_SIGNATURE():String { return _wrap_LUA_SIGNATURE(); }
		public static function get LUA_VERSION_NUM() : int{ return _wrap_LUA_VERSION_NUM(); }

		//
		public static function get LUA_ERRERR():int { return _wrap_LUA_ERRERR(); }
		public static function get LUA_MULTRET():int { return _wrap_LUA_MULTRET(); }

		// 類型值
		public static function get LUA_TNONE():int { return _wrap_LUA_TNONE(); }
		public static function get LUA_TNIL():int { return _wrap_LUA_TNIL(); }
		public static function get LUA_TBOOLEAN():int { return _wrap_LUA_TBOOLEAN(); }
		public static function get LUA_TLIGHTUSERDATA():int { return _wrap_LUA_TLIGHTUSERDATA(); }
		public static function get LUA_TNUMBER():int { return _wrap_LUA_TNUMBER(); }
		public static function get LUA_TSTRING():int { return _wrap_LUA_TSTRING(); }
		public static function get LUA_TTABLE():int { return _wrap_LUA_TTABLE(); }
		public static function get LUA_TFUNCTION():int { return _wrap_LUA_TFUNCTION(); }
		public static function get LUA_TUSERDATA():int { return _wrap_LUA_TUSERDATA(); }

		//
		public static function get LUAL_NUMSIZES():int { return _wrap_LUAL_NUMSIZES(); }

		//
		public static function lua_newstate(f:Function, ud:Number) : Number
		{
			return _wrap_lua_newstate(f, ud);
		}

		public static function lua_close(L:Number) : void 
		{
			_wrap_lua_close(L);
		}

		public static function lua_version(L:Number) : Number 
		{
			return _wrap_lua_version(L);
		}

		public static function lua_absindex(L:Number, idx:int) : int 
		{
			return _wrap_lua_absindex(L, idx);
		}

		public static function lua_gettop(L:Number) : int 
		{
			return _wrap_lua_gettop(L);
		}

		public static function lua_settop(L:Number, idx:int) : void 
		{
			_wrap_lua_settop(L, idx);
		}

		public static function lua_pushvalue(L:Number, idx:int) : void 
		{
			_wrap_lua_pushvalue(L, idx);
		}

		public static function lua_checkstack(L:Number, sz:int) : int 
		{
			return _wrap_lua_checkstack(L, sz);
		}

		public static function lua_isnumber(L:Number, idx:int) : int 
		{
			return _wrap_lua_isnumber(L, idx);
		}

		public static function lua_isstring(L:Number, idx:int) : int 
		{
			return _wrap_lua_isstring(L, idx);
		}

		public static function lua_iscfunction(L:Number, idx:int) : int 
		{
			return _wrap_lua_iscfunction(L, idx);
		}

		public static function lua_isuserdata(L:Number, idx:int) : int 
		{
			return _wrap_lua_isuserdata(L, idx);
		}

		public static function lua_type(L:Number, idx:int) : int 
		{
			return _wrap_lua_type(L, idx);
		}

		public static function lua_typename(L:Number, tp:int) : String 
		{
			return _wrap_lua_typename(L, tp);
		}

		public static function lua_tonumberx(L:Number, idx:int, isnum:int) : Number 
		{
			return _wrap_lua_tonumberx(L, idx, isnum);
		}

		public static function lua_tointegerx(L:Number, idx:int, isnum:int) : * 
		{
			return _wrap_lua_tointegerx(L, idx, isnum);
		}

		public static function lua_toboolean(L:Number, idx:int) : int 
		{
			return _wrap_lua_toboolean(L, idx);
		}

		public static function lua_tolstring(L:Number, idx:int, len:int) : String 
		{
			return _wrap_lua_tolstring(L, idx, len);
		}

		public static function lua_tocfunction(L:Number, idx:int) : Function 
		{
			return _wrap_lua_tocfunction(L, idx);
		}

		public static function lua_touserdata(L:Number, idx:int) : Number
		{
			return _wrap_lua_touserdata(L, idx);
		}

		public static function lua_topointer(L:Number, idx:int) : Number 
		{
			return _wrap_lua_topointer(L, idx);
		}

		public static function lua_pushnil(L:Number) : void 
		{
			_wrap_lua_pushnil(L);
		}

		public static function lua_pushnumber(L:Number, n:Number) : void 
		{
			_wrap_lua_pushnumber(L, n);
		}

		public static function lua_pushinteger(L:Number, n:*) : void 
		{
			_wrap_lua_pushinteger(L, n);
		}

		public static function lua_pushlstring(L:Number, s:String, l:*) : String 
		{
			return _wrap_lua_pushlstring(L, s, l);
		}

		public static function lua_pushstring(L:Number, s:String) : String 
		{
			return _wrap_lua_pushstring(L, s);
		}

		public static function lua_pushcclosure(L:Number, fn:Function, n:int) : void 
		{
			_wrap_lua_pushcclosure(L, fn, n);
		}

		public static function lua_pushboolean(L:Number, b:int) : void 
		{
			_wrap_lua_pushboolean(L, b);
		}

		public static function lua_pushlightuserdata(L:Number, p:Number) : void 
		{
			_wrap_lua_pushlightuserdata(L, p);
		}

		public static function lua_getglobal(L:Number, varname:String) : void 
		{
			_wrap_lua_getglobal(L, varname);
		}

		public static function lua_gettable(L:Number, idx:int) : void 
		{
			_wrap_lua_gettable(L, idx);
		}

		public static function lua_getfield(L:Number, idx:int, k:String) : void 
		{
			_wrap_lua_getfield(L, idx, k);
		}

		public static function lua_createtable(L:Number, narr:int, nrec:int) : void 
		{
			_wrap_lua_createtable(L, narr, nrec);
		}

		public static function lua_newuserdata(L:Number, sz:Number) : Number
		{
			return _wrap_lua_newuserdata(L, sz);
		}

		public static function lua_getmetatable(L:Number, objindex:int) : int 
		{
			return _wrap_lua_getmetatable(L, objindex);
		}

		public static function lua_getuservalue(L:Number, idx:int) : void 
		{
			_wrap_lua_getuservalue(L, idx);
		}

		public static function lua_setglobal(L:Number, varname:String) : void 
		{
			_wrap_lua_setglobal(L, varname);
		}

		public static function lua_settable(L:Number, idx:int) : void 
		{
			_wrap_lua_settable(L, idx);
		}

		public static function lua_setfield(L:Number, idx:int, k:String) : void 
		{
			_wrap_lua_setfield(L, idx, k);
		}

		public static function lua_setmetatable(L:Number, objindex:int) : int 
		{
			return _wrap_lua_setmetatable(L, objindex);
		}

		public static function lua_setuservalue(L:Number, idx:int) : void 
		{
			_wrap_lua_setuservalue(L, idx);
		}

		public static function lua_call(L:Number, nargs:int, nresults:int) : void 
		{
			_wrap_lua_callk(L, nargs, nresults, 0, null);
		}

		public static function lua_callk(L:Number, nargs:int, nresults:int, ctx:int, k:Function) : void 
		{
			_wrap_lua_callk(L, nargs, nresults, ctx, k);
		}

		public static function lua_pcall(L:Number, nargs:int, nresults:int, errfunc:int) : int 
		{
			return _wrap_lua_pcallk(L, nargs, nresults, errfunc, 0, null);
		}

		public static function lua_pcallk(L:Number, nargs:int, nresults:int, errfunc:int, ctx:int, k:Function) : int 
		{
			return _wrap_lua_pcallk(L, nargs, nresults, errfunc, ctx, k);
		}

		public static function lua_load(L:Number, reader:Function, dt:int, chunkname:String, mode:String) : int 
		{
			return _wrap_lua_load(L, reader, dt, chunkname, mode);
		}

		public static function lua_dump(L:Number, writer:Function, data:Number, strip:int) : int 
		{
			return _wrap_lua_dump(L, writer, data, strip);
		}

		public static function lua_next(L:Number, idx:int) : int 
		{
			return _wrap_lua_next(L, idx);
		}

		public static function lua_getstack(L:Number, leveL:Number, ar:int) : int 
		{
			return _wrap_lua_getstack(L, level, ar);
		}

		public static function lua_getinfo(L:Number, what:String, ar:int) : int 
		{
			return _wrap_lua_getinfo(L, what, ar);
		}

		public static function lua_getlocal(L:Number, ar:int, n:int) : String 
		{
			return _wrap_lua_getlocal(L, ar, n);
		}

		public static function lua_setlocal(L:Number, ar:int, n:int) : String 
		{
			return _wrap_lua_setlocal(L, ar, n);
		}

		public static function lua_getupvalue(L:Number, funcindex:int, n:int) : String 
		{
			return _wrap_lua_getupvalue(L, funcindex, n);
		}

		public static function lua_setupvalue(L:Number, funcindex:int, n:int) : String 
		{
			return _wrap_lua_setupvalue(L, funcindex, n);
		}

		public static function lua_pop(L:Number, n:int) : void 
		{
			_wrap_lua_pop(L, n);
		}

		//
		public static function luaL_newstate() : Number
		{
			return _wrap_luaL_newstate();
		}

		public static function luaL_openlibs(L:Number) : void 
		{
			_wrap_luaL_openlibs(L);
		}

		public static function luaopen_base(L:Number) : int 
		{
			return _wrap_luaopen_base(L);
		}

		public static function luaopen_string(L:Number) : int 
		{
			return _wrap_luaopen_string(L);
		}

		public static function luaopen_math(L:Number) : int 
		{
			return _wrap_luaopen_math(L);
		}

		public static function luaopen_debug(L:Number) : int 
		{
			return _wrap_luaopen_debug(L);
		}

		public static function luaopen_package(L:Number) : int 
		{
			return _wrap_luaopen_package(L);
		}

		//
		public static function luaL_checkversion(L:Number) : void 
		{
			_wrap_luaL_checkversion_(L, ver, LUA_VERSION_NUM, LUAL_NUMSIZES);
		}

		public static function luaL_getmetafield(L:Number, obj:int, e:String) : int 
		{
			return _wrap_luaL_getmetafield(L, obj, e);
		}

		public static function luaL_tolstring(L:Number, idx:int, len:int) : String 
		{
			return _wrap_luaL_tolstring(L, idx, len);
		}

		public static function luaL_argerror(L:Number, numarg:int, extramsg:String) : int 
		{
			return _wrap_luaL_argerror(L, numarg, extramsg);
		}

		public static function luaL_checklstring(L:Number, numArg:int, l:Number) : String 
		{
			return _wrap_luaL_checklstring(L, numArg, l);
		}

		public static function luaL_checknumber(L:Number, numArg:int) : Number 
		{
			return _wrap_luaL_checknumber(L, numArg);
		}

		public static function luaL_checkinteger(L:Number, numArg:int) : Number
		{
			return _wrap_luaL_checkinteger(L, numArg);
		}

		public static function luaL_checkstack(L:Number, sz:int, msg:String) : void 
		{
			_wrap_luaL_checkstack(L, sz, msg);
		}

		public static function luaL_checktype(L:Number, narg:int, t:int) : void 
		{
			_wrap_luaL_checktype(L, narg, t);
		}

		public static function luaL_checkany(L:Number, narg:int) : void 
		{
			_wrap_luaL_checkany(L, narg);
		}

		public static function luaL_newmetatable(L:Number, tname:String) : int 
		{
			return _wrap_luaL_newmetatable(L, tname);
		}

		public static function luaL_setmetatable(L:Number, tname:String) : void 
		{
			_wrap_luaL_setmetatable(L, tname);
		}

		public static function luaL_testudata(L:Number, ud:int, tname:String) : int 
		{
			return _wrap_luaL_testudata(L, ud, tname);
		}

		public static function luaL_checkudata(L:Number, ud:int, tname:String) : int 
		{
			return _wrap_luaL_checkudata(L, ud, tname);
		}

		public static function luaL_error(L:Number, fmt:String, arg3) : int 
		{
			return _wrap_luaL_error(L, fmt, arg3);
		}

		public static function luaL_checkoption(L:Number, narg:int, def:String, lst:int) : int 
		{
			return _wrap_luaL_checkoption(L, narg, def, lst);
		}

		public static function luaL_fileresult(L:Number, stat:int, fname:String) : int 
		{
			return _wrap_luaL_fileresult(L, stat, fname);
		}

		public static function luaL_execresult(L:Number, stat:int) : int 
		{
			return _wrap_luaL_execresult(L, stat);
		}

		public static function luaL_loadfile(L:Number, filename:String) : int 
		{
			return _wrap_luaL_loadfilex(L, filename, null);
		}	
		public static function luaL_loadfilex(L:Number, filename:String, mode:String) : int 
		{
			return _wrap_luaL_loadfilex(L, filename, mode);
		}	

		public static function luaL_loadstring(L:Number, s:String) : int 
		{
			return _wrap_luaL_loadstring(L, s);
		}

		public static function luaL_dofile(L:Number, filename:String) : int 
		{
			return (luaL_loadfile(L, filename) || lua_pcall(L, 0, LUA_MULTRET, 0));
		}
		public static function luaL_dostring(L:Number, s:String) : int 
		{
			return (luaL_loadstring(L, s) || lua_pcall(L, 0, LUA_MULTRET, 0));
		}	
	};
};