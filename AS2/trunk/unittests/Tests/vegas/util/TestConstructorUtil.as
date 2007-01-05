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

import vegas.data.map.HashMap;
import vegas.data.map.MultiHashMap;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestConstructorUtil extends TestCase 
{

	function TestConstructorUtil(name : String) 
	{
		super(name);
	}
	
	public function testCreateBasicInstance():Void
	{
		var i = vegas.util.ConstructorUtil.createBasicInstance( Array ) ;
		assertTrue( i instanceof Array , "CU_01 - static createBasicInstance failed" ) ;
	}

	public function testCreateInstance():Void
	{
		var MyConstructor:Function = function( arg ) 
		{
			this.arg = arg ;
		} ;
		var i = vegas.util.ConstructorUtil.createInstance( MyConstructor , ["test"] ) ;
		assertTrue( i instanceof MyConstructor , "CU_02_01 - static createInstance() failed" ) ;
		assertTrue( i.arg == "test" ,  "CU_02_02 - static createInstance failed" ) ;
	}	

	public function testGetName():Void
	{
		var o = new vegas.core.CoreObject() ;
		var result = vegas.util.ConstructorUtil.getName(o) ;
		assertEquals( result, "CoreObject" ,  "CU_03 - static getName failed : " + result) ;
	}

	public function testGetPackage():Void
	{
		var o = new vegas.core.CoreObject() ;
		var result = vegas.util.ConstructorUtil.getPackage(o) ;
		assertEquals( result, "vegas.core" ,  "CU_04 - static getPackage failed : " + result) ;
	}
	
	public function testGetPath():Void
	{
		var o = new vegas.core.CoreObject() ;
		var result = vegas.util.ConstructorUtil.getPath(o) ;
		assertEquals( result, "vegas.core.CoreObject",  "CU_05 - static getPath failed : " + result) ;
	}
	
	public function testIsImplementationOf():Void
	{
		var HashMap = vegas.data.map.HashMap ;
		var Map = vegas.data.Map ;
		var result = vegas.util.ConstructorUtil.isImplementationOf( HashMap, Map ) ;
		assertTrue (result, "CU_06 - static isImplementationOf failed : " + result ) ;
	}

	public function testIsSubConstructorOf():Void
	{
		var result = vegas.util.ConstructorUtil.isSubConstructorOf( MultiHashMap , HashMap) ;
		assertTrue (result, "CU_07 - static isSubConstructorOf failed : " + result ) ;
	}

}