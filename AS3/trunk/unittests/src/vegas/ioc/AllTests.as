/*

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

package vegas.ioc  
{
    import buRRRn.ASTUce.framework.ITest;
    import buRRRn.ASTUce.framework.TestSuite;
    
    import vegas.ioc.evaluators.AllTests;
    import vegas.ioc.factory.AllTests;
    import vegas.ioc.io.AllTests;
    
    public class AllTests
    {
        public static function suite():ITest
        {
            var suite:TestSuite = new TestSuite( "veags.ioc unit tests" );
            
            // FIXME suite.addTestSuite( IObjectDefinitionTest ) ;
            // FIXME suite.addTestSuite( IObjectDefinitionContainerTest ) ;
            
            suite.addTest( vegas.ioc.evaluators.AllTests.suite() ) ;
            suite.addTest( vegas.ioc.factory.AllTests.suite() ) ;
            suite.addTest( vegas.ioc.io.AllTests.suite() ) ;
            // FIXME suite.addTest( vegas.ioc.net.AllTests.suite() ) ;
            
            return suite;
        }
    }
}
