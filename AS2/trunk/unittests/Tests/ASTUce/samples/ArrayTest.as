
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

import buRRRn.ASTUce.TestCase;

/* class: ArrayTest
   A sample test case, testing Array.
*/
class Tests.ASTUce.samples.ArrayTest extends TestCase
    {
    
    var empty:Array;
    var full:Array;
    
    function ArrayTest( name )
        {
        super( name );
        }
    
    function setUp()
        {
        empty = [];
        full  = [];
        full.push( 0 );
        full.push( 1 );
        full.push( 2 );
        full.push( 3 );
        }
    
    function testCapacity()
        {
        var size = full.length;
        
        for( var i=0; i<100; i++ )
            {
            full.push( i );
            }
        
        assertEquals( full.length, size+100 );
        }
    
    function testElementAt()
        {
        var i = full[0];
        assertTrue( i == 0 );
        }
    
    function testRemoveAll()
        {
        full.splice( 0, full.length );
        assertTrue( full.length == 0 );
        }
    
    function testRemoveElement()
        {
        full.splice( 0, 1 );
        assertTrue( !full.contains( 0 ) );
        }
    
    }

