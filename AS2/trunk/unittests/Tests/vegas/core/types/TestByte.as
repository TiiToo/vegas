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

import vegas.core.types.Bit;
import vegas.core.types.Byte;

/**
 * @author eKameleon
 */
class Tests.vegas.core.types.TestByte extends TestCase 
{
	
	/**
	 * Creates a new TestByte instance.
	 */
	function TestByte( name:String ) 
	{
		super(name);
	}
	
	public function testConstructor()
	{
		var o:Byte = new Byte(1) ;
		assertNotNull( o, "BYTE_00 - constructor is null") ;
		assertTrue( o instanceof Byte , "BYTE_00 - constructor is an instance of Byte.") ;
	}
	
	public function testInherit()
	{
		var o:Byte = new Byte(1) ;
		assertTrue( o instanceof Bit , "BYTE_01 - inherit Bit failed.") ;
	}	
	
	public function testHashCode():Void
	{
		var o:Byte = new Byte(1) ;
		var result = o.hashCode() ;
		assertTrue( !isNaN(result) , "BYTE_02 - hashCode failed : " + result ) ;
	}
	
	public function testToSource():Void
	{
		var o = new Byte(1) ;
		var result = o.toSource() ;
		assertEquals( result , "new vegas.core.types.Byte(1,2)", "BYTE_03 - toSource failed : " + result) ;
	}

	public function testToString():Void
	{
		var result:String ;
		
		var o:Byte ;
		
		o = new Byte(1) ;
		assertEquals( o.toString() , "1B", "BYTE_04_01 - toString failed : " + o.toString()) ;
		
		o = new Byte(1234) ;
		assertEquals( o.toString() , "1.21KB", "BYTE_04_02 - toString failed : " + o.toString()) ;
		
		o = new Byte(15002344) ;
		assertEquals( o.toString() , "14.31MB", "BYTE_04_03 - toString failed : " + o.toString()) ;
		
	}

	public function testConstants():Void
	{
		
		assertEquals( Byte.SHORT_BYTE      , "B"  , "BYTE_05_01 - Byte.SHORT_BYTE failed      : " + Byte.SHORT_BYTE      ) ;
		assertEquals( Byte.SHORT_KILO_BYTE , "KB" , "BYTE_05_02 - Byte.SHORT_KILO_BYTE failed : " + Byte.SHORT_KILO_BYTE ) ;
		assertEquals( Byte.SHORT_MEGA_BYTE , "MB" , "BYTE_05_03 - Byte.SHORT_MEGA_BYTE failed : " + Byte.SHORT_MEGA_BYTE ) ;
		assertEquals( Byte.SHORT_GIGA_BYTE , "GB" , "BYTE_05_04 - Byte.SHORT_GIGA_BYTE failed : " + Byte.SHORT_GIGA_BYTE ) ;
		assertEquals( Byte.SHORT_TERA_BYTE , "TB" , "BYTE_05_05 - Byte.SHORT_TERA_BYTE failed : " + Byte.SHORT_TERA_BYTE ) ;
		
	}
	

}