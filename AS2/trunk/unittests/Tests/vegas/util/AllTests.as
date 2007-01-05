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
class Tests.vegas.util.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.util" );
        
        // suite.simpleTrace = true;

		suite.addTest( Tests.vegas.util.comparators.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.factory.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.format.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.mvc.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.observer.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.serialize.AllTests.suite() ) ;
		suite.addTest( Tests.vegas.util.visitor.AllTests.suite() ) ;

        // suite.addTest( new TestSuite( Tests.vegas.util.TestAbstactTimer ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestAbstractTypeable ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestArrayUtil ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestAttribute ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestBooleanUtil ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestComparater ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.util.TestConstructorUtil ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestCopier ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestDateUtil ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestFrameBeacon ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestFrameTimer ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestFunctionTimer ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.util.TestMathsUtil ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.util.TestMixin ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestNumberUtil ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestObjectUtil ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.util.TestResolverProxy ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestStringUtil ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestTimer ) ) ;
        // suite.addTest( new TestSuite( Tests.vegas.util.TestTypeUtil ) ) ;
        
        return suite ;
    
    }

}