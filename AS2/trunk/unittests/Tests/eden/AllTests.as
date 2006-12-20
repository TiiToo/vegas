
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

import buRRRn.ASTUce.*;

class Tests.eden.AllTests extends TestCase
    {
    
    function AllTests( name )
        {
        super( name );
        }
    
    static function suite():TestSuite
        {
        var suite:TestSuite = new TestSuite( "eden Tests" );
        
        /* note:
           to shorten the detail display you can also directly
           define the simpleTrace argument to a TestSuite.
        */
        //suite.simpleTrace = true;
        
        suite.addTest( new TestSuite( Tests.eden.GenericParserTest ) );
        suite.addTest( new TestSuite( Tests.eden.ECMAScriptTest ) );
        
        return suite;
        }
    
    }

