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

import vegas.util.NumberUtil;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestNumberUtil extends TestCase 
{

	function TestNumberUtil(name : String) 
	{
		super(name);
	}
	
	public function testClone():Void
	{
		var n:Number = 12 ;
		var clone:Number = NumberUtil.clone(n) ;
		assertEquals(n, clone, "N_U_01 - static clone() failed : " + clone ) ;
	}
	
	public function testCopy():Void
	{
		var n:Number = 12 ;
		var copy:Number = NumberUtil.clone(n) ;
		assertEquals(n, copy, "N_U_02 - static copy() failed : " + copy ) ;
	}
	
	public function testEquals():Void
	{
		assertTrue( NumberUtil.equals(2, 2), "N_U_03_01 - static equals method failed." ) ;
		assertFalse( NumberUtil.equals(2, 4), "N_U_03_02 - static equals method failed." ) ;
	}
	
	public function testToBoolean():Void
	{
		assertTrue( NumberUtil.toBoolean(2), "N_U_04_01 - static toBoolean method failed." ) ;
		assertFalse( NumberUtil.toBoolean(0), "N_U_04_02 - static toBoolean method failed." ) ;
		assertFalse( NumberUtil.toBoolean(NaN), "N_U_04_03 - static toBoolean method failed." ) ;
		assertFalse( NumberUtil.toBoolean(null), "N_U_04_04 - static toBoolean method failed." ) ;
	}
	
	public function testToExponential():Void
	{
		var num:Number = 77.1234;
		assertEquals( NumberUtil.toExponential(num) , '7.71234e+1' , "N_U_05_01 - static toExponential method failed." ) ;
		assertEquals( NumberUtil.toExponential(num, 4), '7.7123e+1' , "N_U_05_02 - static toExponential method failed." ) ;
		assertEquals( NumberUtil.toExponential(num, 2), '7.71e+1' , "N_U_05_03 - static toExponential method failed." ) ;
		assertEquals( NumberUtil.toExponential(77.1234), '7.71234e+1' , "N_U_05_04 - static toExponential method failed." ) ;
		assertEquals( NumberUtil.toExponential(77), '7.7e+1' , "N_U_05_05 - static toExponential method failed." ) ;
	}
	
	public function testToFixed():Void
	{
		var n:Number = 12345.6789 ;
		
		assertEquals( NumberUtil.toFixed( n ) , '12346' , "N_U_06_01 - static toFixed method failed." ) ;
		assertEquals( NumberUtil.toFixed( n , 1) , '12345.7' , "N_U_06_02 - static toFixed method failed.") ;
		assertEquals( NumberUtil.toFixed( n , 6 ) , '12345.678900' , "N_U_06_03 - static toFixed method failed." ) ;
		
		// FIXME : '123000000000000000000.00' in Mozilla examples for javascript 1.5
		assertEquals( NumberUtil.toFixed( 1.23e+20 , 2 ) , 1.23e+20, "N_U_06_04 - static toFixed method failed.") ;
		
		// FIXME : '0.00' in Mozilla examples for javascript 1.5
		assertEquals( NumberUtil.toFixed( 1.23e-10 , 2 ) , '0' , "N_U_06_05 - static toFixed method failed.") ;
	}

	public function testToNumber():Void
	{
		assertEquals( NumberUtil.toNumber(2), 2, "N_U_07_01 - static toNumber method failed." ) ;
	}
	
	public function testToObject():Void
	{
		assertTrue( NumberUtil.toObject(2) instanceof Number , "N_U_08_01 - static toObject method failed." ) ;
	}

	public function testToPrecision():Void
	{
		var num:Number = 5.123456 ;
		
		assertEquals( NumberUtil.toPrecision(num) , '5.123456' , "N_U_09_01 - static toPrecision method failed." ) ;
		assertEquals( NumberUtil.toPrecision(num, 4) , '5.123' , "N_U_09_02 - static toPrecision method failed." ) ;
		assertEquals( NumberUtil.toPrecision(num, 2) , '5.1' , "N_U_09_03 - static toPrecision method failed." ) ;
		assertEquals( NumberUtil.toPrecision(num, 1) , '5' , "N_U_09_04 - static toPrecision method failed." ) ;
		assertEquals( NumberUtil.toPrecision(1250, 2) , '1.3e+3' , "N_U_09_05 - static toPrecision method failed." ) ;
		assertEquals( NumberUtil.toPrecision(1250, 5) , '1250.0', "N_U_09_06 - static toPrecision method failed." ) ;
		
	}
	
}