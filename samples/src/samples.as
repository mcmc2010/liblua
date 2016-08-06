package
{
	import com.mxlib.ScriptContentLua;
	import com.mxlib.ScriptRead;
	
	import flash.display.Sprite;
	
	//
	public class samples extends Sprite
	{
		private var _scriptRead:ScriptRead;
		
		public function samples()
		{			
			this._scriptRead = new ScriptRead();
			
			//
			ScriptRead.Singleton.load("data/helloworld.lua", new ScriptContentLua(), function () : void {
			});
		}
	}
}