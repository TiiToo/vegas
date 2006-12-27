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

import Tests.vegas.logging.TestInterfaces.ILoggerImplementation;

import vegas.data.Set;
import vegas.events.Event;
import vegas.events.EventListener;
import vegas.events.EventListenerCollection;

/**
 * @author eKameleon
 */
class Tests.vegas.logging.TestILogger extends TestCase
{
	
	function TestILogger( name:String ) 
	{
		super(name);
	}

	
	public var lo:ILoggerImplementation ;
	
	public function setUp():Void
	{
		lo = new ILoggerImplementation() ;
	}

	public function testAddEventListener():Void 
	{
		lo.addEventListener() ;
		assertTrue(lo.isAddEventListener, "ILOG_01 - addEventListener method failed : " + lo.isAddEventListener) ; 
	}
	
	public function testAddGlobalEventListener():Void 
	{
		lo.addGlobalEventListener() ;
		assertTrue(lo.isAddGlobalEventListener, "ILOG_02 - addGlobalEventListener method failed : " + lo.isAddGlobalEventListener) ; 
	}

	public function testDispatchEvent():Void
	{
		var e:Event = lo.dispatchEvent() ;
		assertTrue(lo.isDispatchEvent, "ILOG_03_01 - dispatchEvent method failed : " + lo.isDispatchEvent) ; 
		assertTrue( e instanceof Event, "ILOG_03_02 - dispatchEvent method failed.") ;
	}
	
	public function testDebug(context):Void 
	{
		lo.debug() ;
		assertTrue(lo.isDebug, "ILOG_04 - debug method failed : " + lo.isDebug) ; 
	}


	public function testError(context):Void 
	{
		lo.error();
		assertTrue(lo.isError, "ILOG_05 - error method failed : " + lo.isError) ;
	}
	

	public function testFatal(context):Void 
	{
		lo.fatal();
		assertTrue(lo.isFatal, "ILOG_06 - fatal method failed : " + lo.isFatal) ;
	}

	public function testGetEventListeners():Void
	{
		var e:EventListenerCollection = lo.getEventListeners() ;
		assertTrue(lo.isGetEventListeners, "ILOG_07_01 - getEventListeners method failed : " + lo.isGetEventListeners) ; 
		assertTrue( e instanceof EventListenerCollection, "ILOG_07_02 - getEventListeners method failed.") ;
	}
	
	public function testGetGlobalEventListeners():Void
	{
		var e:EventListenerCollection = lo.getGlobalEventListeners() ;
		assertTrue(lo.isGetGlobalEventListeners, "ILOG_08_01 - getGlobalEventListeners method failed : " + lo.isGetGlobalEventListeners) ; 
		assertTrue( e instanceof EventListenerCollection, "ILOG_08_02 - getGlobalEventListeners method failed.") ;
	}


	public function testGetRegisteredEventNames():Void
	{
		var s:Set = lo.getRegisteredEventNames() ;
		assertTrue(lo.isGetRegisteredEventNames, "ILOG_09_01 - getRegisteredEventNames method failed : " + lo.isGetRegisteredEventNames) ; 
		assertTrue( s instanceof Set, "ILOG_09_02 - getRegisteredEventNames method failed.") ;
	}
	
	public function testHasEventListener():Void 
	{
		var b:Boolean = lo.hasEventListener() ;
		assertTrue(lo.isHasEventListener, "ILOG_10_01 - hasEventListener method failed : " + lo.isHasEventListener) ; 
		assertTrue( b, "ILOG_10_02 - hasEventListener method failed.") ;
	}

	public function testInfo():Void 
	{
		lo.info();
		assertTrue(lo.isInfo, "ILOG_11 - info method failed : " + lo.isInfo) ;
	}

	public function testLog():Void 
	{
		lo.log();
		assertTrue(lo.isLog, "ILOG_12 - info method failed : " + lo.isLog) ;
	}

	public function testRemoveEventListener():Void 
	{
		var e:EventListener = lo.removeEventListener() ;
		assertTrue(lo.isRemoveEventListener, "ILOG_13_01 - removeEventListener method failed : " + lo.isRemoveEventListener) ; 
		assertTrue( e instanceof EventListener, "ILOG_13_02 - removeEventListener method failed.") ;
	}

	public function testRemoveGlobalEventListener():Void 
	{
		var e:EventListener = lo.removeGlobalEventListener() ;
		assertTrue(lo.isRemoveGlobalEventListener, "ILOG_14_01 - removeGlobalEventListener method failed : " + lo.isRemoveGlobalEventListener) ; 
		assertTrue( e instanceof EventListener, "ILOG_14_02 - removeGlobalEventListener method failed.") ;
	}
 	
	public function testToString():Void 
	{
		var s:String = lo.toString();
		assertTrue(lo.isString, "ILOG_15_01 - toString method failed : " + lo.isString) ;
		assertEquals( s, "toString", "ILOG_15_02 - toString method failed.") ;
	}
 	
	public function testWarn():Void 
	{
		lo.warn();
		assertTrue(lo.isWarn, "ILOG_16 - warn method failed : " + lo.isWarn) ;
	}

}