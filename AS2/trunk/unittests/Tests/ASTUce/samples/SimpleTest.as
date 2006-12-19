
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASTUce: ActionScript Test Unit compact edition AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

import buRRRn.ASTUce.*;

class Tests.ASTUce.samples.SimpleTest extends TestCase
    {
    
    var value1:Number;
    var value2:Number;
    
    function SimpleTest( name )
        {
        super( name );
        }
    
    function setUp()
        {
        value1 = 2;
        value2 = 3;
        }
    
    function testAdd()
        {
        var result = value1 + value2;
        
        //forced failure
        assertTrue( result == 6 );
        
        //passing test
        //assertTrue( result == 5 );
        }
    
    function testDivideByZero()
        {
        var zero = 0;
        var result = 8/zero;
        
        //forced failure
        assertEquals( 8, result );
        
        //passing test
        //assertEquals( 8, Infinity );
        }
    
    function testEquals()
        {
        assertEquals( 12, 12 );
        
        var twelve = (12).toString(16);
        assertEquals( twelve , "c" );
        
        assertEquals( 0x000000000c , 0x000000000c );
        
        //forced failure
        assertEquals( 12.0, 11.99, "Capacity" );
        
        //passing test
        //assertEquals( 12.0, 12, "Capacity" );
        }
    
    function testEqualsObject()
        {
        var obj1, obj2;
        
        obj1 = {a:1, b:2, c:3};
        obj2 = {a:1, b:2, c:4};
        
        //forced failure
        assertEquals( obj1, obj2 );
        }
    
    }

