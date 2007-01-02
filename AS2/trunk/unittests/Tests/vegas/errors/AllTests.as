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
class Tests.vegas.errors.AllTests extends TestCase 
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
        var suite:TestSuite = new TestSuite( "Tests.vegas.errors" );
        
        suite.simpleTrace = true ;

		suite.addTest( new TestSuite( Tests.vegas.errors.TestAbstractError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestArgumentOutOfBoundsError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestArgumentsError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestConcurrentModificationError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestErrorElement ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestErrorFormat ) ) ; 
		suite.addTest( new TestSuite( Tests.vegas.errors.TestFatalError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestIllegalArgumentError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestIllegalStateError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestIndexOutOfBoundsError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestNoSuchElementError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestNullPointerError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestNumberFormatError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestRangeError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestRuntimeError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestTypeMismatchError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestUnsupportedOperation ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestValueOutOfBoundsError ) ) ;
		suite.addTest( new TestSuite( Tests.vegas.errors.TestWarning ) ) ;
        
        return suite ;
    
    }

}