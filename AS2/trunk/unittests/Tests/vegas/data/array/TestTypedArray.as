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

import vegas.data.array.TypedArray;
import vegas.data.iterator.Iterator;

// FIXME : bug in catch(e:TypeMismatchError in Flash but not in MTASC ??)

/**
 * @author eKameleon
 */
class Tests.vegas.data.array.TestTypedArray extends TestCase 
{
	
	/**
	 * Creates a new TestCoreObject instance.
	 */
	function TestTypedArray(name : String) 
	{
		super(name);
	}
	
	public var ta:TypedArray ;
	
	public function setUp():Void
	{
		ta = new TypedArray(Number, [2, 3, 1]) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( ta, "TA_01_01 - constructor is null") ;
		assertTrue( ta instanceof TypedArray , "TA_01_02 - constructor is an instance of TypedArray.") ;
	}
	
	public function testInherit()
	{
		assertTrue( ta instanceof Array , "TA_02 - inherit Array failed.") ;
	}	

	public function testHashCode():Void
	{
		assertFalse( isNaN(ta.hashCode()) , "TA_03 - hashCode failed : " + ta.hashCode() ) ;
	}

	public function testClone():Void
	{
		var clone:TypedArray = ta.clone() ;
		assertTrue( clone instanceof TypedArray , "TA_04_01 : clone method failed.") ;
		assertEquals( clone.length , ta.length  , "TA_04_02 : clone failed - not equals size." ) ;
		assertEquals( clone.getType() , Number  , "TA_04_03 : clone failed - not equals type." ) ;
		for (var i:Number = 0 ; i<clone.length ; i++) 
		{
			assertEquals( clone[i], ta[i], "TA_04_03 - clone failed, value in clone '" + clone[i] + "' not equals value in TypedArray '" + ta[i] + "'." ) ;
		}
	}
	
	public function testConcat():Void
	{
		try
		{
			var a:Array = ta.concat([4, 5, "test", 6]) ;
			assertTrue( a instanceof Array , "TA_05_01 : concat failed, must be an Array." ) ;
			assertEquals( a.length , 7     , "TA_05_02 : concat failed - size invalid : " + a.length ) ;
		}
		catch( e /*TypeMismatchError*/ )
		{
			return ;	
		}
		fail( "TA_05_03 : concat method failed, the concat method must throw an TypeMismatchError." ) ;
	}
	
	public function testIterator():Void
	{
		var it:Iterator = ta.iterator() ;
		assertTrue( it.hasNext() , "TA_06_01 : iterator failed.") ;
		assertEquals( it.next() , 2 , "TA_06_02 : iterator failed.") ;  
	}

	public function testGetType():Void
	{
		assertEquals( ta.getType(), Number, "TA_07 : getType failed.") ;
	}
	
	public function testPush()
	{
		var a:TypedArray = ta.clone() ;
		a.push( 4 ) ;
		assertEquals( a[3], 4, "TA_08_01 : push method failed with good type value.") ;
		try
		{
			a.push("test") ; // String
			fail("TA_08_02 : push failed with bad type value.") ;
		}
		catch( e /*TypeMismatchError*/ )
		{
			return ;
		}
		fail("TA_08_03 : push failed with bad type value.") ;
	}

	public function testSetType():Void
	{
		var a:TypedArray = ta.clone() ;
		a.setType( String ) ;
		assertEquals( a.length    , 0      , "TA_09_01 : setType failed, TypedArray length must be 0.") ;
		assertEquals( a.getType() , String , "TA_09_02 : setType failed, type must be String." ) ;
		try
		{
			a.push("hello world") ;
		}
		catch( e /*TypeMismatchError*/ )
		{
			fail( "TA_09_03 : setType failed, type must be String." ) ;
		}
		finally
		{
			
		}
	}

	public function testSupports():Void
	{
		var b:Boolean ;
		b = ta.supports(3) ;
		assertTrue(b, "TA_10_01 : supports(3) failed, must return true.") ;
		b = ta.supports("hello world") ;
		assertFalse(b, "TA_10_01 : supports('hello world') failed, must return true.") ;
	}

	public function testToSource():Void
	{
		assertEquals( ta.toSource() , "new vegas.data.array.TypedArray(Number,[2,3,1])", "TA_11 : toSource failed : " + ta.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( ta.toString() , "2,3,1", "TA_12 : toString failed : " + ta.toString() ) ;
	}

	public function testUnshift():Void
	{
		var a:TypedArray = ta.clone() ;
		var result:Number = a.unshift(0) ;
		
		assertEquals( a.length , 4, "TA_12_01 : unshift failed, not equals size : " + a.length ) ;
		assertEquals( a[0] , 0 ,    "TA_12_02 : unshift failed, not equals value." ) ;
		try
		{
			a.unshift("test") ;	
			fail("TA_12_03 : unshift failed with bad type value.") ;
		}
		catch( e /*TypeMismatchError*/ )
		{
			
		}
	} 

	public function testValidate():Void
	{
		try
		{
			ta.validate("test") ;
			fail( "TA_13_01 : validate failed with bad type value.") ;
		}
		catch( e /*TypeMismatchError*/ )
		{
			return ;	
		}
		fail("TA_13_02 : validate failed, the error thrown is an unknow error.") ;
	}

}