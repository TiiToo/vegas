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
import buRRRn.ASTUce.TestSuite;

/**
 * @author eKameleon
 */
class Tests.vegas.events.AllTests extends TestCase 
{

	/**
	 * Creates a new AllTests instance.
	 */	
	function AllTests(name : String) 
	{
		super(name);
	}

	/**
	 * Creates the Test list.
	 */
    static function suite():TestSuite
	{
        var suite:TestSuite = new TestSuite( "Tests.vegas.events" );
        
        //suite.simpleTrace = true;

		suite.addTest( Tests.vegas.events.type.AllTests.suite() ) ;

		// interfaces

        // suite.addTest( new TestSuite( Tests.vegas.events.TestEvent) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventListener ) ) ;
		// suite.addTest( new TestSuite( Tests.vegas.events.TestEventTarget ) ) ;
		// suite.addTest( new TestSuite( Tests.vegas.events.TestIDispatcher ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestIEventDispatcher ) ) ;

		// class

        // suite.addTest( new TestSuite( Tests.vegas.events.TestAbstractCoreEventDispatcher ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestArrayEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestBasicEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestBooleanEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestDelegate ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestDynamicEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEDispatcher ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventDispatcher ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventListenerBatch ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventListenerCollection ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventListenerComparator ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventListenerProxy ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventPhase ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventQueue ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestEventType ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestFastDispatcher ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestFrontController ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestModelChangedEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestModelChangedEventType ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestNumberEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestStringEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestTextEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestTimerEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestTimerEventType ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestValidatorEvent ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.events.TestValidatorEventType ) ) ;
        
        return suite ;
    
    }

}