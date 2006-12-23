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

import vegas.core.types.Char;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestChar extends TestCase 
{
	
	/**
	 * Creates a new TestChar instance.
	 */
	function TestChar(name : String) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:Char = new Char("hello") ;
		assertNotNull( o, "CHAR_00 - constructor is null") ;
		assertTrue( o instanceof Char , "CHAR_00 - constructor is an instance of Char.") ;
	}
	
	public function testInherit()
	{
		var o:Char = new Char("hello") ;
		assertTrue( o instanceof String , "CHAR_01 - inherit String failed.") ;
	}	
	
	public function testGetCode():Void
	{
		var code:Number = (new Char("hello")).getCode() ;
		assertEquals( code , 104, "CHAR_02 - getCode method failed : " + code) ;	
	}
	
	public function testHashCode():Void
	{
		var o:Char = new Char("hello") ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "CHAR_03 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new Char("hello") ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.Char(h)", "CHAR_04 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var result:String ;
		
		var o:Char ;
		
		o = new Char() ;
		assertEquals( o.toString() , "", "CHAR_05_01 - toString failed : " + o.toString()) ;
		
		o = new Char("a") ;
		assertEquals( o.toString() , "a", "CHAR_05_02 - toString failed : " + o.toString()) ;
		
		o = new Char("hello") ;
		assertEquals( o.toString() , "h", "CHAR_05_03 - toString failed : " + o.toString()) ;
		
	}


}