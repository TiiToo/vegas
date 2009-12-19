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
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.strings 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.process.Runnable;
    
    public class MinifierTest extends TestCase 
    {
        public function MinifierTest(name:String = "")
        {
            super(name);
        }
        
        public var minifier:Minifier ;
        
        public function setUp():void
        {
            minifier = new Minifier() ;
        }
        public function tearDown():void
        {
            minifier = null ;
        }
        
        public function testInterface():void
        {
            assertTrue( minifier is Runnable ) ;
        }
        
        public function testAGRESSIVE():void
        {
            assertEquals( Minifier.AGRESSIVE , 3 ) ;
        }
        
        public function testMINIMAL():void
        {
            assertEquals( Minifier.MINIMAL , 1 ) ;
        }
        
        public function testNORMAL():void
        {
            assertEquals( Minifier.NORMAL , 2 ) ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( minifier , "01 - constructor failed, the instance not must be null.") ;
            assertEquals( minifier.input , '' , "02 - constructor failed, the input property must be an empty string '' by default.") ;
            assertEquals( minifier.output , '' , "03 - constructor failed, the output property must be an empty string '' by default." ) ;
            assertEquals( minifier.level , Minifier.NORMAL , "04 - constructor failed, the level property must be normal by default (2)." ) ;
            assertEquals( minifier.newSize , 0 , "05 - constructor failed, the newSize property value must be 0." ) ;
            assertEquals( minifier.oldSize , 0 , "06 - constructor failed, the oldSize property value must be 0." ) ;
        }
        
        public function testConstructorWithArguments():void
        {
            minifier = new Minifier( "var a = 1 ;" , Minifier.AGRESSIVE ) ;
            assertNotNull( minifier , "01 - constructor failed, the instance not must be null.") ;
            assertEquals( minifier.input , 'var a = 1 ;' , "02 - constructor failed, the input property must be an empty string '' by default.") ;
            assertEquals( minifier.output , 'var a = 1 ;' , "03 - constructor failed, the output property not must be an empty." ) ;
            assertEquals( minifier.level , Minifier.AGRESSIVE , "04 - constructor failed, the level property must be agressive (3)." ) ;
            assertEquals( minifier.newSize , 11 , "05 - constructor failed, the newSize property is not changed." ) ;
            assertEquals( minifier.oldSize , 11 , "06 - constructor failed, the oldSize property is not changed." ) ;
        }
        
        public function testInput():void
        {
            minifier.input = "var a = 1 ;" ;
            assertEquals( minifier.input  , "var a = 1 ;" , "01 - failed") ;
            assertEquals( minifier.output , minifier.input , "02 - failed") ;
            assertEquals( minifier.newSize , 11 , "03 - failed") ;
            assertEquals( minifier.oldSize , 11 , "04 - failed") ;
        }
        
        public function testLevel():void
        {
            minifier.level = Minifier.MINIMAL ;
            assertEquals( minifier.level , Minifier.MINIMAL , "01 - minifier.level failed.") ;
            minifier.level = Minifier.NORMAL ;
            assertEquals( minifier.level , Minifier.NORMAL , "02 - minifier.level failed.") ;
            minifier.level = Minifier.AGRESSIVE ;
            assertEquals( minifier.level , Minifier.AGRESSIVE , "03 - minifier.level failed.") ;
            minifier.level = 0  ;
            assertEquals( minifier.level , Minifier.MINIMAL , "04 - minifier.level failed.") ;
            minifier.level = 3 ;
            assertEquals( minifier.level , Minifier.AGRESSIVE , "04 - minifier.level failed.") ;
            minifier.level = 100 ;
            assertEquals( minifier.level , Minifier.AGRESSIVE , "05 - minifier.level failed.") ;
        }
        
        public function testRunAGRESSIVE():void
        {
            minifier.level = Minifier.AGRESSIVE ;
            minifier.input = "var a =       1 ; \r\n var b      = 2 ;  var c = 3    ;  " ;
            minifier.run() ;
            assertEquals(minifier.output , "var a=1;var b=2;var c=3;") ;
            assertEquals( minifier.newSize , 24 ) ;
        }
        
        public function testRunMINIMAL():void
        {
            minifier.level = Minifier.MINIMAL ;
            minifier.input = "var a =       1 ; \r\n var b      = 2 ;  var c = 3    ;  " ;
            minifier.run() ;
            assertEquals(minifier.output , "var a=1;\nvar b=2;var c=3;") ;
            assertEquals( minifier.newSize , 25 ) ;
        }
        
        public function testRunWithTab():void
        {
            minifier.level = Minifier.NORMAL ;
            minifier.input = "\r\rvar a =       1 ; \r\t\n var b      = 2 ;  var      c = 3    ;  " ;
            minifier.run() ;
            assertEquals(minifier.output , "var a=1;var b=2;var c=3;") ;
            assertEquals( minifier.newSize , 24 ) ;
        }
        
        public function testRunWithComments():void
        {
            minifier.level = Minifier.NORMAL ;
            minifier.input = "\r\r/*test1\rtest2*/var a =       1 ; \r\t\n var b      = 2 ;  var      c = 3    ;  " ;
            minifier.run() ;
            assertEquals(minifier.output , " var a=1;var b=2;var c=3;") ;
            assertEquals( minifier.newSize , 25 ) ;
        }
        
        public function testRunNORMAL():void
        {
            minifier.level = Minifier.NORMAL ;
            minifier.input = "var a =       1 ; \r\n var b      = 2 ;  var c = 3    ;  " ;
            minifier.run() ;
            assertEquals(minifier.output , "var a=1;var b=2;var c=3;") ;
            assertEquals( minifier.newSize , 24 ) ;
        }
    }
}
