
--
flash.trace(string.format("%s Hello world %s", "_T", "T_"));

-- Test function.
function Helloflash(text)

	--
	flash.trace(flash.gettimer());
	flash.trace(string.format("Lua ->:0x%X", flash.getnumber(__this, "_test_number")));
	flash.trace(string.format("Lua ->:%d", flash.getint(__this, "_test_int")));
	flash.trace(string.format("Lua ->:'%s'", flash.getstring(__this, "_test_string")));	

	--
	local temp = flash.getprop(__this, "_test_string");
	flash.trace("local object:", temp, " get object:", flash.getprop(__this, "_test_string"));	

	--
	flash.setnumber(__this, "_test_number", 1000);
	flash.setint(__this, "_test_int", 1100);
	flash.setstring(__this, "_test_string", "1200");

	--
	flash.setprop(__this, "_test_number", 2000);
	flash.setprop(__this, "_test_int", 2100);
	flash.setprop(__this, "_test_string", "2200");

	flash.setprop(__this, "_test_object", temp);
	--	
	return 123, "abcdef", text;
end