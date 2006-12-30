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

import vegas.events.DynamicEvent;
import vegas.logging.LogEvent;
import vegas.logging.LogEventLevel;

/**
 * @author eKameleon
 */
class Tests.vegas.logging.TestLogEvent extends TestCase
{
	
	function TestLogEvent( name:String ) 
	{
		super(name);
	}

	public var e:LogEvent ;
	
	public function setUp():Void
	{
		e = new LogEvent("hello world" , LogEventLevel.DEBUG ) ; 
	}

	public function testConstructor()
	{
		assertNotNull( e, "LOGE_00_01 - constructor is null") ;
		assertTrue( e instanceof LogEvent , "LOGE_00_02 - constructor is an instance of LogEvent.") ;
	}
	
	public function testInherit()
	{
		assertTrue( e instanceof DynamicEvent , "LOGE_01 - inherit DynamicEvent failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(e.hashCode()) , "LOGE_02 - hashCode failed : " + e.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertTrue( typeof(e.toSource()) == "string", "LOGE_03 - toSource failed : " + e.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( e.toString() , "[LogEvent log, AT TARGET, bubbles]", "LOGE_04 - toString failed : " + e.toString() ) ;
	}

	public function testLOG():Void
	{
		assertEquals( LogEvent.LOG , "log" , "LOGE_05 - LogEvent.LOG constant failed : " + LogEvent.LOG) ;	
	}

	public function testMessage():Void
	{
		assertEquals( e.message , "hello world" , "LOGE_06 - message property failed : " + e.message) ;	
	}
	
	public function testLevel():Void
	{
		assertEquals( e.level , LogEventLevel.DEBUG , "LOGE_07 - level property failed : " + e.level ) ;	
	}

	public function testClone():Void
	{
		var clone = e.clone() ;
		assertTrue  ( clone instanceof LogEvent, "LOGE_08_01 - clone failed, isn't an instance of LogEvent." ) ;
		assertEquals( clone.message , e.message , "LOGE_08_02 - clone message failed : " + clone.message ) ;
		assertEquals( clone.level , e.level , "LOGE_08_03 - clone level failed : " + clone.level ) ;
	}
	
	public function testGetLevelString():Void
	{
		assertEquals( LogEvent.getLevelString( LogEventLevel.ALL   ) , "ALL"     , "LOGE_09_01 - getLevelString failed.") ;
		assertEquals( LogEvent.getLevelString( LogEventLevel.DEBUG ) , "DEBUG"   , "LOGE_09_02 - getLevelString failed.") ;
		assertEquals( LogEvent.getLevelString( LogEventLevel.ERROR ) , "ERROR"   , "LOGE_09_03 - getLevelString failed.") ;
		assertEquals( LogEvent.getLevelString( LogEventLevel.FATAL ) , "FATAL"   , "LOGE_09_04 - getLevelString failed.") ;
		assertEquals( LogEvent.getLevelString( LogEventLevel.INFO  ) , "INFO"    , "LOGE_09_05 - getLevelString failed.") ;
		assertEquals( LogEvent.getLevelString( LogEventLevel.WARN  ) , "WARN"    , "LOGE_09_06 - getLevelString failed.") ;
		assertEquals( LogEvent.getLevelString(                     ) , "UNKNOWN" , "LOGE_09_07 - getLevelString failed.") ;
	}

}