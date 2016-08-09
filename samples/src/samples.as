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
		public var _test_int:Number = 0xEEEE;	
		public var _test_string:String = "DDDD";
		
		public function samples()
		{			
			this._scriptRead = new ScriptRead();
			
			//
			ScriptRead.Singleton.load("data/helloworld.lua", new ScriptContentLua(), function (e:ScriptEvent) : void {
				var lua:ScriptContentLua = e.target.content;
				lua.lua_state.luaAS3_newclassmetaByObject(this);
				lua.lua_state.luaAS3_pushobject(this, "__this");
				
				var results:Array = [];
				lua.calling("Helloworld", null, results, 2);
			});
			
			ScriptRead.Singleton.load("data/helloflash.lua", new ScriptContentLua(), function () : void {
			});
						
		}
	}
}