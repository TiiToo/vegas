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

import vegas.core.CoreObject;
import vegas.core.types.NullObject;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestNullObject extends TestCase 
{
	
	/**
	 * Creates a new TestNullObject instance.
	 */
	function TestNullObject(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:NullObject = new NullObject() ;
		assertTrue( o instanceof NullObject , "NULLO_00 - constructor is an instance of NullObject.") ;
	}
	
	public function testInherit()
	{
		var o:NullObject = new NullObject() ;
		assertTrue( o instanceof CoreObject , "NULLO_01 - inherit CoreObject failed.") ;
	}	
	
	public function testValueOf():Void
	{
		var value:Number = (new NullObject()).valueOf() ;
		assertEquals( value , null, "NULLO_02 - valueOf method failed : " + value) ;	
	}
	
	public function testHashCode():Void
	{
		var o:NullObject = new NullObject() ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "NULLO_03 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new NullObject() ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.NullObject()", "NULLO_04 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var o:NullObject = new NullObject() ;
		assertEquals( o.toString() , "null", "NULLO_05_01 - toString failed : " + o.toString()) ;
	}


}