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

package vegas.date 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    // FIXME refactoring class + finalize unit tests.
    
    public class TimeTest extends TestCase 
    {
        public function TimeTest(name:String = "")
        {
            super(name);
        }
        
        public var time:Time ;
        
        public function setUp():void
        {
            time = new Time( 1260199025181 ) ;
        }
        
        public function tearDown():void
        {
            time = undefined ;
        }
        
        public function testConstructor():void
        {
            time = new Time() ;
            assertEquals( time.valueOf() , 0 ) ;
        }
        
        public function testConstructorWithMS():void
        {
            assertEquals( 1260199025181 , time.valueOf() ) ;
        }
        
        public function testDAY_FORMAT():void
        {
            assertEquals( Time.DAY_FORMAT , "d" ) ;
        }
        
        public function testHOUR_FORMAT():void
        {
            assertEquals( Time.HOUR_FORMAT , "h" ) ;
        }
        
        public function MILLISECOND_FORMAT():void
        {
            assertEquals( Time.MILLISECOND_FORMAT , "ms" ) ;
        }
        
        public function testMINUTE_FORMAT():void
        {
            assertEquals( Time.MINUTE_FORMAT , "m" ) ;
        }
        
        public function testSECOND_FORMAT():void
        {
            assertEquals( Time.SECOND_FORMAT , "s" ) ;
        }
    }
}
