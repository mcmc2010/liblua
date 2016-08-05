package com.mxlib
{
	public interface ScriptContentI
	{
		function load(text:String) : Boolean;
		function parse() : Boolean;
	}
}