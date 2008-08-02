/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process 
{
	import buRRRn.ASTUce.framework.TestCase;		

	/**
	 * @author eKameleon
	 */
	public class PauseTest extends TestCase 
	{

		public function PauseTest(name:String = "")
		{
			super(name);
		}
		
		public var pause:Pause ;
		
        public function setUp():void
        {
            pause = new Pause() ;
        }
        
        public function tearDown():void
        {
            pause = undefined ;      
        }
        
        public function testConstructor():void
        {
            assertNotNull( pause , "Pause constructor failed, the instance not must be null." ) ;
            assertTrue( pause is Pause , "Pause constructor failed, bad type." ) ;
        }
        
        public function testDelay():void
        {
        	assertEquals( pause.delay, 0  , "Pause default delay failed." ) ;
        }
        
        public function testDuration():void
        {
        	assertEquals( pause.duration, 0  , "Pause default duration failed." ) ;
        }
        
        public function testUseSeconds():void
        {
        	assertFalse( pause.useSeconds , "Pause default useSeconds failed." ) ;
        }
                
        public function testClone():void
        {
            var clone:Pause = pause.clone() as Pause ;
            assertNotNull( clone , "Pause clone 01 method failed." ) ;
            assertFalse( clone == pause  , "Pause clone 02 method failed." ) ;
            assertEquals( clone.delay    , pause.delay  , "Pause clone 03 method failed." ) ;
            assertEquals( clone.duration , pause.duration  , "Pause clone 04 method failed." ) ;
            assertEquals( clone.useSeconds , pause.useSeconds  , "Pause clone 05 method failed." ) ;
        }
                
		
	}
}
