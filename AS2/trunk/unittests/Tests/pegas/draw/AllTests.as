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
class Tests.pegas.draw.AllTests extends TestCase 
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

        var suite:TestSuite = new TestSuite( "Tests.pegas.draw" );
        
        //suite.simpleTrace = true;

		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestAbstractPen ) );
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestAlign ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestArcPen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestArcType ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestBevelRectanglePen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestBezierPen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestBresenham ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestCanvas ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestCanvasTransform ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestCirclePen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestCorner ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestCornerRectangle ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestDashLinePen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestEasyPen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestEllipsePen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestFillMatrix ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestFillType ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestIPen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestIShape ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestLinePen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestMatrixType ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestRectanglePen ) ) ;
		// TODO suite.addTest( new TestSuite( Tests.pegas.draw.TestRoundedRectanglePen ) ) ;
        
        return suite ;
    
    }

}