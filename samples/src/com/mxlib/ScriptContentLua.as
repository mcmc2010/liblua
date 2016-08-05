package com.mxlib
{
	public class ScriptContentLua extends LuaScript implements ScriptContentI
	{
		public function ScriptContentLua()
		{
		}
		
		public virtual function load(text:String) : Boolean
		{			
			//
			if(!this.loadText(text))
			{ return false; }
			
			//
			if(!this.parse())
			{ return false; }
			
			//
			return true;
		}
		
		// 必須對其進行重載
		public virtual function parse() : Boolean
		{
			if(!this.doing())
			{ return false; }
			
			return true;
		}
	}
}