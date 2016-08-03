package com.adobe.flascc.swig 
{
	import flash.utils.Dictionary;
	import com.adobe.flascc.CModule;
};

package mxlib
{
	import com.adobe.flascc.swig.*;
	import flash.utils.ByteArray;

	// 用來存放LUA的狀態機
	public class Lua_State
	{
		private var _real_LuaState:Number = 0;
		public function get real_LuaState() : Number { return this._real_LuaState;  }
		public function Lua_State()
		{
			this._real_LuaState = Lua.luaL_newstate();
			Lua.luaL_openlibs(this._real_LuaState);
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

		//
		public static function luaL_newstate() : Number 
		{
			return _wrap_luaL_newstate();
		}

		public static function luaL_openlibs(L:Number) : void 
		{
			_wrap_luaL_openlibs(L);
		}
	};
};