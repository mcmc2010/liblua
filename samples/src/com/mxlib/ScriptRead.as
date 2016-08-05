package com.mxlib
{
	import flash.events.EventDispatcher;

	//
	public class ScriptRead extends EventDispatcher
	{
		private static var _singleton:ScriptRead;
		public static function get Singleton() : ScriptRead { return _singleton; }

		//
		public function ScriptRead()
		{			
			super(); _singleton = this;
		}
		
		public function load(file:String, content:ScriptContentI = null, listener:Function = null) : Boolean
		{			
			//
			var loader:ScriptContentLoader =  new ScriptContentLoader();
			loader.addEventListener(ScriptEvent.COMPLETE, onComplete);
			if(!loader.load(file, content, listener))
			{ return false; }

			//
			return true;
		}
		
		protected function onComplete(event:ScriptEvent):void
		{
			// TODO Auto-generated method stub
			
			if(!ScriptParser.parse(event.target.data, event.target.content))
			{
				trace("[ScriptRead] parse error : " + event.target.url);
				return;
			}
		}
	}
}