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
import vegas.data.Set;
import vegas.data.set.HashSet;
import vegas.util.ResolverMultiProxy;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestResolverMultiProxy extends TestCase 
{

	function TestResolverMultiProxy(name:String) 
	{
		super(name);
	}
	
	public var b1:Boolean = false ;
	
	public var b2:Boolean = false ;
	
	public var o:ResolverMultiProxy ;
	
	public var o1:Object ;
	
	public var o2:Object ;
		
	public function setUp():Void
	{
		
		o1 = {} ;
		o1.owner = this ;
		o1.prop1 = 1 ;
		o1.toString = function() 
		{ 
			return "object1" ;
		} ;
		o1.method1 = function( message:String )
		{
			return "method1 : " + message ;
		} ;

		o2 = {} ;
		o2.owner = this ;
		o2.toString = function() 
		{ 
			return "object2" ;
		} ;
		o2.prop2 = 2 ;
		o2.method2 = function( message:String )
		{
			return "method2 : " + message ;
		} ;
		
		o = new ResolverMultiProxy() ;
	}	
	
	public function testConstructor():Void
	{
		assertNotNull(o, "RMP_01 - constructor failed, the instance not must be null." ) ;
		assertTrue(o instanceof ResolverMultiProxy, "RMP_01 - constructor failed." ) ;	
	}

	public function testInherit():Void
	{
		assertTrue(o instanceof CoreObject, "RMP_02 - inherit CoreObject failed." ) ;
	}

	public function testAddProxy():Void 
	{
		assertTrue  (o.addProxy(o1), "RMP_03_01 - addProxy method failed.") ;
		assertFalse (o.addProxy(o1), "RMP_03_02 - addProxy method failed.") ;
		assertTrue  (o.addProxy(o2), "RMP_03_03 - addProxy method failed.") ;
		assertEquals( o.size(), 2, "RMP_03_04 - addProxy method failed : " + o.size() ) ;
		o.clear() ;
	}

	public function testClear():Void
	{
		o.addProxy(o1) ;
		o.clear() ;
		assertEquals( o.size(), 0, "RMP_04 - clear method failed.") ;
	}

	public function testContainsProxy():Void 
	{
		o.addProxy(o1) ;
		assertTrue( o.containsProxy(o1), "RMP_05 - contains method failed : " + o.containsProxy(o1) ) ;
		o.clear() ;
	}

	public function testGetUniqueSet():Void
	{
		o.addProxy(o1) ;
		o.addProxy(o2) ;
		var s:Set = o.getUniqueSet() ;
		assertTrue(s instanceof HashSet, "RMP_05_01 - getUniqueSet method failed.") ;
		assertEquals(s.size(), 2, "RMP_05_02 - getUniqueSet method failed.") ;
		o.clear() ;
	}

	public function testRemoveProxy():Void 
	{
		o.addProxy(o1) ;
		o.removeProxy(o1) ;
		assertEquals(o.size(), 0, "RMP_06 - removeProxy method failed.") ;
		o.clear() ;
	}

	public function testResolve():Void 
	{
		
		o.addProxy(o1) ;
		o.addProxy(o2) ;
		
		var r1:String = o.method1("hello1") ;
		var r2:String = o.method2("hello2") ;
				
		assertEquals( r1, "method1 : hello1" , "RMP_07_01 - _resolve method failed : " + r1) ;
		assertEquals( r2, "method2 : hello2" , "RMP_07_02 - _resolve method failed : " + r2) ;
		
		assertEquals( o.prop1 , 1, "RMP_07_03 - _resolve method failed : " + o.prop1) ;
		assertEquals( o.prop2 , 2, "RMP_07_04 - _resolve method failed : " + o.prop2) ;
	}

	public function testSize():Void 
	{
		o.addProxy(o1) ;
		assertEquals(o.size(), 1, "RMP_08 - size method failed.") ;
		o.clear() ;
	}

}