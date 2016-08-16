//lua 腳本必須都是UTF8,暫不增加其它編碼的支持

package com.mxlib
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	import mxlib.Lua;
	import mxlib.Lua_State;
	
	//
	public class LuaScript
	{	
		//
		private var _lua_state:LuaStateT
		public function get lua_state() : LuaStateT { return this._lua_state; }
		
		private var _text:String;
		
		private var _has_loaded_successed:Boolean;
		private var _has_doing_successed:Boolean;
		private var _has_calling_successed:Boolean;		
		public function get has_loaded_successed() : Boolean { return this._has_loaded_successed; }		
		public function get has_doing_successed() : Boolean { return this._has_doing_successed; }
		public function get has_calling_successed() : Boolean { return this._has_calling_successed; }
		
		//
		public function LuaScript()
		{
			this._lua_state = new LuaStateT();

			//
			trace(Lua.LUA_VERSION);
			trace(Lua.LUA_COPYRIGHT);
		}
		
		public function dispose() : void
		{
			if(this._lua_state)
			{
				this._lua_state.dispose();
				this._lua_state = null;
			}
		}
		
		public function loadData(bytes:ByteArray) : Boolean
		{
			var text:String = "";
			
			bytes.endian = Endian.LITTLE_ENDIAN;
			var flag:uint = bytes.readUnsignedInt() & 0x00FFFFFF;
			if(flag == 0xBFBBEF)
			{ 
				text = bytes.readMultiByte(-1, "utf8"); //UTF8
			}
			else
			{
				text = bytes.readMultiByte(-1, "gb2312"); //ANSI
			}
			
			
			return loadText(text);
		}
		
		public function loadText(text:String) : Boolean
		{
			this._has_loaded_successed = false;
			this._has_doing_successed = false;
			
			this._text = text;
			
			if(!this.preLoad())
			{
				this._text = "";
				return false; 
			}
			
			try
			{
				//
				var stack:int 	= Lua.lua_gettop(this._lua_state.real_LuaState);
				var result:int	= Lua.luaL_loadstring(this._lua_state.real_LuaState, this._text);
				if(result != 0)
				{
					while((stack = Lua.lua_gettop(this._lua_state.real_LuaState)) > 0)
					{
						Logout("[LuaScript] ("+stack+") luaL_loadstring fail, code:" + result + ", desc:" + Lua.lua_tostring(this._lua_state.real_LuaState, -1));
						
						// 錯誤日誌緣故需要彈出1個元素
						Lua.lua_pop(this._lua_state.real_LuaState, 1);
					}
					
	
					return false;
				}
				
				stack = Lua.lua_gettop(this._lua_state.real_LuaState);
			}
			catch(e:Error)
			{
				trace("Exception: " + e.message);
				return false;
			}
			
			//
			if(!this.lastLoad())
			{ return false; }
			
			this._has_loaded_successed = true;
			return true;
		}
		
		public function doing() : Boolean
		{	
			this._has_doing_successed = false;

			try
			{
				//
				var stack:int 	= Lua.lua_gettop(this._lua_state.real_LuaState);
				
				var result:int	= Lua.lua_pcall(this._lua_state.real_LuaState, 0, Lua.LUA_MULTRET, 0);
				if(result != 0)
				{
					while((stack = Lua.lua_gettop(this._lua_state.real_LuaState)) > 0)
					{
						Logout("[LuaScript] ("+stack+") luaL_dostring fail, code:" + result + ", desc:" + Lua.lua_tostring(this._lua_state.real_LuaState, -1));
						
						// 錯誤日誌緣故需要彈出1個元素
						Lua.lua_pop(this._lua_state.real_LuaState, 1);
					} 
					
					return false;
				}
				
				//
				stack = Lua.lua_gettop(this._lua_state.real_LuaState);				
			}
			catch(e:Error)
			{
				trace("Exception: " + e.message);
				return false;
			}
			
			//
			this._has_doing_successed = true;
			return true;
		}
		
		public function calling(func:String, params:Array, results:Array = null, result_count:int = 0) : Boolean
		{
			this._has_calling_successed = false;
			
			try
			{
				//
				var stack:int 		= Lua.lua_gettop(this._lua_state.real_LuaState);
				var param_count:int	= 0;
				
				Lua.lua_getglobal(this._lua_state.real_LuaState, func); //函數名
				if(params != null)
				{
					for(var i:int = 0; i < params.length; i ++)
					{
						if(params[i] != null)
						{
							switch(( params[i].type as String ).toLowerCase())
							{
								case "nil":
								case "null": 		{ Lua.lua_pushnil(this._lua_state.real_LuaState); 		param_count ++; break; }
								case "int": 		{ Lua.lua_pushinteger(this._lua_state.real_LuaState, 	params[i].data); 	param_count ++; break; }
								case "float":
								case "number": 	{ Lua.lua_pushnumber(this._lua_state.real_LuaState, 	params[i].data); 	param_count ++; break; }
								case "string": 	{ Lua.lua_pushstring(this._lua_state.real_LuaState, 	params[i].data); 	param_count ++; break; }	
								case "object": 	{ this._lua_state.luaAS3_pushobject(params[i].data, null); param_count ++; break; }									
							}
						}
					}
				}
				
				Lua.lua_call(this._lua_state.real_LuaState, param_count, result_count);
				
				// 取結果的時候注意,负数返回結果順序是反著的。正数返回结果顺序是顺着的。
				// 负数时需要用unshift来颠倒压入数据顺序，才能对应返回值。
				if(results != null && result_count > 0)
				{
					stack = Lua.lua_gettop(this._lua_state.real_LuaState);
					
					var result_index:int = 0;
					while(stack > result_index)
					{
						if(Lua.lua_isnumber(this._lua_state.real_LuaState, (result_index + 1)))
						{
							results.push({type:"number",data:Lua.lua_tonumber(this._lua_state.real_LuaState, (result_index + 1))});
						}
						else if(Lua.lua_isstring(this._lua_state.real_LuaState, (result_index + 1)))
						{
							results.push({type:"string",data:Lua.lua_tostring(this._lua_state.real_LuaState, (result_index + 1))});
						}

						result_index ++;
					}
					
					Lua.lua_pop(this._lua_state.real_LuaState, result_index);
				}
				else
				{
					//如果沒有獲取返回值,但是又有返回需要處理:
					while((stack = Lua.lua_gettop(this._lua_state.real_LuaState)) > 0)
					{
						Lua.lua_pop(this._lua_state.real_LuaState, 1); //將返回值逐個彈出;
					}
				}
				
				//
				stack = Lua.lua_gettop(this._lua_state.real_LuaState)
			}
			catch(e:Error)
			{
				trace("Exception: " + e.message);
				return false;
			}
			
			//
			this._has_calling_successed = true;
			return true;
		}
		
		protected virtual function preLoad() : Boolean
		{
			var stack:int 	= Lua.lua_gettop(this._lua_state.real_LuaState);
		
			this._lua_state.luaAS3_newclassmetaByObjectL(this);
			this._lua_state.luaAS3_newclassobject(this, "__script", null);

			stack	= Lua.lua_gettop(this._lua_state.real_LuaState);
			return true;
		}
		
		
		protected virtual function lastLoad() : Boolean
		{
			return true;
		}
		
		protected virtual function callbackLog(text:String) : void
		{
			trace(text);
		}
		
		public function Logout(text:String) : void
		{
			this.callbackLog(text + "\n");
		}
		
		public function script_Logout(text:String) : void
		{
			this.callbackLog("[LuaScript][LuaCall] Logout :" + text + "\n");
		}
	};
	
}