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
class Tests.vegas.core.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.core" );
        
        //suite.simpleTrace = true;

		suite.addTest(  Tests.vegas.core.types.AllTests.suite() ) ;

        suite.addTest( new TestSuite( Tests.vegas.core.TestCoreObject ) );
        suite.addTest( new TestSuite( Tests.vegas.core.TestHashCode ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestICloneable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIComparable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIComparator ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIConvertible ) ) ;
       	suite.addTest( new TestSuite( Tests.vegas.core.TestICopyable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIEquality ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIFactory ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIFormat ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIFormattable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIHashable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIRunnable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestISerializable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestITimer ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestITypeable ) ) ;
        suite.addTest( new TestSuite( Tests.vegas.core.TestIValidator ) ) ;
        
        return suite ;
    
    }

}