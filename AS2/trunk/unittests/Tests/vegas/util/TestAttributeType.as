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

import vegas.util.AttributeType ;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestAttributeType extends TestCase 
{

	function TestAttributeType(name : String) 
	{
		super(name);
	}

	public function testNONE_ONLY():Void
	{
		assertEquals( AttributeType.NONE , 0, "ATTR_TYP_01 - NONE failed : " + AttributeType.NONE) ;
	}

	public function testDONT_ENUM():Void
	{
		assertEquals( AttributeType.DONT_ENUM , 1, "ATTR_TYP_02 - DONT_ENUM failed : " + AttributeType.DONT_ENUM) ;
	}

	public function testDONT_DELETE():Void
	{
		assertEquals( AttributeType.DONT_DELETE , 2, "ATTR_TYP_03 - DONT_DELETE failed : " + AttributeType.DONT_DELETE) ;
	}
	
	public function testOVERRIDE_ONLY():Void
	{
		assertEquals( AttributeType.OVERRIDE_ONLY , 3, "ATTR_TYP_04 - OVERRIDE_ONLY failed : " + AttributeType.OVERRIDE_ONLY) ;
	}

	public function testREAD_ONLY():Void
	{
		assertEquals( AttributeType.READ_ONLY , 4, "ATTR_TYP_05 - READ_ONLY failed : " + AttributeType.READ_ONLY) ;
	}

	public function testDELETE_ONLY():Void
	{
		assertEquals( AttributeType.DELETE_ONLY , 5, "ATTR_TYP_06 - DELETE_ONLY failed : " + AttributeType.DELETE_ONLY) ;
	}

	public function testENUM_ONLY():Void
	{
		assertEquals( AttributeType.ENUM_ONLY , 6, "ATTR_TYP_07 - ENUM_ONLY failed : " + AttributeType.ENUM_ONLY ) ;
	}
	
	public function testLOCKED():Void
	{
		assertEquals( AttributeType.LOCKED , 7, "ATTR_TYP_08 - LOCKED failed") ;
	}

}