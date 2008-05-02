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
	import andromeda.process.mocks.MockCommand;
	
	import buRRRn.ASTUce.framework.TestCase;
	
	import vegas.core.IRunnable;	

	/**
	 * @author eKameleon
	 */
	public class BatchTest extends TestCase 
	{

		public function BatchTest(name:String = "")
		{
			super(name);
		}
		
        public var batch:Batch ;		

        public function setUp():void
        {
            batch = new Batch() ;
            batch.insert( new MockCommand() ) ;
            batch.insert( new MockCommand() ) ;
            batch.insert( new MockCommand() ) ;
            batch.insert( new MockCommand() ) ;
        }
        
        public function tearDown():void
        {
        	batch.clear() ;
            batch = undefined ;      
        }		
		
        public function testConstructor():void
        {
            assertNotNull( batch , "Batch constructor failed, the instance not must be null." ) ;
            assertTrue( batch is Batch , "batch must be a Batch object." ) ;
            assertTrue( batch is IRunnable , "batch implements the IRunnable interface." ) ;
        }
		
        public function testClear():void
        {
        	var clone:Batch = batch.clone() ;
        	clone.clear() ;
        	assertEquals( clone.size() , 0 , "clear method failed, the batch must be empty" ) ;
        }
		
        public function testClone():void
        {
        	var clone:Batch = batch.clone() ;
        	assertNotNull( clone , "clone method failed, with a null shallow copy object." ) ;
        	assertNotSame( clone , batch , "clone method failed, the shallow copy isn't the same with the action object." ) ;
        }
        
        public function testRun():void
        {
        	MockCommand.reset() ;
        	batch.run() ;
        	assertEquals( MockCommand.COUNT , batch.size() , "run method failed, the batch must launch " + batch.size + " IRunnable objects." ) ;
        }
        
        public function testSize():void
        {
        	var clone:Batch = batch.clone() ;
        	clone.clear() ;
        	assertEquals( clone.size() , 0 , "clear method failed, the batch must be empty" ) ;
        }        
		
	}
}
