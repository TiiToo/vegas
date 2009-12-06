/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.colors
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.hack;
    
    /**
     * The test class of vegas.colors.ColorEvaluator.
     */
    public class ColorEvaluatorTest extends TestCase 
    {
        public function ColorEvaluatorTest( name:String = "" )
        {
            super( name ) ;
        }
        
        public var evaluator:ColorEvaluator ;
        
        public function setUp():void
        {
            evaluator = new ColorEvaluator() ;
        }
        
        public function tearDown():void
        {
            evaluator = undefined ;
        }
        
        public function testFilter():void
        {
            use namespace hack ;
            assertNotNull( evaluator.filter                 , "01 - The pattern is not good." ) ;
            assertTrue( evaluator.filter is RegExp          , "02 - The pattern is not good." ) ;
            assertEquals( evaluator.filter.source  , "#|0x" , "03 - The pattern is not good." ) ;
            assertTrue( evaluator.filter.global             , "04 - The regex must be global." ) ;
        }
        
        public function testEvalWithValidValue():void
        {
            assertEquals( evaluator.eval( "aaaaaa" )   , 0xAAAAAA , "01 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AAAAAA" )   , 0xAAAAAA , "02 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "ff" )       , 0xFF     , "03 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "FFFFFF" )   , 0xFFFFFF , "04 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "0xFF0000" ) , 0xFF0000 , "05 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "#FF0000" )  , 0xFF0000 , "06 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "0x3" )      , 0x3      , "07 - The pattern eval failed" ) ;
        }
        
        public function testEvalWithInvalidValue():void
        {
            assertEquals( evaluator.eval( "g" )       , 0 , "01 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "G" )       , 0 , "02 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AG" )      , 0 , "03 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AAG" )     , 0 , "04 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AAAG" )    , 0 , "05 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AAAAG" )   , 0 , "06 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AAAAAG" )  , 0 , "07 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AAzAAA" )  , 0 , "08 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "AAAAAAA" ) , 0 , "09 - The pattern eval failed" ) ;
            assertEquals( evaluator.eval( "Ox" )      , 0 , "10 - The pattern eval failed" ) ;
        }
        
        public function testEvalWithNull():void
        {
            assertEquals( evaluator.eval( null ) , 0 , "The pattern eval failed with a null parameter"  ) ;
        }
        
        public function testEvalWithNoStringValue():void
        {
            assertEquals( evaluator.eval( 2 ) , 0 , "The pattern eval failed with a Number parameter"  ) ;
        }
    }
}
