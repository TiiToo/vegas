
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

import buRRRn.ASTUce.*;
import vegas.string.StringFormatter ;

class Tests.eden.ECMAScriptTest extends TestCase
    {
    
    function ECMAScriptTest( name )
        {
        super( name );
        }
    
    function testCallback()
        {
        var result;
        var listener = {};
        listener.onParsed = function( value )
		{
			result = value;
		} ;
        
        var EP = new buRRRn.eden.ECMAScript( "true", null, listener);
        EP.eval();
        
        assertTrue( result, "EP_001" );
        }
    
    function testSimpleArray()
        {
        var a1 = buRRRn.eden.ECMAScript.evaluate( "[]" );
        var a2 = buRRRn.eden.ECMAScript.evaluate( "[0,1,2,3]" );
        var a3 = buRRRn.eden.ECMAScript.evaluate( "new Array()" );
        var a4 = buRRRn.eden.ECMAScript.evaluate( "new Array(\"hello\")" );
        var a5 = buRRRn.eden.ECMAScript.evaluate( "new Array(5)" );
        var a6 = buRRRn.eden.ECMAScript.evaluate( "new Array(false)" );
        var a7 = buRRRn.eden.ECMAScript.evaluate( "new Array(0,1,2,3)" );
        
        assertEquals( a1, [], "EP_002a" );
        assertEquals( a2, [0,1,2,3], "EP_002b" );
        assertEquals( a3, new Array(), "EP_002c" );
        assertEquals( a4, new Array("hello"), "EP_002d" );
        assertEquals( a5, new Array(5), "EP_002e" );
        assertEquals( a6, new Array(false), "EP_002f" );
        assertEquals( a7, new Array(0,1,2,3), "EP_002g" );
        }
    
    function testSimpleBoolean()
	{
        var b1 = buRRRn.eden.ECMAScript.evaluate( "true" );
        var b2 = buRRRn.eden.ECMAScript.evaluate( "false" );
        var b3 = buRRRn.eden.ECMAScript.evaluate( "new Boolean()" );
        var b4 = buRRRn.eden.ECMAScript.evaluate( "new Boolean(\"\")" );
        var b5 = buRRRn.eden.ECMAScript.evaluate( "new Boolean(true)" );
        var b6 = buRRRn.eden.ECMAScript.evaluate( "new Boolean(false)" );
        var b7 = buRRRn.eden.ECMAScript.evaluate( "new Boolean(0)" );
        var b8 = buRRRn.eden.ECMAScript.evaluate( "new Boolean(NaN)" );
        var b9 = buRRRn.eden.ECMAScript.evaluate( "new Boolean(null)" );
        
        assertEquals( b1, true, "EP_003a" );
        assertEquals( b2, false, "EP_003b" );
        assertEquals( b3, new Boolean(), "EP_003c" );
        assertEquals( b4, new Boolean(""), "EP_003d" );
        assertEquals( b5, new Boolean(true), "EP_003e" );
        assertEquals( b6, new Boolean(false), "EP_003f" );
        assertEquals( b7, new Boolean(0), "EP_003g" );
        assertEquals( b8, new Boolean(NaN), "EP_003h" );
        assertEquals( b9, new Boolean(null), "EP_003i" );
	}
    
    function testSimpleDate()
        {
        var d1 = buRRRn.eden.ECMAScript.evaluate( "new Date(100)" );
        /* attention:
           test removed
           AS2 does not support
           a string argument to initialize a Date Object
           and yeld a "Type mismatch" error
        */
        //var d2 = buRRRn.eden.ECMAScript.evaluate( "new Date(\"\")" );
        //var d3 = buRRRn.eden.ECMAScript.evaluate( "new Date(\"Tue Apr 25 17:55:58 UTC+0200 2006\")" );
        var d4 = buRRRn.eden.ECMAScript.evaluate( "new Date(2006,2,30)" );
        var d5 = buRRRn.eden.ECMAScript.evaluate( "new Date(2006,11,25,1,2,3,4)" );
        var d6 = buRRRn.eden.ECMAScript.evaluate( "new Date(null)" );
        var d7 = buRRRn.eden.ECMAScript.evaluate( "new Date(NaN)" );
        
        assertEquals( d1, new Date(100), "EP_004a" );
        //assertEquals( d2, new Date(""), "EP_004b" );
        //assertEquals( d3, new Date("Tue Apr 25 17:55:58 UTC+0200 2006"), "EP_004c" );
        assertEquals( d4, new Date(2006,2,30), "EP_004d" );
        assertEquals( d5, new Date(2006,11,25,1,2,3,4), "EP_004e" );
        assertEquals( d6, new Date(null), "EP_004f" );
        assertEquals( d7, new Date(NaN), "EP_004g" );
        }
    
    function testSimpleNumber()
        {
        var n1 = buRRRn.eden.ECMAScript.evaluate( "1234567890" );
        var n2 = buRRRn.eden.ECMAScript.evaluate( "0xffFF" );
        var n3 = buRRRn.eden.ECMAScript.evaluate( "0.5123" );
        var n4 = buRRRn.eden.ECMAScript.evaluate( "2e12" );
        var n5 = buRRRn.eden.ECMAScript.evaluate( "4e-12" );
        var n6 = buRRRn.eden.ECMAScript.evaluate( "055" );
        var n7 = buRRRn.eden.ECMAScript.evaluate( "new Number()" );
        /* attention:
           in JavaScript, JScript, JSDB
           new Number(null) gives 0
           but in Flash ActionScript
           new Number(null) gives NaN
           
           in AS2 this yeld a "Type mismatch" error
        */
        //var n8 = buRRRn.eden.ECMAScript.evaluate( "new Number(null)" );
        
        assertEquals( n1, 1234567890, "EP_005a" );
        assertEquals( n2, 0xffFF, "EP_005b" );
        assertEquals( n3, 0.5123, "EP_005c" );
        assertEquals( n4, 2e12, "EP_005d" );
        assertEquals( n5, 4e-12, "EP_005e" );
        assertEquals( n6, 055, "EP_005f" );
        assertTrue(   n6 != 55, "EP_005g" );
        assertEquals( n7, new Number(), "EP_005h" );
        //assertTrue( n8, new Number(null), "EP_005i" );
        }
    
    function testSimpleObject()
        {
        var o1 = buRRRn.eden.ECMAScript.evaluate( "{}" );
        var o2 = buRRRn.eden.ECMAScript.evaluate( "new Object(null)" );
        var o3 = buRRRn.eden.ECMAScript.evaluate( "new Object(undefined)" );
        var o4 = buRRRn.eden.ECMAScript.evaluate( "{a:0,b:1,c:2}" );
        var o5 = buRRRn.eden.ECMAScript.evaluate( "new Object()" );
        var o6 = buRRRn.eden.ECMAScript.evaluate( "new Object(\"hello\")" );
        var o7 = buRRRn.eden.ECMAScript.evaluate( "new Object(12345)" );
        var o8 = buRRRn.eden.ECMAScript.evaluate( "new Object(true)" );
        
        assertEquals( o1, {}, "EP_006a" );
        assertEquals( o2, new Object(null), "EP_006b" );
        assertEquals( o3, new Object(undefined), "EP_006c" );
        assertEquals( o4, {a:0,b:1,c:2}, "EP_006d" );
        assertEquals( o5, new Object(), "EP_006e" );
        assertEquals( o6, new Object("hello"), "EP_006f" );
        assertEquals( o7, new Object(12345), "EP_006h" );
        assertEquals( o8, new Object(true), "EP_006i" );
        }
    
    
    public function testSimpleString()
    {
        var s1 = buRRRn.eden.ECMAScript.evaluate( "\"\"" );
        var s2 = buRRRn.eden.ECMAScript.evaluate( "\"hello world\"" );
        var s3 = buRRRn.eden.ECMAScript.evaluate( "\"\\x0A\"" );
        /* attention:
           test removed
           AS2 does not support
           a boolean argument to initialize a String Object
           and yeld a "Type mismatch" error
        */
        //var s4 = buRRRn.eden.ECMAScript.evaluate( "new String(true)" );
        var s5 = buRRRn.eden.ECMAScript.evaluate( "new String()" );
        var s6 = buRRRn.eden.ECMAScript.evaluate( "\"\\u6060\"" );
        var s7 = buRRRn.eden.ECMAScript.evaluate( "\"\\b\\t\\n\\v\\f\\r\"" );
        var s8 = buRRRn.eden.ECMAScript.evaluate( "\"\\\\\"" );
        
        assertEquals( s1, "", "EP_007a" );
        assertEquals( s2, "hello world", "EP_007b" );

     	/** TODO patch \x to test eden ?   
        var s = "\x0A" ; // problem with this expression !!
        
        assertEquals( s3, s, "EP_007c" ) ;
        */

        //assertEquals( s4, new String(true), "EP_007d" );
        assertEquals( s5, new String(), "EP_007e" );
        assertEquals( s6, "\u6060", "EP_007f" );
        
        // FIXME : bug with this keywords ??
        assertEquals( s7, "\b\t\n\v\f\r", "EP_007h" );
        
        assertEquals( s8, "\\", "EP_007i" );
	}
    
    function testComplexObject()
        {
        var o1 = buRRRn.eden.ECMAScript.evaluate( "{a:{b:{c:{d:{e:{f:{}}}}}}}" );
        var o2 = buRRRn.eden.ECMAScript.evaluate( "{a:{x:0,y:1},b:{x:0,y:1},c:{x:0,y:1}}" );
        var o3 = buRRRn.eden.ECMAScript.evaluate( "{x:{a:{b:{c:{d:{e:{f:{}}}}}}},y:{a:{b:{c:{d:{e:{f:{}}}}}}}}" );
        var o4 = buRRRn.eden.ECMAScript.evaluate( "{x:[0,1,2,3,{a:0,b:1,c:2}],y:{a:[0,1,2,3],b:[0,1,2,3],c:[0,1,2,3]}}" );
        
        assertEquals( o1, {a:{b:{c:{d:{e:{f:{}}}}}}}, "EP_008a" );
        assertEquals( o2, {a:{x:0,y:1},b:{x:0,y:1},c:{x:0,y:1}}, "EP_008b" );
        assertEquals( o3, {x:{a:{b:{c:{d:{e:{f:{}}}}}}},y:{a:{b:{c:{d:{e:{f:{}}}}}}}}, "EP_008c" );
        assertEquals( o4, {x:[0,1,2,3,{a:0,b:1,c:2}],y:{a:[0,1,2,3],b:[0,1,2,3],c:[0,1,2,3]}}, "EP_008d" );
        }
    
    function testComplexArray()
        {
        var a1 = buRRRn.eden.ECMAScript.evaluate( "[[[[[[[[ 0 ]]]]]]]]" );
        var a2 = buRRRn.eden.ECMAScript.evaluate( "[ [[0]], [[1]], [[2]], [[3]] ]" );
        var a3 = buRRRn.eden.ECMAScript.evaluate( "[ {a:[[[[[[[[ 0 ]]]]]]]]}, {b:[[[[[[[[ 1 ]]]]]]]]}, {c:[[[[[[[[ 2 ]]]]]]]]} ]" );
        var a4 = buRRRn.eden.ECMAScript.evaluate( "[ {a:[{b:[{c:[{d:[0,1,2,3]}]}]}]} ]" );
        
        assertEquals( a1, [[[[[[[[ 0 ]]]]]]]], "EP_009a" );
        assertEquals( a2, [ [[0]], [[1]], [[2]], [[3]] ], "EP_009b" );
        assertEquals( a3, [ {a:[[[[[[[[ 0 ]]]]]]]]}, {b:[[[[[[[[ 1 ]]]]]]]]}, {c:[[[[[[[[ 2 ]]]]]]]]} ], "EP_009c" );
        assertEquals( a4, [ {a:[{b:[{c:[{d:[0,1,2,3]}]}]}]} ], "EP_009d" );
        }
    
    function testExternalReference()
        {
        buRRRn.eden.config.security = false;
        
        var er1 = buRRRn.eden.ECMAScript.evaluate( "Math.E" );
        var er2 = buRRRn.eden.ECMAScript.evaluate( "{a:Math.E, b:Number.MAX_VALUE}" );
        _global.titi = "hello world";
        var er3 = buRRRn.eden.ECMAScript.evaluate( "toto = titi" );
        
        assertEquals( er1, Math.E, "EP_010a" );
        assertEquals( er2, {a:Math.E, b:Number.MAX_VALUE}, "EP_010b" );
        /* note:
           in AS2 you have to access globals using the keyword _global
        */
        assertEquals( _global.toto, _global.titi, "EP_010c" );
        
        delete _global.titi;
        delete _global.toto;
        buRRRn.eden.config.security = true;
        }
    
    function testAuthorized()
        {
        _global.a = {};
        
        _global.a.Titi = function()
		{
            this.test = false;
		} ;
        
        _global.a.b = {};
        _global.a.b.c = {};
        _global.a.b.c.Toto = function()
		{
            this.test = true;
		} ;
        
        _global.foobar = "hello world";
        
        buRRRn.eden.Application.addAuthorized( "a.b.c.*" );
        
        var auth1 = buRRRn.eden.ECMAScript.evaluate( "new a.b.c.Toto()" );
        var auth2 = buRRRn.eden.ECMAScript.evaluate( "new a.Titi()" );
        var auth3 = buRRRn.eden.ECMAScript.evaluate( "a.b.c.d = 12345" );
        var auth4 = buRRRn.eden.ECMAScript.evaluate( "a.b.test = 12345" );
        var auth5 = buRRRn.eden.ECMAScript.evaluate( "a.b.c.test = Number.MAX_VALUE;" );
        var auth5 = buRRRn.eden.ECMAScript.evaluate( "a.b.c.blah = foobar;" );
        var auth6 = buRRRn.eden.ECMAScript.evaluate( "a.b.c.foobar = blah;" );
        var auth7 = buRRRn.eden.ECMAScript.evaluate( "a.b.c.notANumber = NaN;" );
        
        /* note:
           in AS2 you have to access globals using the keyword _global
        */
        assertEquals( auth1, new _global.a.b.c.Toto(), "EP_011a" );
        assertEquals( auth2, undefined, "EP_011b" );
        assertEquals( _global.a.b.c.d, 12345, "EP_011c" );
        assertUndefined( _global.a.b.test, "EP_011d" );
        assertEquals( _global.a.b.c.test, Number.MAX_VALUE, "EP_011e" );
        assertUndefined( _global.a.b.c.blah, "EP_011f" );
        assertUndefined( _global.a.b.c.foobar, "EP_011g" );
        assertTrue( isNaN(_global.a.b.c.notANumber), "EP_011h" );
        
        buRRRn.eden.Application.removeAuthorized( "a.b.c.*" );
        delete _global.a;
        delete _global.foobar;
	}
    
    function testFunctionCall()
        {
        buRRRn.eden.config.allowFunctionCall = true;
        buRRRn.eden.config.security = false;
        
        var fc1 = buRRRn.eden.ECMAScript.evaluate( "isNaN( 123 )" );
        /* attention:
           test modified
           AS2 parseInt global function does not support
           a number argument
           and yeld a "Type mismatch" error
        */
        //var fc2 = buRRRn.eden.ECMAScript.evaluate( "parseInt( 1.23 )" );
        var fc2 = buRRRn.eden.ECMAScript.evaluate( "parseInt( \"1.23\" )" );
        //var fc3 = buRRRn.eden.ECMAScript.evaluate( "String.format( \"hello {0}\", \"toto\" )" );
        var fc4 = buRRRn.eden.ECMAScript.evaluate( "titi = \"hello world\"; toto = titi.toUpperCase();" );
        
        assertEquals( fc1, isNaN( 123 ), "EP_012a" );
        //assertEquals( fc2, parseInt( 1.23 ), "EP_012b" );
        assertEquals( fc2, parseInt( "1.23" ), "EP_012b" );
        //assertEquals( fc3, new StringFormatter( "hello {0}" ).format( "toto" ), "EP_012c" );
        assertEquals( _global.toto, _global.titi.toUpperCase(), "EP_012d" );
        
        delete _global.titi;
        delete _global.toto;
        buRRRn.eden.config.allowFunctionCall = false;
        buRRRn.eden.config.security = true;
	}
    
    // FIXME problem with parser scope
	function testParserScope()
	{
        buRRRn.eden.config.autoAddScopePath = true;
        
        _global.toto = {};
        var s1 = buRRRn.eden.ECMAScript.evaluate( "test = true;", _global.toto );
        
        assertEquals( _global.toto.test, true, "EP_013a" );
        
        
        assertUndefined( _global.test, "EP_013b" );
        
        delete _global.toto;
        buRRRn.eden.config.autoAddScopePath = false;
	}
    
    function testBracketPath()
	{
        
        buRRRn.eden.config.security = false;
        
        var bp1 = buRRRn.eden.ECMAScript.evaluate( "toto[\"titi\"] = 12345;" ) ;
        var bp2 = buRRRn.eden.ECMAScript.evaluate( "titi = []; titi[0] = 0; titi[1] = 1; titi[2] = Number[\"MAX_VALUE\"];" ) ;
        var bp3 = buRRRn.eden.ECMAScript.evaluate( "tutu = []; tutu[0] = 0; tutu[1] = 1; tutu[2] = tutu[0];" ) ;
        
        //trace( _global.toto.titi + " : " + 12345) ;
        
        var ar:Array ;
        
        // TODO : change assertEquals method and implement equals tool
        
        ar = [0,1,Number["MAX_VALUE"]] ;
        
        assertEquals( _global.toto.titi, 12345, "EP_014a" );
        
        assertEquals( _global.titi[0], ar[0], "EP_014b" );
        assertEquals( _global.titi[1], ar[1], "EP_014b" );
        assertEquals( _global.titi[2], ar[2], "EP_014b" );
        
        assertEquals( _global.tutu, [0,1,0] , "EP_014c" );
        
        delete _global.toto;
        delete _global.titi;
        delete _global.tutu;
        
        buRRRn.eden.config.security = true;
        
	}
    
}

