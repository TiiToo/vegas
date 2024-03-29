/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
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
class Tests.pegas.util.AllTests extends TestCase 
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

        var suite:TestSuite = new TestSuite( "Tests.pegas.util" );
        
        // TODO suite.simpleTrace = true;

		// TODO suite.addTest( new TestSuite( Tests.pegas.pegas.util.TestPlaneUtil ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.pegas.util.TestQuaternionUtil ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.pegas.util.TestVector3Util ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.pegas.util.TestVertexUtil ) ) ;
        
        return suite ;
    
    }

}