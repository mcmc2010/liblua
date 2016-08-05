package com.mxlib
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	//
	public class ScriptContentLoader extends EventDispatcher
	{
		private var _loader:ScriptLoader;
		public function get loader() : ScriptLoader{ return this._loader; }
		
		private var _data:*;
		public function get data() : * { return this._data; }
		public function get url() : String { return this._loader ? this._loader.FileURL : ""; }
		
		private var _content:ScriptContentI;
		public function get content() : ScriptContentI { return this._content; }
		
		private var _function:Function;
		
		public function ScriptContentLoader()
		{
			super();
			
			this._loader		= null;
			this._data			= null;
			
			this._content		= null;
			this._function		= null;
		}
		
		public function load(file:String, content:ScriptContentI = null, listener:Function = null) : Boolean
		{
			this._content	= content;
			this._function	= listener;
			
			this._loader =  new ScriptLoader();
			this._loader.addEventListener(Event.COMPLETE, onComplete);
			if(!this._loader.loadFile(file)){ return false; }
			
			//
			return true;
		}
		
		protected function onComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			if(event.target.data == null)
			{ 
				trace("[ScriptContentLoader] load error : " + event.target.FileURL);
				return ; 
			}
			
			// 做最初級的轉碼
			if(!this.decode(event.target.data))
			{
				trace("[ScriptContentLoader] decode error : " + event.target.FileURL);
				return ;
			}
			
			// 執行事件觸發器,用來完成最後的事件處理
			var script_event:ScriptEvent = new ScriptEvent(ScriptEvent.COMPLETE);
			if(this.hasEventListener(ScriptEvent.COMPLETE))
			{ this.dispatchEvent(script_event); }
			
			// 最後執行用戶指定回調函數:
			if(this._function != null)
			{ this._function(script_event); }
		}
		
		protected function decode(bytes:ByteArray) : Boolean
		{
			bytes.endian	= Endian.LITTLE_ENDIAN;
			
			var flag:uint = 0;
			flag = bytes.readUnsignedShort();
			if((flag & 0xFFFF) == 0xFEFF)
			{
				bytes.position = 2;
				this._data = bytes.readMultiByte(bytes.length - 2, "UNICODE");
			}
			else
			{
				bytes.position = 0;
				flag = bytes.readUnsignedInt();
				if((flag & 0x00FFFFFF) == 0xBFBBEF)
				{
					bytes.position = 3;
					this._data = bytes.readMultiByte(bytes.length - 3, "UTF-8");
				}
				else
				{
					bytes.position = 0;
					this._data = bytes.readMultiByte(bytes.length, "GB2312");
				}
			}
			return true;
		}
	}
}