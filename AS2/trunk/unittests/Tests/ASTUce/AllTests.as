
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASTUce: ActionScript Test Unit compact edition AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

import buRRRn.ASTUce.*;

class Tests.ASTUce.AllTests extends TestCase
    {
    
    function AllTests( name )
        {
        super( name );
        }
    
    static function suite():TestSuite
        {
        var suite:TestSuite = new TestSuite( "ASTUce Tests" );
        
        /* note:
           to shorten the detail display you can also directly
           define the simpleTrace argument to a TestSuite.
        */
        //suite.simpleTrace = true;
        
        suite.addTest( new TestSuite( Tests.ASTUce.AssertionTest ) );
        suite.addTest( new TestSuite( Tests.ASTUce.ComparisonFailureTest ) );
        suite.addTest( new TestSuite( Tests.ASTUce.TestListenerTest ) );
        suite.addTest( new TestSuite( Tests.ASTUce.TestCaseTest ) );
        suite.addTest( Tests.ASTUce.SuiteTest.suite() );
        
        return suite;
        }
    
    }

