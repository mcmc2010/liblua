package
{
	import com.mxlib.ScriptContentLua;
	import com.mxlib.ScriptEvent;
	import com.mxlib.ScriptRead;
	
	import flash.display.Sprite;
	
	//
	public class samples extends Sprite
	{
		private var _scriptRead:ScriptRead;
		
		public var _test_number:Number = 0xFFFF;
		public var _test_int:Number = 1122334455;	
		public var _test_string:String = "DDDD";
		
		public function samples()
		{			
			this._scriptRead = new ScriptRead();
			
			//
			ScriptRead.Singleton.load("data/helloworld.lua", new ScriptContentLua(), function (e:ScriptEvent) : void {
			});
			
			ScriptRead.Singleton.load("data/helloflash.lua", new ScriptContentLua(), function (e:ScriptEvent) : void {
				var lua:ScriptContentLua = e.target.content;
				regclass(lua);
				
				var results:Array = [];
				lua.calling("Helloflash", [{type:"string", data:"the as3 string."}], results, 3);
			});
						
		}
		
		public function regclass(lua:ScriptContentLua) : void
		{
			lua.lua_state.luaAS3_newclassmetaByObject(this);
			lua.lua_state.luaAS3_newclassobject(this, "__this");
		}
	}
}