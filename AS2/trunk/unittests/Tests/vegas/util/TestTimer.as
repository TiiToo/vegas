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

import vegas.util.Timer;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestTimer extends TestCase
{
	
	function TestTimer( name:String ) 
	{
		super(name);
	}

	public var t:Timer ;
	
	public function setUp():Void
	{
		t = new Timer( 1000, 20 ) ;
	}

	/*override*/ public function clear():Void 
	{
		t.run() ;
		assertFalse( isNaN(t.getIntervalID()), "TIMER_01_01 run method failed." ) ;
		t.clear() ;
		assertTrue( isNaN(t.getIntervalID()), "TIMER_01_02 clear method failed." ) ;
	}

	public function TestClone():Void 
	{
		assertTrue(t.clone() instanceof Timer, "TIMER_02 clone method failed." ) ;
	}

	public function TestCopy():Void 
	{
		assertTrue(t.copy() instanceof Timer, "TIMER_03 clone method failed." ) ;
	}

	public function TestRun():Void 
	{
		assertTrue( isNaN(t.getIntervalID()), "TIMER_04_01 run method failed." ) ;
		t.run() ;
		assertFalse( isNaN(t.getIntervalID()), "TIMER_04_02 run method failed." ) ;
		t.clear() ;
	}

}