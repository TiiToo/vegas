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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas  
{
	import buRRRn.ASTUce.framework.ITest;
	import buRRRn.ASTUce.framework.TestSuite;
	
	import pegas.colors.AllTests;	
    import pegas.draw.AllTests; 
    import pegas.events.AllTests;
    import pegas.geom.AllTests; 
    import pegas.maths.AllTests;
    import pegas.transitions.AllTests;
    import pegas.util.AllTests;
    
	/**
	 * This class launch all tests.
	 * @author eKameleon
	 */
	public class AllTests
	{
		
        /**
         * Creates the Test list.
         */		
        public static function suite():ITest
        {
            var suite:TestSuite = new TestSuite( "pegas" );
            
            suite.addTest( pegas.colors.AllTests.suite()  ) ;
            suite.addTest( pegas.draw.AllTests.suite()  ) ;
            suite.addTest( pegas.events.AllTests.suite()  ) ;
            suite.addTest( pegas.geom.AllTests.suite()  ) ;
            suite.addTest( pegas.maths.AllTests.suite()  ) ;
            suite.addTest( pegas.transitions.AllTests.suite()  ) ;
            suite.addTest( pegas.util.AllTests.suite()  ) ;
            
            return suite;
        }
	}
}

