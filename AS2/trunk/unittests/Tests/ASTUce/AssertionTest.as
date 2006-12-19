
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

import buRRRn.ASTUce.AssertionFailedError;
import buRRRn.ASTUce.ComparisonFailure;
import buRRRn.ASTUce.TestCase;

/* Constructor: AssertionTest
   
   attention:
   In the tests that follow, we can't use
   standard formatting for exception tests:
   
   (code)
   try
       {
       somethingThatShouldThrow(); //throw an AssertionFailedError
       }
   catch( e )
       {
       if( e instanceof AssertionFailedError )
            {
            return; //ok we catch the error
            }
       }
   fail(); //no error catched
   (end)
   
   because fail() would never be reported.
*/
class Tests.ASTUce.AssertionTest extends TestCase
    {
    
    function AssertionTest( name )
        {
        super( name );
        }
    
    function testFail()
        {
        /* attention:
           Also, we are testing fail,
           so we can't rely on fail() working.
           We have to throw the exception manually.
        */
        try
            {
            fail();
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        throw new AssertionFailedError( "ASSERT_001" );
        }
    
    function testAssertEquals()
        {
        /* attention:
           Object equality does not work the same in ActionScript and JAVA.
           
           assertEquals(new Object(), new Object());
           does not throw an Error in ActionScript.
        */
        var o = new Object();
        var o1 = {a:"hello", b:"world"};
        var o2 = {c:"hello", d:"world"};
        
        assertEquals( o, o );
        
        try
            {
            assertEquals( o1, o2 );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_002" );
        }
    
    function testAssertEqualsNull()
        {
        assertEquals( null, null, "ASSERT_003" );
        }
    
    function testAssertStringEquals()
        {
        assertEquals( "a", "a", "ASSERT_004" );
        }
    
    function testAssertNullNotEqualsString()
        {
        try
            {
            assertEquals( null, "foo" );
            }
        catch( e )
            {
            if( e instanceof ComparisonFailure )
                {
                return;
                }
            }
        
        fail( "ASSERT_005" );
        }
    
    function testAssertStringNotEqualsNull()
	{
        try
		{
			assertEquals( "foo", null );
		}
        catch( e )
		{
			if( e instanceof ComparisonFailure )
			{
				return ;
			}
		}
        fail( "ASSERT_006" );
	}
    
    function testAssertNullNotEqualsNull()
        {
        try
            {
            assertEquals( null, new Object() );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_007" );
        }
    
    function testAssertNull()
        {
        assertNull( null );
        
        try
            {
            assertNull( new Object() );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_008" );
        }
    
    function testAssertNotNull()
        {
        assertNotNull( new Object() );
        
        try
            {
            assertNotNull( null );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_009" );
        }
    
    function testAssertTrue()
        {
        assertTrue( true );
        
        try
            {
            assertTrue( false );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_010" );
        }
    
    function testAssertFalse()
        {
        assertFalse( false );
        
        try
            {
            assertFalse( true );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_011" );
        }
    
    function testAssertSame()
        {
        var o = new Object();
        assertSame( o, o );
        
        try
            {
            assertSame( new Number(1), new Number(1) );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_012" );
        }
    
    function testAssertNotSame()
        {
        assertNotSame( new Number(1), null );
        assertNotSame( null, new Number(1) );
        assertNotSame( new Number(1) , new Number(1) );
        
        var obj = new Number(1);
        
        try
            {
            assertNotSame( obj, obj );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_013" );
        }
    
    function testAssertNotSameFailsNull()
        {
        try
            {
            assertNotSame( null, null );
            }
        catch( e )
            {
            if( e instanceof AssertionFailedError )
                {
                return;
                }
            }
        
        fail( "ASSERT_014" );
        }
    
    }

