/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import buRRRn.ASTUce.TestCase;

import vegas.util.MathsUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestMathsUtil extends TestCase 
{

	function TestMathsUtil(name : String) 
	{
		super(name);
	}
	
	public function testClamp():Void
	{
		
		var n:Number ;
		n = MathsUtil.clamp(4, 5, 10) ;
		assertEquals(n, 5, "MU_01_01 - static clamp() failed : " + n ) ;
	
		n = MathsUtil.clamp(12, 5, 10) ;
		assertEquals(n, 10, "MU_01_02 - static clamp() failed : " + n ) ;
		
		n = MathsUtil.clamp(6, 5, 10) ;
		assertEquals(n, 6, "MU_01_03 - static clamp() failed : " + n ) ;

		try 
		{
			n = MathsUtil.clamp(null, 5, 10) ;
		}
		catch (e:Error) 
		{
			assertTrue( e instanceof vegas.errors.IllegalArgumentError , "MU_01_04 - static clamp() failed : " + e.toString() ) ;
		}
	}
	
	public function testGetPercent():Void
	{
		var n:Number ;
		
		n = MathsUtil.getPercent(25, 100) ;
		assertEquals(n, 25, "MU_02_01 - static getPercent() failed : " + n ) ;

		n = MathsUtil.getPercent(50, 200) ;
		assertEquals(n, 25, "MU_02_02 - static getPercent() failed : " + n ) ;

		n = MathsUtil.getPercent(0, 0) ;
		assertEquals(n, null, "MU_02_03 - static getPercent() failed : " + n ) ;
		
		n = MathsUtil.getPercent(-10, 0) ;
		assertEquals(n, null, "MU_02_04 - static getPercent() failed : " + n ) ;
	
	}
	
	public function testRound():Void
	{
		var n:Number ;

		n = MathsUtil.round(4.572525153, 2) ;
		assertEquals(n, 4.57, "MU_03_01 - static round() failed : " + n ) ;
	
		n = MathsUtil.round(4.572525153, -1) ;
		assertEquals(n, 5, "MU_03_02 - static round() failed : " + n ) ;
		
		try 
		{
			n = MathsUtil.round(null, 5) ;
		}
		catch (e:Error) 
		{
			assertTrue( e instanceof vegas.errors.IllegalArgumentError , "MU_03_03 - static round() failed" ) ;
		}
	}
	
	public function testSign():Void
	{
		var n:Number ;
		n = MathsUtil.sign(-150) ;
		assertEquals(n, -1, "MU_04_01 - static sign() failed : " + n ) ;
	
		n = MathsUtil.sign(200) ;
		assertEquals(n, 1, "MU_04_02 - static sign() failed : " + n ) ;
		
		n = MathsUtil.sign(0) ;
		assertEquals(n, 1, "MU_04_03 - static sign() failed : " + n ) ;

		try 
		{
			n = MathsUtil.sign(null) ;
		}
		catch (e:Error) 
		{
			assertTrue( e instanceof vegas.errors.IllegalArgumentError , "MU_03_04 - static sign() failed" ) ;
		}
	}
}