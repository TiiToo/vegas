/*

 Diff Match and Patch
 
 The Initial Developer of the Original Code is Neil Fraser <fraser@google.com>
  Copyright 2006 Google Inc.
 http://code.google.com/p/google-diff-match-patch/
 
 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with this library; if not, write to the Free Software
 Foundation, Inc, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA
 
 Contributors : AS3 version author Alcaraz Marc (aka eKameleon) <ekameleon@gmail.com> (2007-2008).

*/
package system.text.utils 
{
	import buRRRn.ASTUce.framework.TestCase;	

	/**
	 * Read the http://neil.fraser.name/writing/diff/ page to understand the algo.
	 * @author eKameleon
	 */
	public class TestDifference extends TestCase 
	{

		public function TestDifference(name:String = "")
		{
			super( name );
		}
		 
        public function setUp():void
        {
            Array.prototype.toString = function():String
            {
                 return "[" + this.join(",") + "]" ;    
            };
        }
        
        public function tearDown():void
        {
            Array.prototype.toString = undefined ;
        }
		 
		// constants
		
		public function testDELETE():void
		{
		  	assertEquals( Difference.DELETE , -1  , "DELETE constant value failed." ) ;
		}
		
        public function testEQUAL():void
        {
            assertEquals( Difference.EQUAL , 0  , "EQUAL constant value failed." ) ;
        }
        
        public function testINSERT():void
        {
            assertEquals( Difference.INSERT , 1  , "INSERT constant value failed." ) ;
        }
        
        // static properties
        
        public function testDualThreshold():void
        {
            assertEquals( Difference.dualThreshold , 32  , "dualThreshold value failed." ) ;
        }
        
        public function testEditCost():void
        {
            assertEquals( Difference.editCost , 4  , "editCost value failed." ) ;
        }
		
        public function testTimeout():void
        {
            assertEquals( Difference.timeout , 1  , "timeout value failed." ) ;
        }
		
		// static methods

        public function testAddIndex():void
        {
        	fail("Test this method.") ;
        }
		
		public function testCleanupEfficiency():void
		{
            fail("Test this method.") ;
		}

        public function testCharsToLines():void
        {
            fail("Test this method.") ;
        }
        
        public function testCleanupMerge():void
        {
            fail("Test this method.") ;
        }
        
        public function testCleanupSemantic():void
        {
        	// FIXME finish this test 
        }
        
        public function testCleanupSemanticLossless():void
        {
          fail("Test this method.") ;
        }        

        public function testCleanupSemanticScore():void
        {
          fail("Test this method.") ;
        }
        
        public function testCommonPrefix():void
        {
        	var result:* ;

            result = Difference.commonPrefix( "world" , "system" ) ; // 0 common prefix of two strings
            assertEquals( result , 0 , "commonPrefix failed with the two strings 'world' and 'system' : " + result ) ; 

            result = Difference.commonPrefix( "World" , "world" ) ; // 0 common prefix of two strings
            assertEquals( result , 0 , "commonPrefix failed with the two strings 'World' and 'world' : " + result ) ; 

            result = Difference.commonPrefix( "wOrld" , "world" ) ; // 1 common prefix of two strings
            assertEquals( result , 1 , "commonPrefix failed with the two strings 'wOrld' and 'world' : " + result ) ; 

            result = Difference.commonPrefix( "hello world" , "hello system" ) ; // 6 commons prefix of two strings
            assertEquals( result , 6 , "commonPrefix failed with the two strings 'hello world' and 'hello system' : " + result ) ; 
        }
        
        
        public function testCommonSuffix():void
        {
            var result:* ;

            result = Difference.commonSuffix( "hello" , "hi" ) ; 
            assertEquals( result , 0 , "commonSuffix failed with the two strings 'hello' and 'hi' : " + result ) ;

            result = Difference.commonSuffix( "hello worlds" , "hi worlds" ) ; 
            assertEquals( result , 7 , "commonSuffix failed with the two strings 'hello worlds' and 'hi worlds' : " + result ) ; 
        }
        
        public function testCompute():void
        {
            var result:* ;

            result = Difference.compute( "hello world" , "hello system" ) ;
            //assertEquals( result , 0 , "compute failed with the two strings 'hello world' and 'hello system' : " + result ) ;
                        
            //trace("---------") ;
            //trace(result) ;
            //trace("---------") ;
            
            fail("Test this method.") ; 
             
        }        
        
        public function testFromDelta():void
        {
            fail("Test this method.") ;
        }
        
		public function testHalfMatch():void
		{
			var text1:String ;
			var text2:String ;
			var result:Array ;
			
            text1  = "cat in the hat" ;
            text2  = "ox in the box" ;
            result = Difference.halfMatch(text1, text2) ; // ["cat","hat","ox","box"," in the "]
            
            assertEquals( result[0] , "cat"       , "halfMatch 01 method result failed." ) ;
            assertEquals( result[1] , "hat"       , "halfMatch 02 method result failed." ) ;
            assertEquals( result[2] , "ox"        , "halfMatch 03 method result failed." ) ;
            assertEquals( result[3] , "box"       , "halfMatch 03 method result failed." ) ;
            assertEquals( result[4] , " in the "  , "halfMatch 03 method result failed." ) ;
		}
		
        public function testLinesToChars():void
        {
            var text1:String ;
            var text2:String ;
            var result:Array ;
            
            text1  = "text1" ;
            text2  = "text2" ;
            result = Difference.linesToChars(text1, text2) ;
            
            assertEquals( result[0] , "" , "linesToChars 01 method result failed." ) ;
            assertEquals( result[1] , "" , "linesToChars 02 method result failed." ) ;
            
            function isValide(element:*, index:int, arr:Array):Boolean 
            {
            	switch( index )
            	{
            		case 0 :
            		{
            			return element == '' ;
                        break ;	
            		}
                    case 1 :
                    {
                    	return element == 'text1' ;
                        break ; 
                    }
                    case 2 :
                    {
                    	return element == 'text2' ;
                        break ; 
                    }
            	}
            	return false ;
            } ;
            assertTrue( ( result[2] as Array ).every(isValide) , "linesToChars 03 method result failed with the third element in the Array result of the function." ) ;
            
        }
        
        public function testMain():void
        {        
            fail("Test this method.") ;
        }
        
        public function testMap():void
        {        
            fail("Test this method.") ;
        }
        
        public function testPrettyHtml():void
        {
        	fail("Test this method.") ;
        }   
        
        public function testText1():void
        {
            fail("Test this method.") ;
        }
        
        public function testText2():void
        {
            fail("Test this method.") ;
        }         
        
        public function testToDelta():void
        {
            fail("Test this method.") ;
        }   
        
        public function testXIndex():void
        {
            fail("Test this method.") ;
        }           
        
	}
}
