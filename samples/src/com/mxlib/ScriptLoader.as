package com.mxlib
{
	//import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	//import flash.net.URLRequest;
	import node3D.parser.MyFileLoader;

	//
	public class ScriptLoader extends MyFileLoader//extends URLLoader
	{
		private var		_fileURL:String			= "";
		//private var		_fileDirectroy:String 	= "";
		//private var		_fileName:String 		= "";
		//private var 	_requestURL:URLRequest;
		
		public function get FileURL() : String { return this._fileURL; }
		//public function get FileDirectroy() : String { return this._fileDirectroy; }
		////public function get FileName() : String { return this._fileName; }
		//public function get RequestURL() : URLRequest{ return _requestURL; }
		
		public function ScriptLoader()
		{
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		override public function loadFile(file:String):void
		{
			_fileURL = file;
			super.loadFile(file);
		}
		/*public function loadFile(file:String) : Boolean
		{
			file			= file.replace(/\\/g, "/");
			
			_requestURL 	= new URLRequest(file);
			_fileURL		= _requestURL.url;
			_fileDirectroy	= _fileURL.substring(0,_fileURL.lastIndexOf("/") + 1);
			_fileName		= _fileURL.substring(_fileURL.lastIndexOf("/") + 1);
			
			super.load(_requestURL);
			return true;
		}*/
	}
}