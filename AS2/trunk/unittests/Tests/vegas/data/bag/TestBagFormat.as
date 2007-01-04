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
import vegas.core.IFormat;
import vegas.data.Bag;
import vegas.data.bag.BagFormat;
import vegas.data.bag.HashBag;
import vegas.data.collections.SimpleCollection;

/**
 * @author eKameleon
 */
class Tests.vegas.data.bag.TestBagFormat extends TestCase 
{

	function TestBagFormat(name : String) 
	{
		super(name);
	}
	
	public var f:BagFormat ;
	
	public function setUp():Void
	{
		f = new BagFormat() ;
	}	

	public function testConstructor()
	{
		assertNotNull( f, "ER_FORM_00_01 - constructor is null") ;
		assertTrue( f instanceof BagFormat , "BAG_FORM_00_02 - constructor is an instance of ErrorFormat.") ;
	}
	
	public function testInherit()
	{
		assertTrue( f instanceof CoreObject , "BAG_FORM_01 - inherit CoreObject failed.") ;
	}
	
	public function testImplement()
	{
		assertTrue( f instanceof IFormat , "BAG_FORM_01 - inherit CoreObject failed.") ;
	}		
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(f.hashCode()) , "BAG_FORM_02 - hashCode failed : " + f.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( f.toString() , "[BagFormat]", "BAG_FORM_03 - toString failed : " + f.toString() ) ;
	}

	public function testFormatToString():Void
	{
		var b:Bag = new HashBag() ;
		assertEquals( f.formatToString(b) , "{}" , "BAG_FORM_04_01 - formatToString failed : " + f.formatToString(b)) ;
		b.insertAll( new SimpleCollection(["item1", "item2", "item2", "item3"]) ) ;
		assertEquals( f.formatToString(b) , "{1:item1,2:item2,1:item3}" , "BAG_FORM_04_02 - formatToString failed : " + f.formatToString(b)) ;
	}

}