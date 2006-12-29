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

		// suite.addTest( new TestSuite( Tests.pegas.draw.TestAbstractPen ) );
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestAlign ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestArcPen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestArcType ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestBevelRectanglePen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestBezierPen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestBresenham ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestCanvas ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestCanvasTransform ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestCirclePen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestCorner ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestCornerRectangle ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestDashLinePen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestEasyPen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestEllipsePen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestFillMatrix ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestFillType ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestIPen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestIShape ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestLinePen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestMatrixType ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestRectanglePen ) ) ;
		// suite.addTest( new TestSuite( Tests.pegas.draw.TestRoundedRectanglePen ) ) ;
        
        return suite ;
    
    }

}