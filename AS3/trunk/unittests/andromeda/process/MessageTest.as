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
	public class MessageTest extends TestCase 
	{

		public function MessageTest(name:String = "")
		{
			super(name);
		}
		
		public var message:Message ;
		
        public function setUp():void
        {
            message = new Message("hello world", "happy", 5, true, Message.ME ) ;
		}
        
        public function tearDown():void
        {
            message = undefined ;      
        }
        
        public function testConstructor():void
        {
            assertNotNull( message , "Message constructor failed, the instance not must be null." ) ;
            assertTrue( message is Pause , "Pause constructor failed, bad type." ) ;
        }
        
        public function testDelay():void
        {
        	assertEquals( message.delay, 5000  , "Message default delay failed." ) ;
        }
        
        public function testDuration():void
        {
        	assertEquals( message.duration, 5  , "Message default duration failed." ) ;
        }
        
        public function testFace():void
        {
        	assertEquals( message.face, "happy" , "Message default face failed." ) ;
        }        
        
        public function testMessage():void
        {
        	assertEquals( message.message, "hello world" , "Message default message failed." ) ;
        }
        
        public function testTo():void
        {
        	assertEquals( message.to, Message.ME , "Message default to failed." ) ;
        }        
        
        public function testUseSeconds():void
        {
        	assertTrue( message.useSeconds , "Message default useSeconds failed." ) ;
        }
                
        public function testClone():void
        {
            var clone:Pause = message.clone() as Pause ;
            assertNotNull( clone , "Message clone 01 method failed." ) ;
            assertFalse( clone == message  , "Message clone 02 method failed." ) ;
            assertEquals( clone.delay    , message.delay  , "Message clone 03 method failed." ) ;
            assertEquals( clone.duration , message.duration  , "Message clone 04 method failed." ) ;
            assertEquals( clone.useSeconds , message.useSeconds  , "Message clone 05 method failed." ) ;
        }
             
		
	}
}
