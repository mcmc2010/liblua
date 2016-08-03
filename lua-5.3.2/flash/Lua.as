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

		}
	};

	// 用來操作LUA的基本類庫
	public class Lua
	{
/*		public static function lua_newstate(f:Function, ud:int) : Number
		{
			return _wrap_lua_newstate(f, ud);
		}

		public static function lua_close(L:int) : void 
		{
			_wrap_lua_close(L);
		}
	*/
	};
};