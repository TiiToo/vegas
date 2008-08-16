﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.i18n  
{
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
            
            var suite:TestSuite = new TestSuite( "AndromedAS i18n Test" );

            return suite;
            
        }
        
	}
}