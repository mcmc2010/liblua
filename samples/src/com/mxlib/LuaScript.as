//lua 腳本必須都是UTF8,暫不增加其它編碼的支持

package com.mxlib
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	import mxlib.Lua;
	import mxlib.Lua_State;
	import mxlib.lua.__lua_state_list;
	
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
								case "null": 	{ Lua.lua_pushnil(this._lua_state.real_LuaState); 		param_count ++; break; }
								case "int": 	{ Lua.lua_pushinteger(this._lua_state.real_LuaState, 	params[i].data); 	param_count ++; break; }
								case "float":
								case "number": 	{ Lua.lua_pushnumber(this._lua_state.real_LuaState, 	params[i].data); 	param_count ++; break; }
								case "string": 	{ Lua.lua_pushstring(this._lua_state.real_LuaState, 	params[i].data); 	param_count ++; break; }	
//								case "object": 	
//								{ 
//									this._lua_state.luaAS3_newclassmeta(params[i].data);
//									this._lua_state.luaAS3_pushobject(params[i].data, "");							
//									param_count ++; 
//									break; 
//								}									
							}
						}
					}
				}
				
				Lua.lua_call(this._lua_state.real_LuaState, param_count, result_count);
				
				// 取結果的時候注意,返回結果順序是反著的
				if(results != null && result_count > 0)
				{
					stack = Lua.lua_gettop(this._lua_state.real_LuaState);
					
					var result_index:int = 0;
					while(stack > result_index)
					{
						if(Lua.lua_isnumber(this._lua_state.real_LuaState, -(result_index + 1)))
						{
							results.unshift({type:"number",data:Lua.lua_tonumber(this._lua_state.real_LuaState, -(result_index + 1))});
						}
						else if(Lua.lua_isstring(this._lua_state.real_LuaState, -(result_index + 1)))
						{
							results.unshift({type:"string",data:Lua.lua_tostring(this._lua_state.real_LuaState, -(result_index + 1))});
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
		
			this._lua_state.luaAS3_newclassmetaByObject(this);
			this._lua_state.luaAS3_pushobject(this, "__script", null);

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
		
		public function Script_Logout(text:String) : void
		{
			this.callbackLog("[LuaScript][LuaCall] Logout :" + text + "\n");
		}
	};
	
	/*
	import Lua;
	
	import sample.lua.CModule;
	import sample.lua.__lua_objrefs;
	
	//
	public class LuaScript
	{		
		//
		private var _lua_state:Number;
		public function get lua_state() : Number { return this._lua_state; };
		
		private var _text:String;
		
		private var _lua_obj_refs:Array;
		
		private var _has_loaded_successed:Boolean;
		private var _has_doing_successed:Boolean;
		private var _has_calling_successed:Boolean;		
		public function get has_loaded_successed() : Boolean { return this._has_loaded_successed; }		
		public function get has_doing_successed() : Boolean { return this._has_doing_successed; }
		public function get has_calling_successed() : Boolean { return this._has_calling_successed; }
		
		//
		public function LuaScript()
		{
			this._lua_state = Lua.luaL_newstate();
			Lua.luaL_openlibs(_lua_state);
			
			this._lua_obj_refs = [];
			if(sample.lua.__lua_objrefs == null)
			{ sample.lua.__lua_objrefs = new Dictionary(); }
		}
		
		public function dispose() : void
		{
			if(this._lua_state != 0)
			{
				Lua.lua_close(this._lua_state);
				this._lua_state = 0;
			}
			
			if(sample.lua.__lua_objrefs != null)
			{
				for each(var obj:* in this._lua_obj_refs)
				{
					if(obj != null && sample.lua.__lua_objrefs[obj.index] != null)
					{ delete sample.lua.__lua_objrefs[obj.index]; }
				}
				this._lua_obj_refs = null;
			}
		}
		
		public function lua_pushflashobject(object:*) : void
		{
			var result:int = Lua.push_flashref(this._lua_state);
			
			this._lua_obj_refs.push({index:result, object:object});
			sample.lua.__lua_objrefs[result] = object;
		}
		
		public function registerClass(name:String, object:*) : Boolean
		{
			//
			this.lua_pushflashobject(object);
			Lua.lua_setglobal(this._lua_state, name);
			return true;
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
			
			//
			var stack:int 	= Lua.lua_gettop(this._lua_state);
			var result:int	= Lua.luaL_loadstring(this._lua_state, this._text);
			if(result != 0)
			{
				AS3_Logout("[LuaScript] luaL_loadstring fail, code:" + result + ", desc:" + Lua.lua_tolstring(this._lua_state, -1, 0));
				
				// 錯誤日誌緣故需要彈出1個元素
				Lua.lua_pop(this._lua_state, 1);
				return false;
			}
			
			stack = Lua.lua_gettop(this._lua_state);
			
			//
			if(!this.lastLoad())
			{ return false; }
			
			this._has_loaded_successed = true;
			return true;
		}
		
		protected virtual function preLoad() : Boolean
		{
			var stack:int 	= Lua.lua_gettop(this._lua_state);
			
//			// 註冊自己到腳本狀態機
//			Lua.luaL_newmetatable(this._lua_state, "LuaScript");
//			Lua.lua_pushstring(this._lua_state, "__index");		//設置表項
//			Lua.lua_pushvalue(this._lua_state, -2); 
//			Lua.lua_settable(this._lua_state, -3);
//			
//			//
//			Lua.lua_pop(this._lua_state, 1);
			
			//
			this.lua_pushflashobject(this);
			Lua.lua_setglobal(this._lua_state, "__script");
			
			stack	= Lua.lua_gettop(this._lua_state);
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
		
		public function doing() : Boolean
		{	
			this._has_doing_successed = false;
			
			try
			{
				//
				var stack:int 	= Lua.lua_gettop(this._lua_state);
				
				var result:int	= Lua.lua_pcallk(this._lua_state, 0, Lua.LUA_MULTRET, 0, 0, null);
				if(result != 0)
				{
					while((stack = Lua.lua_gettop(this._lua_state)) > 0)
					{
						AS3_Logout("[LuaScript] ("+stack+") luaL_dostring fail, code:" + result + ", desc:" + Lua.lua_tolstring(this._lua_state, -1, 0));
					
						// 錯誤日誌緣故需要彈出1個元素
						Lua.lua_pop(this._lua_state, 1);
					} 
						
					return false;
				}
				
				//
				stack = Lua.lua_gettop(this._lua_state)
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
				var stack:int 		= Lua.lua_gettop(this._lua_state);
				var param_count:int	= 0;
				
				Lua.lua_getglobal(this._lua_state, func); //函數名
				if(params != null)
				{
					for(var i:int = 0; i < params.length; i ++)
					{
						if(params[i] != null)
						{
							switch(( params[i].type as String ).toLowerCase())
							{
								case "nil":
								case "null": 	{ Lua.lua_pushnil(this._lua_state); 					param_count ++; break; }
								case "int": 	//{ Lua.lua_pushinteger(this._lua_state, params[i].data); param_count ++; break; } //整數參數有問題,故統一為number
								case "float":
								case "number": 	{ Lua.lua_pushnumber(this._lua_state, params[i].data); 	param_count ++; break; }
								case "string": 	{ Lua.lua_pushstring(this._lua_state, params[i].data); 	param_count ++; break; }	
								case "object": 	{ this.lua_pushflashobject(params[i].data); 			param_count ++; break; }									
							}
						}
					}
				}
							
				Lua.lua_callk(this._lua_state, param_count, result_count, 0, null);
				
				// 取結果的時候注意,返回結果順序是反著的
				if(results != null && result_count > 0)
				{
					stack = Lua.lua_gettop(this._lua_state);
					
					var result_index:int = 0;
					while(stack > result_index)
					{
						if(Lua.lua_isnumber(this._lua_state, -(result_index + 1)))
						{
							results.unshift({type:"number",data:Lua.lua_tonumberx(this._lua_state, -(result_index + 1), 0)});
						}
						else if(Lua.lua_isstring(this._lua_state, -(result_index + 1)))
						{
							results.unshift({type:"string",data:Lua.lua_tolstring(this._lua_state, -(result_index + 1), 0)});
						}
						
						result_index ++;
					}
					
					Lua.lua_pop(this._lua_state, result_index);
				}
				else
				{
					//如果沒有獲取返回值,但是又有返回需要處理:
					while((stack = Lua.lua_gettop(this._lua_state)) > 0)
					{
						Lua.lua_pop(this._lua_state, 1); //將返回值逐個彈出;
					}
				}
				
				//
				stack = Lua.lua_gettop(this._lua_state)
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
		
		public function AS3_Logout(text:String) : void
		{
			this.callbackLog(text + "\n");
		}
		
		public function Logout(text:String) : void
		{
			this.callbackLog("[LuaScript] Logout :" + text + "\n");
		}
	}
	*/
}