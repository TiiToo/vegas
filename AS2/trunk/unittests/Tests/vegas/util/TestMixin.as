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
import vegas.core.IRunnable;
import vegas.util.Mixin;

/**
 * @author eKameleon
 */
class Tests.vegas.util.TestMixin extends TestCase 
{

	function TestMixin(name : String) 
	{
		super(name);
	}
	
	public var mixin:Mixin ;
	
	public function setUp():Void
	{
		mixin = new vegas.util.Mixin() ;
	}	
	
	public function testConstructor():Void
	{
		assertNotNull(mixin, "MIX_01_01 - constructor failed, the instance not must be null." ) ;
		assertTrue(mixin instanceof vegas.util.Mixin, "MIX_01_02 - constructor failed." ) ;	
	}

	public function testInherit():Void
	{
		assertTrue(mixin instanceof CoreObject, "MIX_02 - inherit CoreObject failed." ) ;
	}
	
	public function testImplements():Void
	{
		assertTrue(mixin instanceof IRunnable, "MIX_03 - implements IRunnable failed." ) ;
	}

	public function testGetAttributes():Void
	{
		var mixin = new vegas.util.Mixin(null, null, ["test"]) ;
		var ar:Array = mixin.getAttributes() ;
		assertTrue(ar instanceof Array, "MIX_04 - getAttributes failed : " + ar ) ;
	}
	
	public function testGetConstructor():Void
	{
		var MyConstructor = function() {} ;
		var mixin = new vegas.util.Mixin( MyConstructor, null, null) ;
		var result = mixin.getConstructor() ;
		assertTrue(result instanceof Function, "MIX_05 - getConstructor failed." ) ;
	}

	public function testGetTarget():Void
	{
		var o = {} ;
		var mixin = new vegas.util.Mixin( null, o, null) ;
		var result = mixin.getTarget() ;
		assertEquals(result, o, "MIX_06 - getTarget failed." ) ;
	}

	public function testRun():Void
	{
		var MyConstructor:Function = function() {} ;
		MyConstructor.prototype.myMethod = function () 
		{
			return true ;
		} ;
		var o = {} ;
		var mixin = new vegas.util.Mixin( MyConstructor, o, ["myMethod"]) ;
		try 
		{
			mixin.run() ;
		}
		catch(e) 
		{
			fail("MIX_07_01 - run failed." ) ;
		}
		var result = o.myMethod() ;
		assertTrue(result, "MIX_07_02 - run failed.") ;
	}

	public function testSetAttributes():Void
	{
		var mixin:Mixin = new vegas.util.Mixin() ;
		mixin.setAttributes(["test"]) ;
		var result = mixin.getAttributes() instanceof Array ;
		assertTrue( result, "MIX_07 - setAttributes failed." ) ;
	}

	public function testSetConstructor():Void
	{
		var MyConstructor:Function = function() {} ;
		var mixin = new vegas.util.Mixin() ;
		mixin.setConstructor(MyConstructor) ;
		var result = mixin.getConstructor() ;
		assertTrue(result instanceof Function, "MIX_08 - setConstructor failed." ) ;
	}

	public function testSetTarget():Void
	{
		var o = {} ;
		var mixin = new vegas.util.Mixin() ;
		mixin.setTarget(o) ;
		var result = mixin.getTarget() ;
		assertEquals(result, o, "MIX_09 - setTarget failed." ) ;
	}

}