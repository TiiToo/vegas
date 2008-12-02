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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard  
{
    import asgard.display.*;
    import asgard.events.*;
    import asgard.managers.*;
    import asgard.media.*;
    import asgard.net.*;
    import asgard.process.*;
    import asgard.text.*;
    
    import buRRRn.ASTUce.framework.ITest;
    import buRRRn.ASTUce.framework.TestSuite;    

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
            var suite:TestSuite = new TestSuite( "asgard" );
            suite.addTest( asgard.display.AllTests.suite() ) ;
            suite.addTest( asgard.events.AllTests.suite() ) ;
            suite.addTest( asgard.managers.AllTests.suite() ) ;
            suite.addTest( asgard.media.AllTests.suite() ) ;
            suite.addTest( asgard.net.AllTests.suite() ) ;
            suite.addTest( asgard.process.AllTests.suite() ) ;
            suite.addTest( asgard.text.AllTests.suite() ) ;
            return suite;
        }
	}
}

