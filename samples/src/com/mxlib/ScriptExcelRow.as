package com.mxlib
{
	import flash.utils.Dictionary;

	public class ScriptExcelRow
	{
		internal var _realRow:int;
		internal var _currentRow:int;
		internal var _nextRow:int;
		private var _columnCount:int;
		private var _columnNames:Array;
		private var _columnIndexByName:Dictionary;
		private var _valueTexts:Array;
		
		public function get ColumnCount() : int { return this._columnCount; }
		internal function get columnNames() : Array { return this._columnNames; }
		internal function set columnNames(names:Array) : void
		{
			this._columnNames	= names;
			this._columnCount	= names.length;
			
			this._columnIndexByName = new Dictionary();
			for(var i:int = 0; i < this._columnCount; i ++)
			{ this._columnIndexByName[this._columnNames[i]] = i; }
		}
		
		internal function get valueTexts() : Array { return this._valueTexts; }
		internal function set valueTexts(texts:Array) : void
		{
			if(texts == null)
			{
				this._valueTexts = null;
				return;
			}
			else if(texts.length < this._columnNames.length)
			{
				this._valueTexts = null;
				trace("[ScriptExcelRow] row values count("+ texts.length + "<" + this._columnNames.length + ") error.");
				return ;
			}
			else if(texts.length > this._columnNames.length)
			{
				trace("[ScriptExcelRow] row values count("+ texts.length + ">" + this._columnNames.length + ") different.");
			}
			
			this._valueTexts = texts;
		}
		
		public function ScriptExcelRow()
		{
			this._realRow		= 0;
			this._currentRow 	= 0;
			this._nextRow		= 0;
			
			this._columnCount	= 0;
			this._columnNames	= null;
			this._columnIndexByName = null;

			this._valueTexts 	= null;
		}
		
		private function getIndexByName(name:String) : int
		{
			if(this._columnIndexByName == null)
			{
				throw "[ScriptExcelRow] column names is null";
				return -1;
			}
			
			var index:int = this._columnIndexByName[name];
			return index;
		}
		
		public function getTextByIndex(index:int) : String
		{
			if(this._valueTexts == null)
			{
				throw "[ScriptExcelRow] value texts is null";
				return null;
			}
			
			if(index < 0 || index >= this._valueTexts.length) //沒有此列 
			{ return null; }
			
			var text:String = this._valueTexts[index];
			if(text.length == 0) { return ""; } //此列為空 
			
			return text;
		}
		
		public function getTextByName(name:String) : String
		{
			var index:int = this.getIndexByName(name);
			return this.getTextByIndex(index);
		}
		
		public function getIntByIndex(index:int) : int
		{		
			var text:String = this.getTextByIndex(index);
			return text == null ? 0 : parseInt(text, 10);
		}
		
		public function getIntByName(name:String) : int
		{
			var index:int = this.getIndexByName(name);
			return this.getIntByIndex(index);
		}
		
		public function getUIntByIndex(index:int) : uint
		{			
			var text:String = this.getTextByIndex(index);
			return text == null ? 0 : parseInt(text, 10);
		}
		
		public function getUIntByName(name:String) : uint
		{
			var index:int = this.getIndexByName(name);
			return this.getUIntByIndex(index);
		}
		
		public function getFloatByIndex(index:int) : Number
		{
			var text:String = this.getTextByIndex(index);
			return text == null ? 0.0 : parseFloat(text);
		}
		
		public function getFloatByName(name:String) : Number
		{
			var index:int = this.getIndexByName(name);
			return this.getFloatByIndex(index);
		}
		
		public function getBooleanByIndex(index:int) : Boolean
		{
			//如果是true或任何大於0的數字都代表true.
			var text:String = this.getTextByIndex(index);
			if(text.toLowerCase() == "true" || parseInt(text, 10) > 0)
			{
				return true;
			}
			return false;
		}
		
		public function getBooleanByName(name:String) : Boolean
		{
			var index:int = this.getIndexByName(name);
			return this.getBooleanByIndex(index);
		}
	}
}