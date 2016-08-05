/*
** ADOBE SYSTEMS INCORPORATED
** Copyright 2012 Adobe Systems Incorporated
** All Rights Reserved.
**
** NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the
** terms of the Adobe license agreement accompanying it.  If you have received this file from a
** source other than Adobe, then your use, modification, or distribution of it requires the prior
** written permission of Adobe.
*/
#ifdef SWIG

%module LuaLibModule

//將lua的狀態機指針，轉換成NUMBER存放，按8字節來處理
%typemap(astype) 	lua_State* 	"Number";
%typemap(in) 		lua_State* 	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 	lua_State*
{
    AS3_DeclareVar($result, Number);
    AS3_CopyScalarToVar($result, $1);
}

%{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "AS3/AS3.h"

int 	main() 
{ 
	AS3_GoAsync(); 
}

%}

%include "lua.h"
%include "lauxlib.h"
%include "lualib.h"

#else //SWIG

#define  SWIGPP
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#endif //SWIG
