package com.mxlib
{
	import mxlib.Lua_State;

	//
	public class LuaStateT extends Lua_State
	{
		public function LuaStateT(open_all_libs:Boolean = true)
		{
			super(open_all_libs);
		}
	}
}