package com.mxlib
{
	import flash.events.Event;

	public class ScriptEvent extends Event
	{
		public static const COMPLETE:String = "ScriptEvent_Complete";
		
		public function ScriptEvent(type:String)
		{
			super(type);
		}
	}
}