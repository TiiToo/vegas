/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import buRRRn.ASTUce.TestCase;

import Tests.vegas.util.ConcreteAbstractTimer;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestAbstactTimer extends TestCase
{
	
	function TestAbstactTimer( name:String ) 
	{
		super(name);
	}

	public var t:ConcreteAbstractTimer ;
	
	public function setUp():Void
	{
		t = new ConcreteAbstractTimer( 1000, 20 ) ;
	}

	public function TestDelay():Void 
	{
		assertEquals( t.delay , 1000 , "A_TIMER_01_01 delay property failed : " + t.delay ) ;
		t.delay = 200 ;
		assertEquals( t.delay , 200 , "A_TIMER_01_02 delay property failed : " + t.delay ) ;
		t.delay = 1000 ;
	}

	public function TestRepeatCount():Void 
	{
		assertEquals( t.repeatCount , 20 , "A_TIMER_02_01 repeatCount property failed : " + t.repeatCount ) ;
		t.repeatCount = 200 ;
		assertEquals( t.repeatCount , 200 , "A_TIMER_02_02 repeatCount property failed : " + t.repeatCount ) ;
		t.repeatCount = 20 ;
	}

	public function TestRunning():Void 
	{
		assertFalse( t.running , "A_TIMER_03_01 running property failed : " + t.running ) ;
		t.start() ;
		assertTrue( t.running , "A_TIMER_03_02 running property failed : " + t.running ) ;
		t.stop() ;
	}
	
	/*
	public function TestClear():Void 
	{
		
	}
	*/
	
	public function TestClone():Void 
	{
		assertNull(t.clone(), "A_TIMER_04 clone method failed." ) ;
	}

	public function TestCopy():Void 
	{
		assertNull(t.copy(), "A_TIMER_04 copy method failed." ) ;
	}
	
	public function TestGetDelay():Void 
	{
		assertEquals(t.getDelay(), 1000, "A_TIMER_05 getDelay method failed." ) ;
	}

	public function TestGetRepeatCount():Void 
	{
		assertEquals(t.getRepeatCount(), 20, "A_TIMER_06 getRepeatCount method failed." ) ;
	}
	
	public function TestGetRunning():Void 
	{
		assertFalse( t.getRunning() , "A_TIMER_07_01 getRunning method failed : " + t.getRunning() ) ;
		t.start() ;
		assertTrue( t.getRunning() , "A_TIMER_07_02 getRunning method failed : " + t.getRunning() ) ;
		t.stop() ;
	}

	public function TestRestart() 
	{
		assertFalse(t.running, "A_TIMER_08_01 restart method failed." ) ;
		t.restart() ;
		assertTrue(t.running, "A_TIMER_08_02 restart method failed." ) ;
		t.stop() ;
	}

	/*
	public function TestRun():Void 
	{
		
	}
	*/
	
	public function TestSetDelay():Void 
	{
		t.setDelay(500) ;
		assertEquals(t.getDelay(), 500, "A_TIMER_09 setDelay method failed." ) ;
		t.setDelay(1000) ;
	}

	public function TestSetRepeatCount():Void 
	{
		t.setRepeatCount(5) ;
		assertEquals( t.getRepeatCount(), 5, "A_TIMER_10 setRepeatCount method failed." ) ;
		t.setRepeatCount(20) ;
	}

	public function TestStart():Void
	{
		t.start() ;
		assertTrue(t.running, "A_TIMER_11 start method failed." ) ;
		t.stop() ;
	}

	public function TestStop():Void 
	{
		t.stop() ;
		assertFalse(t.running, "A_TIMER_12 stop method failed." ) ;
	}

}