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
class Tests.vegas.data.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.data" );
        
        // suite.simpleTrace = true ;

		suite.addTest(  Tests.vegas.data.array.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.bag.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.collections.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.iterator.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.list.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.map.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.queue.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.set.AllTests.suite() ) ;
		suite.addTest(  Tests.vegas.data.stack.AllTests.suite() ) ;
		
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBag ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBidiMap ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBoundable ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBoundedCollection ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBoundedMap ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBoundedQueue ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBoundedSet ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestBoundedStack ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestCollection ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestDictionnary ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestEntry ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestEnumeration ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestList ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestMap ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestMultiMap ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestQueue ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestSet ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestSortedBag ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestSortedMap ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.data.TestStack ) ) ;
        
        return suite ;
    
    }

}