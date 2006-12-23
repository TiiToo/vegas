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

import Tests.vegas.core.TestInterfaces.TimerImplementation;

import vegas.events.Event;
import vegas.events.EventListener;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestITimer extends TestCase
{
	
	function TestITimer( name:String ) 
	{
		super(name);
	}

	public var i:TimerImplementation ;
	
	public function setUp():Void
	{
		i = new TimerImplementation() ;	
	}

	public function TestAddEventListener():Void 
	{
		i.addEventListener() ;
		assertTrue(i.isAddEventListener, "ITIM_01 addEventListener method failed." ) ;
	}

	public function TestClear():Void 
	{
		i.clear() ;
		assertTrue(i.isClear, "ITIM_02 clear method failed." ) ;
	}

	public function TestDispatchEvent():Void 
	{
		assertTrue( i.dispatchEvent() instanceof Event, "ITIM_03 dispatchEvent method failed." ) ;
	}

	public function TestGetDelay():Void 
	{
		i.setDelay(1000) ;
		assertEquals(i.getDelay(), 1000, "ITIM_04 getDelay method failed." ) ;
	}

	public function TestGetRepeatCount():Void 
	{
		i.setRepeatCount(5) ;
		assertEquals(i.getRepeatCount(), 5, "ITIM_05 getRepeatCount method failed." ) ;
	}

	public function TestRestart() 
	{
		i.restart() ;
		assertTrue(i.isRestart, "ITIM_06 restart method failed." ) ;
	}

	public function TestRun() : Void 
	{
		i.run() ;
		assertTrue(i.isRunning, "ITIM_07 run method failed." ) ;
	}

	public function TestStart():Void
	{
		i.start() ;
		assertTrue(i.isStarted, "ITIM_08 start method failed." ) ;
	}

	public function TestSetDelay() : Void 
	{
		i.setDelay(500) ;
		assertEquals(i.getDelay(), 500, "ITIM_09 setDelay method failed." ) ;
	}

	public function TestSetRepeatCount():Void 
	{
		i.setRepeatCount(1000) ;
		assertEquals(i.getRepeatCount(), 1000, "ITIM_10 setRepeatCount method failed." ) ;
	}

	public function TestStop():Void 
	{
		i.stop() ;
		assertTrue(i.isStopped, "ITIM_11 stop method failed." ) ;
	}

	public function TestRemoveEventListener():Void 
	{
		assertTrue( i.removeEventListener() instanceof EventListener, "ITIM_121 removeEventListener method failed." ) ;
	}
	
}