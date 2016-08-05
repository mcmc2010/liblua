package com.mxlib
{
	public class ScriptExcel extends ScriptContentLines
	{		
		private var _hasHeader:Boolean = true;
		private var _baseRow:int;
		private var _offsetRow:int;
		private var _columnNames:Array;
		
		//默認有列頭
		public function ScriptExcel(has_header:Boolean = true)
		{
			super();
			
			this._hasHeader = has_header;
			
		}
		
		public override function parse() : Boolean
		{
			if(!super.parse())
			{ return false; }
			
			//
			this._baseRow = 0;
			this._offsetRow = 0;
			this._columnNames = null;
			if(this.RowCount == 0)
			{
				return true;
			}
			
			// 讀取列表頭
			if(this._hasHeader)
			{
				_columnNames = this.parseRow(0);
			}
			
			//
			return true;
		}
		
		public function next(row:ScriptExcelRow) : Boolean
		{
			if(this._hasHeader && row.columnNames == null)
			{ row.columnNames = this._columnNames; }
			
			row._currentRow = row._nextRow;
			row._realRow = this._baseRow + row._currentRow;
			row.valueTexts = this.parseRow(row._realRow);
			if(row.valueTexts == null)
			{
				return false;
			}
			
			row._nextRow = this._offsetRow;
			return true;
		}
		
		private function parseRow(row:int) : Array
		{			
			// 移除開始的空格和末尾的換行符
			// 檢測是否是注釋
			var text:String = null;
			do
			{
				if(row >= this.RowCount)
				{
					text = null;
					break;
				}
				
				text = this._texts[row]; row ++;
				for(var n:int = 0; n < text.length; n ++)
				{
					if(text.charAt(n) != ' ') //行首如果是空格,就移除.
					{
						if(n > 0){ text = text.substring(n); }
						break;
					}
				}
				for(var m:int = text.length - 1; m >= 0; m --)
				{
					if(text.charAt(m) == '\r' || text.charAt(m) == '\n')
					{ continue; }
					else
					{
						if(m > 0){ text = text.substring(0, m + 1); }
						break;
					}
				}
				
				//忽略空行
			}while(this.HasNull(text) || this.HasComment(text));
			
			//
			if(this._hasHeader == true && this._baseRow == 0)
			{ 
				this._baseRow = row;
				this._offsetRow  = 0;
			}
			else
			{
				this._offsetRow = row - this._baseRow;
			}
			
			// 分割行
			if(text == null)
			{
				return null;
			}
			
			var texts:Array = text.split('\t');
			if(texts == null){ return null; }
			
			//
			return texts;
		}
	}
}