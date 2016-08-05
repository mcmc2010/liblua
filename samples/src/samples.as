package
{
	import flash.display.Sprite;
	
	import mxlib.Lua;
	import mxlib.Lua_State;
	
	public class samples extends Sprite
	{
		private var _lua_State:Lua_State;
		
		public function samples()
		{			
			this._lua_State = new Lua_State(true);
			
			trace(Lua.LUA_VERSION);
			trace(Lua.LUA_COPYRIGHT);
			
			this._lua_State.dispose();
			this._lua_State = null;
		}
	}
}