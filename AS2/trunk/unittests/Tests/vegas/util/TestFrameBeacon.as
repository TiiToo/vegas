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

import vegas.data.iterator.Iterator;
import vegas.util.FrameBeacon;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestFrameBeacon extends TestCase 
{

	function TestFrameBeacon(name : String) 
	{
		super(name);
	}

	public var ref:MovieClip ;

	public function setUp():Void
	{
		ref = FrameBeacon.initialize() ;
	}

	public function tearDown():Void
	{
		FrameBeacon.release() ;		
		delete ref ;
	}

	public function testRunning():Void 
	{
		assertFalse(FrameBeacon.running, "FB_01_01 - running property failed.") ;
		FrameBeacon.start() ;
		assertTrue(FrameBeacon.running, "FB_01_02 - running property failed.") ;
		FrameBeacon.stop() ;
		assertFalse(FrameBeacon.running, "FB_01_03 - running property failed.") ;
	}
	
	public function testAddFrameListener():Void
	{
		var o:Object = {} ;
		FrameBeacon.addFrameListener(o) ;
		assertEquals(FrameBeacon.size(), 1, "FB_02 - addFrameListener method failed.") ;
		FrameBeacon.removeFrameListener(o) ;
	}

	public function testContainsListener():Void
	{
		var o:Object = {} ;
		FrameBeacon.addFrameListener(o) ;
		assertTrue( FrameBeacon.containsListener( o ) , "FB_03 - containsListener method failed.") ;
		FrameBeacon.removeFrameListener(o) ;
	}

	public function testInitialize():Void
	{
		assertNotNull(ref, "FB_04 - initialize method failed.") ;
	}
	
	public function testIsEmpty():Void
	{
		assertTrue(FrameBeacon.isEmpty(), "FB_05 - isEmpty method failed.") ;
	}

	public function testIterator():Void
	{
		var o:Object = {} ;
		FrameBeacon.addFrameListener(o) ;
		var it:Iterator = FrameBeacon.iterator() ;
		assertTrue(it.hasNext(), "FB_06_01 - iterator method failed.") ;
		assertEquals(it.next(), o, "FB_06_02 - iterator method failed.") ;
		FrameBeacon.removeFrameListener(o) ;
	}

	public function testRelease():Void
	{
		tearDown() ;		
		assertUndefined(ref, "FB_07 - release method failed : " + ref) ;
		setUp() ;
	}
	
	public function testRemoveFrameListener():Void
	{
		var o:Object = {} ;
		FrameBeacon.addFrameListener(o) ;
		FrameBeacon.removeFrameListener(o) ;
		assertEquals(FrameBeacon.size(), 0, "FB_08 - removeFrameListener method failed.") ;
	}
	
	public function testSize():Void
	{
		var o:Object = {} ;
		FrameBeacon.addFrameListener(o) ;
		assertEquals(FrameBeacon.size(), 1, "FB_09_01 - size method failed.") ;
		FrameBeacon.addFrameListener(o) ;
		assertEquals(FrameBeacon.size(), 1, "FB_09_02 - size method failed.") ;
		FrameBeacon.removeFrameListener(o) ;
	}

	public function testStart():Void
	{
		FrameBeacon.start() ;
		assertTrue(FrameBeacon.running, "FB_10 - start method failed.") ;
		FrameBeacon.stop() ;
	}
	
	public function testStop():Void
	{
		FrameBeacon.start() ;
		FrameBeacon.stop() ;
		assertFalse(FrameBeacon.running, "FB_11 - stop method failed.") ;
	}

	public function testToString():Void
	{
		assertEquals(FrameBeacon.toString(), "[FrameBeacon]", "FB_12 - toString method failed : " + FrameBeacon.toString()) ;
	}

}