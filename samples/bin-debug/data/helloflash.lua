
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
	return 123, "abcdef", text;
end