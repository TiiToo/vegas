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

import vegas.core.HashCode;

/**
 * @author eKameleon
 */
class Tests.vegas.core.TestHashCode extends TestCase 
{
	
	function TestHashCode( name:String ) 
	{
		super(name);
	}
	
	public function testEquals()
	{
		var o = {} ;
		var value = HashCode.equals(o, o) ;
		assertTrue( value , "HASH_01 - equals method failed : " + value) ;
	}

	public function testIdentify():Void 
	{
		var o = {} ;
		var value = HashCode.identify(o) ;
		assertTrue( !isNaN(value) , "HASH_02 - identifiy method failed : " + value) ;
	}
	
	public function testNext():Void 
	{
		var value = HashCode.next() ;
		assertTrue( !isNaN(value) , "HASH_03 - next method failed, the value is not a number : " + value) ;
	}

	public function testNextName():Void 
	{
		var o = {} ;
		var previous = HashCode.identify(o) ;
		var next = HashCode.nextName() ;
		assertTrue( Number(next) > previous , "HASH_04 - nextName method failed, previous:" + previous + ", next:" + next ) ;
	}
	
	public function testInitialize():Void 
	{
		var o = {} ;
		var b = HashCode.initialize(o) ;
		assertNotUndefined(o["hashCode"] , "HASH_05_00 - initialize method failed the hashCode method not must be undefined." ) ;
		assertNotNull( o["hashCode"] , "HASH_05_01 - initialize method failed." ) ;
		assertEquals( typeof o["hashCode"] , "function" , "HASH_05_02 - initialize method failed : " + typeof o["hashCode"] ) ;
		assertTrue( b , "HASH_05_03 - initialize method failed : " + b ) ;
		assertFalse( isNaN(o.hashCode()) , "HASH_05_04 - initialize method failed : " + o.hashCode() ) ; 
	}
	
	public function testCompare():Void
	{
		var o1 = {} ;
		var o2 = {} ;
		assertEquals( HashCode.compare(o1, o1) , 0 , "HASH_06_01 - compare method failed : " + HashCode.compare(o1, o1) ) ;
		assertEquals( HashCode.compare(o1, o2) , -1 , "HASH_06_02 - compare method failed : " + HashCode.compare(o1, o2) ) ;
		assertEquals( HashCode.compare(o2, o1) , 1 , "HASH_06_03 - compare method failed : " + HashCode.compare(o2, o1) ) ;
	}

}