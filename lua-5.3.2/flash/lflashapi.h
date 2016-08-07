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

//
%typemap(astype) 	void* 	"Number";
%typemap(in) 		void* 	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 	void*
{
    AS3_DeclareVar($result, Number);
    AS3_CopyScalarToVar($result, $1);
}

//x32 为uint32, x64 为uint64
%typemap(astype) 	size_t 	"uint";
%typemap(in) 		size_t
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 	size_t
{
    AS3_DeclareVar($result, uint);
    AS3_CopyScalarToVar($result, $1);
}

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

//
%typemap(astype) 	lua_Number	"Number";
%typemap(in) 		lua_Number	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 		lua_Number
{
    AS3_DeclareVar($result, Number);
    AS3_CopyScalarToVar($result, $1);
}

//
%typemap(astype) 	lua_Integer	"int";
%typemap(in) 		lua_Integer	
{ 
	AS3_GetScalarFromVar($1, $input); 
}
%typemap(out) 		lua_Integer
{
    AS3_DeclareVar($result, int);
    AS3_CopyScalarToVar($result, $1);
}


%{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "AS3/AS3.h"
#include "lflashlib.h"
	
int 	main() 
{ 
	AS3_GoAsync(); 
	return 0;
}

%}

%include "lua.h"
%include "lauxlib.h"
%include "lualib.h"
%include "lflashlib.h"

#else //SWIG

#define  SWIGPP
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include "lflashlib.h"

//
#endif //SWIG
