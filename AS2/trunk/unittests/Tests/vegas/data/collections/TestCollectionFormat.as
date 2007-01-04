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
import vegas.data.Collection;
import vegas.data.collections.CollectionFormat;
import vegas.data.collections.SimpleCollection;

/**
 * @author eKameleon
 */
class Tests.vegas.data.collections.TestCollectionFormat extends TestCase 
{

	function TestCollectionFormat(name : String) 
	{
		super(name);
	}
	
	public var f:CollectionFormat ;
	
	public function setUp():Void
	{
		f = new CollectionFormat() ;
	}	

	public function testConstructor()
	{
		assertNotNull( f, "CO_FORM_00_01 - constructor is null") ;
		assertTrue( f instanceof CollectionFormat , "CO_FORM_00_02 - constructor is an instance of CollectionFormat.") ;
	}
	
	public function testInherit()
	{
		assertTrue( f instanceof CoreObject , "CO_FORM_01 - inherit CoreObject failed.") ;
	}
	
	public function testImplement()
	{
		assertTrue( f instanceof IFormat , "CO_FORM_01 - inherit CoreObject failed.") ;
	}		
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(f.hashCode()) , "CO_FORM_02 - hashCode failed : " + f.hashCode() ) ;
	}
	
	public function testToString():Void
	{
		assertEquals( f.toString() , "[CollectionFormat]", "CO_FORM_03 - toString failed : " + f.toString() ) ;
	}

	public function testFormatToString():Void
	{
		var c:Collection = new SimpleCollection() ;
		assertEquals( f.formatToString(c) , "{}" , "CO_FORM_04_01 - formatToString failed : " + f.formatToString(c)) ;
		c.insert("item1") ;
		c.insert("item2") ;
		assertEquals( f.formatToString(c) , "{item1,item2}" , "CO_FORM_04_02 - formatToString failed : " + f.formatToString(c)) ;
	}

}