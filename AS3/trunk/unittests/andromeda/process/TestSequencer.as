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

	// TODO test progress event !!

	/**
	 * @author eKameleon
	 */
	public class TestSequencer extends TestCase 
	{

		public function TestSequencer(name:String = "")
		{
			super(name);
		}
		
       	public var seq:Sequencer ;		
		
		public var mockListener:MockSimpleActionListener ;		
		
        public function setUp():void
        {
            
            seq = new Sequencer() ;
            
            seq.addAction(new MockSimpleAction()) ;
            seq.addAction(new MockSimpleAction()) ;
            seq.addAction(new MockSimpleAction()) ;
            seq.addAction(new MockSimpleAction()) ;
            
        }
        
        public function tearDown():void
        {
            seq = undefined ; 
            MockSimpleAction.reset() ; 
        }		
		
		public function testInherit():void
		{
			assertTrue( seq is Action , "inherit Action failed.");
		}
		
        public function testClear():void
        {
        	var clone:Sequencer = seq.clone() as Sequencer ;
        	clone.clear() ;
        	assertEquals( clone.size() , 0 , "clear method failed.") ;
        }		
		
		public function testAddAction():void
		{
        	var s:Sequencer = new Sequencer() ;
        	
        	assertFalse( s.addAction( null                  ) , "addAction failed, must return false when a null object is passed-in." ) ;
        	assertTrue( s.addAction( new MockSimpleAction() ) , "addAction failed, must return true when a IAction object is passed-in." ) ;
            
		}
		
        public function testClone():void
        {
        	var clone:Sequencer = seq.clone() as Sequencer ;
        	assertNotNull( clone  , "clone method failed, with a null shallow copy object." ) ;
        	assertNotSame( clone  , seq  , "clone method failed, the shallow copy isn't the same with the BatchProcess object." ) ;
        }
        
        public function testEvents():void
        {
        	
        	var s:Sequencer = new Sequencer() ;
        	mockListener = new MockSimpleActionListener(s) ;
        	
        	s.addAction( new MockSimpleAction("testEvents_1") ) ;
            s.addAction( new MockSimpleAction("testEvents_2") ) ;
            s.addAction( new MockSimpleAction("testEvents_3") ) ;
            s.addAction( new MockSimpleAction("testEvents_4") ) ;
            
            s.run() ;
            
            assertTrue( mockListener.isRunning , "The MockSimpleActionListener.isRunning property failed, must be true." ) ;
        	assertFalse( s.running , "The running property of the Sequencer must be false after the process." ) ;
        	
            assertTrue   ( mockListener.startCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals ( mockListener.startType  , ActionEvent.START   , "run method failed, bad type found when the process is started." );
            assertTrue   ( mockListener.finishCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals ( mockListener.finishType , ActionEvent.FINISH  , "run method failed, bad type found when the process is finished." );
            
        	mockListener.unregister() ;
        	mockListener = null ;    
            
        }
        
        public function testRun():void
        {

			MockSimpleAction.reset() ;
        
        	var s:Sequencer = new Sequencer() ;
			
			s.addAction( new MockSimpleAction("testRun_1") ) ;
            s.addAction( new MockSimpleAction("testRun_2") ) ;
            s.addAction( new MockSimpleAction("testRun_3") ) ;
            
            var size:uint = s.size() ;
        	
        	s.run() ;

        	assertEquals( MockSimpleAction.COUNT , size , "run method failed, the sequencer must launch " + s.size() + " IRunnable objects." ) ;
        	assertEquals( s.size()               ,    0 , "run method failed, the sequencer must be empty after the run process." ) ;
        	        	
        	MockSimpleAction.reset() ;

        }
        
        public function testRunClone():void
        {

			MockSimpleAction.reset() ;
        
        	var s:Sequencer = new Sequencer() ;

			s.addAction( new MockSimpleAction( "testRunClone_1" , true ) ) ;
            s.addAction( new MockSimpleAction( "testRunClone_2" , true ) ) ;
            s.addAction( new MockSimpleAction( "testRunClone_3" , true ) ) ;
            
           	var c:Sequencer = s.clone() ; // don't forget overrides or implement the clone method in the IAction object ... 
           	//the clone method use a "deep copy" (like copy method) and not a "shallow copy" (Important to use addEventListener !!).
            
            var size:uint = c.size() ;
        
       		c.run() ;
        	
       	
        	assertEquals( MockSimpleAction.COUNT , size , "run method failed, the sequencer must launch " + s.size() + " IRunnable objects." ) ;
        	assertEquals( c.size()               ,    0 , "run method failed, the sequencer must be empty after the run process." ) ;
        	
        	
        	MockSimpleAction.reset() ;
        	
        }        
        
        public function testSize():void
        {
        	assertEquals( seq.size() , 4 , "size method failed.") ;
        }		        
		
		
	}
}
