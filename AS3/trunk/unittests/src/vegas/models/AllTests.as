﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.models
{
    import buRRRn.ASTUce.framework.ITest;
    import buRRRn.ASTUce.framework.TestSuite;
    
    import vegas.models.maps.AllTests;
    
    public class AllTests
    {
        public static function suite():ITest
        {
            var suite:TestSuite = new TestSuite( "vegas.models" );
            
            // suites
            
            suite.addTest( vegas.models.maps.AllTests.suite() ) ;
            
            // cases
            
            // FIXME suite.addTestSuite( ChangeModelTest ) ;
            // FIXME suite.addTestSuite( CoreModelTest ) ;
            // FIXME suite.addTestSuite( CoreModelObjectTest ) ;
            // FIXME suite.addTestSuite( ModelTest ) ;
            // FIXME suite.addTestSuite( ModelCollectorTest ) ;
            // FIXME suite.addTestSuite( ModelObjectTest ) ;
            
            return suite;
        }
    }
}
