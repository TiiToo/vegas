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
import vegas.util.ResolverProxy;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestResolverProxy extends TestCase 
{

	function TestResolverProxy(name : String) 
	{
		super(name);
	}
	
	public var o:ResolverProxy ;
	
	public function setUp():Void
	{
		o = new ResolverProxy() ;
	}	
	
	public function testConstructor():Void
	{
		assertNotNull(o, "RP_01 - constructor failed, the instance not must be null." ) ;
		assertTrue(o instanceof vegas.util.ResolverProxy, "RP_01 - constructor failed." ) ;	
	}

	public function testInherit():Void
	{
		assertTrue(o instanceof CoreObject, "RP_02 - inherit CoreObject failed." ) ;
	}

	public function testInitialize():Void
	{
	
		var o1:Object = {} ;
		vegas.util.ResolverProxy.initialize(o1) ;
	
		var o2:Object = {} ;	
		o2.myMethod = function () 
		{
			return true ;
		} ;
	
		o1.proxy = o2 ;
		o1.setProxy( o2 ) ;
	
		var b:Boolean = o1.myMethod() ;
		assertTrue(b, "RP_03 - initialize failed." ) ;
	
	}

	public function testLinkedProxy():Void
	{
		var o1 = new vegas.util.ResolverProxy() ;
		o1.myMethod1 = function () 
		{
			return true ;
		} ;
		var o2 = new vegas.util.ResolverProxy() ;
		o2.myMethod2 = function () 
		{
			return true ;
		} ;
		o1.linkProxy(o2) ;
		assertTrue(o1.myMethod2(), "RP_04 - linkProxy failed." ) ;
		assertTrue(o2.myMethod1(), "RP_04 - linkProxy failed." ) ;
	}
	
	public function testGetProxy():Void
	{
		var proxy = {} ;
		proxy.myMethod = function () 
		{
			return true ;
		} ;
		var o = new vegas.util.ResolverProxy(proxy) ;
		assertEquals(o.getProxy(), proxy, "RP_05 - getProxy failed." ) ;
	}

	public function testSetProxy():Void
	{
		var proxy = {} ;
		proxy.myMethod = function () 
		{
			return true ;
		} ;
		var o = new vegas.util.ResolverProxy() ;
		o.setProxy(proxy) ;
		var result = o.myMethod() ;
		assertTrue(result, "RP_06 - setProxy failed : " + result ) ;
	}

}