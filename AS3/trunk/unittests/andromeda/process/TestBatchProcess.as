/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process 
{
	import andromeda.events.ActionEvent;
	import andromeda.process.mocks.MockSimpleAction;
	import andromeda.process.mocks.MockSimpleActionListener;
	
	import buRRRn.ASTUce.framework.TestCase;	

	/**
	 * @author eKameleon
	 */
	public class TestBatchProcess extends TestCase 
	{

		public function TestBatchProcess(name:String = "")
		{
			super(name);
		}
		
        public var batch:BatchProcess ;		
		
		public var mockListener:MockSimpleActionListener ;		
		
        public function setUp():void
        {
            batch = new BatchProcess() ;
            
            batch.addAction(new MockSimpleAction()) ;
            batch.addAction(new MockSimpleAction()) ;
            batch.addAction(new MockSimpleAction()) ;
            batch.addAction(new MockSimpleAction()) ;
            
            mockListener = new MockSimpleActionListener(batch) ;
        }
        
        public function tearDown():void
        {
            mockListener.unregister() ;
            mockListener = undefined ;
            batch        = undefined ;      
        }		
		
        public function testClone():void
        {
        	var clone:BatchProcess = batch.clone() ;
        	assertNotNull( clone  , "clone method failed, with a null shallow copy object." ) ;
        	assertNotSame( clone  , batch  , "clone method failed, the shallow copy isn't the same with the BatchProcess object." ) ;
        }
        
        public function testRun():void
        {
			MockSimpleAction.reset() ;
        	batch.run() ;
        	assertTrue( mockListener.isRunning , "The MockSimpleActionListener.isRunning property failed, must be true." ) ;
        	assertEquals( MockSimpleAction.COUNT , batch.size() , "run method failed, the batch must launch " + batch.size + " IRunnable objects." ) ;
        	assertEquals( MockSimpleAction.COUNT , batch.size() , "run method failed, the batch must launch " + batch.size + " IRunnable objects." ) ;
        	assertFalse( batch.running , "The running property of the BatchProcess must be false after the process." ) ;
        }
		
		public function testEvents():void
		{
        	batch.run() ;
            assertTrue( mockListener.startCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals( mockListener.startType  , ActionEvent.START   , "run method failed, bad type found when the process is started." );
            assertTrue( mockListener.finishCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals( mockListener.finishType , ActionEvent.FINISH  , "run method failed, bad type found when the process is finished." );
		}		

	}
		
}
