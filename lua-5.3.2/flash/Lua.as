package com.adobe.flascc.swig 
{
	import flash.utils.Dictionary;
	import com.adobe.flascc.CModule;
};

package  mxlib.lua
{
	import flash.utils.Dictionary;
	public const __lua_state_list:Dictionary = new Dictionary();
};

package mxlib
{
	// 必須加這個，C++的代理函數被放在這個包下面
	import C_Run.*;

	//
	import com.adobe.flascc.swig.*;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	// 用來存放LUA的狀態機
	public class Lua_State
	{
		private var _real_LuaState:Number = 0;
		public function get real_LuaState() : Number { return this._real_LuaState;  }
		private var _real_ObjectList:Dictionary = new Dictionary();
		public function get real_ObjectList() : Dictionary { return this._real_ObjectList; }

		public function Lua_State(open_all:Boolean = true)
		{
			trace("[Lua_State] ------ init ------");

			this._real_LuaState = Lua.luaL_newstate();
			if(open_all)
			{ 
				Lua.luaL_open_all_libs(this._real_LuaState); 
				
				trace("[Lua_State] open all librarys.");
			}
			else
			{
				Lua.luaL_open_min_libs(this._real_LuaState);

				trace("[Lua_State] open min librarys.");
			}

			// add lua state machine to global list.
			__lua_state_list[_real_LuaState] = this;
		}

		public function dispose() : void
		{
			if(this._real_LuaState != 0)
			{
				if(__lua_state_list[_real_LuaState] != null)
				{ delete __lua_state_list[_real_LuaState]; }

				//
				Lua.lua_close(this._real_LuaState);
				this._real_LuaState = 0;

				//
				this._real_ObjectList = null;
			}

			trace("[Lua_State] ------ free ------");
		}

		public function luaAS3_newclassmeta(type_name:String) : void
		{
			Lua.flash_newclassmeta(this.real_LuaState, type_name);

			trace("[Lua_State] : new class meta : " + type_name);
		}
		
		public function luaAS3_newclassmetaByObject(object_refer:*) : void
		{
			var type_name:String = getQualifiedClassName(object_refer);
			this.luaAS3_newclassmeta(type_name);
		}
			
		public function luaAS3_pushobject(object_refer:*, object_name:String, type_name:String = null) : void
		{
			var type:String = (type_name != null ? type_name : getQualifiedClassName(object_refer));
			var data:Number = Lua.flash_pushreference(this.real_LuaState, type);
			if(data != 0)
			{
				this._real_ObjectList[data] = object_refer;
			}
			Lua.lua_setglobal(this.real_LuaState, object_name);

			trace("[Lua_State] : new class meta : " + type + ":-> object : " + object_name);
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
		public static function get LUA_NOREF():int { return _wrap_LUA_NOREF(); }
		public static function get LUA_REFNIL():int { return _wrap_LUA_REFNIL(); }

		//
		public static function lua_version(L:Number) : Number 
		{
			return _wrap_lua_version(L);
		}

		public static function lua_newstate(f:Function, ud:Number) : Number
		{
			return _wrap_lua_newstate(f, ud);
		}
		public static function lua_close(L:Number) : void 
		{
			_wrap_lua_close(L);
		}
		public static function lua_pop(L:Number, n:int) : void 
		{
			_wrap_lua_pop(L, n);
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
		public static function lua_checkstack(L:Number, n:int) : int 
		{
			return _wrap_lua_checkstack(L, n);
		}

		public static function lua_type(L:Number, idx:int) : int 
		{
			return _wrap_lua_type(L, idx);
		}
		public static function lua_typename(L:Number, tp:int) : String 
		{
			return _wrap_lua_typename(L, tp);
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



		public static function lua_tonumber(L:Number, idx:int) : Number 
		{
			return _wrap_lua_tonumber(L, idx);
		}
		public static function lua_tointeger(L:Number, idx:int) : int 
		{
			return _wrap_lua_tointeger(L, idx);
		}
		public static function lua_toboolean(L:Number, idx:int) : int 
		{
			return _wrap_lua_toboolean(L, idx);
		}
		public static function lua_tostring(L:Number, idx:int) : String 
		{
			return _wrap_lua_tostring(L, idx);
		}


		public static function lua_pushnil(L:Number) : void 
		{
			_wrap_lua_pushnil(L);
		}
		public static function lua_pushnumber(L:Number, n:Number) : void 
		{
			_wrap_lua_pushnumber(L, n);
		}
		public static function lua_pushinteger(L:Number, n:int) : void 
		{
			_wrap_lua_pushinteger(L, n);
		}
		public static function lua_pushstring(L:Number, s:String) : String 
		{
			return _wrap_lua_pushstring(L, s);
		}
		public static function lua_pushboolean(L:Number, b:int) : void 
		{
			_wrap_lua_pushboolean(L, b);
		}
		public static function lua_pushvalue(L:Number, idx:int) : void 
		{
			_wrap_lua_lua_pushvalue(L, idx);
		}

		public static function lua_createtable(L:Number, narr:int, nrec:int) : void 
		{
			_wrap_lua_createtable(L, narr, nrec);
		}
		public static function lua_newtable(L:Number) : void 
		{
			_wrap_lua_newtable(L);
		}		
		public static function lua_newuserdata(L:Number, sz:uint) : Number
		{
			return _wrap_lua_newuserdata(L, sz);
		}

		public static function lua_getglobal(L:Number, name:String) : int
		{
			return _wrap_lua_getglobal(L, name);
		}
		public static function lua_gettable(L:Number, idx:int) : int
		{
			return _wrap_lua_gettable(L, idx);
		}
		public static function lua_getfield(L:Number, idx:int, k:String) : int
		{
			return _wrap_lua_getfield(L, idx, k);
		}
		public static function lua_getmetatable(L:Number, objindex:int) : int 
		{
			return _wrap_lua_getmetatable(L, objindex);
		}



		public static function lua_setglobal(L:Number, name:String) : void 
		{
			_wrap_lua_setglobal(L, name);
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

		public static function lua_call(L:Number, nargs:int, nresults:int) : void 
		{
			_wrap_lua_call(L, nargs, nresults);
		}
		public static function lua_pcall(L:Number, nargs:int, nresults:int, errfunc:int) : int 
		{
			return _wrap_lua_pcall(L, nargs, nresults, errfunc);
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
		public static function luaL_open_all_libs(L:Number) : void 
		{
			_wrap_luaL_open_all_libs(L);
		}
		public static function luaL_open_min_libs(L:Number) : void 
		{
			_wrap_luaL_open_min_libs(L);
		}

		//
		public static function luaL_loadfile(L:Number, filename:String) : int 
		{
			return _wrap_luaL_loadfile(L, filename);
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

		public static function luaL_newmetatable(L:Number, name:String) : int
		{
			return _wrap_luaL_newmetatable(L, name);
		}
		public static function luaL_getmetatable(L:Number, name:String) : int
		{
			return _wrap_luaL_getmetatable(L, name);
		}
		public static function luaL_setmetatable(L:Number, name:String) : void 
		{
			_wrap_luaL_setmetatable(L, name);
		}


		//
		public static function flash_newclassmeta(L:Number, name:String) : int 
		{
			return _wrap_flash_newclassmeta(L, name);
		}	
		public static function flash_pushreference(L:Number, name:String) : int 
		{
			return _wrap_flash_pushreference(L, name);
		}		
	};
};