package com.mxlib
{
	//
	public class ScriptContentLines implements ScriptContentI
	{
		protected var _texts:Array;
		public function get RowCount() : int { return this._texts.length; }
		
		public function ScriptContentLines()
		{
			this._texts = null;
		}
		
		public virtual function load(text:String) : Boolean
		{
			// 對文本進行分行處理
			this._texts = text.split("\n");
			if(this._texts == null){ return false; }
			
			//
			if(!this.parse())
			{ return false; }
			
			//
			return true;
		}
		
		public function HasNull(text:String) : Boolean
		{
			return (text == null || text.length == 0);
		}
		
		public function HasComment(text:String) : Boolean
		{
			if(text.length <= 1){ return false; }
			
			if(text.charAt(0) == '/' && text.charAt(1) == '/')
			{ return true; }
			
 			return false;
		}
		
		// 必須對其進行重載
		public virtual function parse() : Boolean
		{
			return true;
		}
	}
}