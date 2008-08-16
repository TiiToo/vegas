﻿
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [eden: ECMASCript data exchange notation for AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system.eden
{
    import buRRRn.ASTUce.framework.*;        

    /* TestSuite that runs all the eden tests
    */
    public class AllTests
        {
        
        public function AllTests()
            {
            
            }
        
        public static function suite():ITest
            {
            var suite:TestSuite = new TestSuite( "All eden tests" );
            
            suite.addTestSuite( GenericParserTest );
            suite.addTestSuite( DeserializeTest );
            suite.addTestSuite( SerializeTest );
            
            return suite;
            }
        
        }
    
    }
