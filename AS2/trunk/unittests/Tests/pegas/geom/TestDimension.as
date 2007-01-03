/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import buRRRn.ASTUce.TestCase;

import pegas.geom.Dimension;
import pegas.geom.Rectangle;

import vegas.core.CoreObject;

/**
 * @author eKameleon
 */
class Tests.pegas.geom.TestDimension extends TestCase 
{
	
	function TestDimension(name:String) 
	{
		super(name);
	}
	
	public var d:Dimension;
	
	public function setUp():Void
	{
		d = new Dimension(100,200) ;
	}
	
	public function testConstructor()
	{
		assertNotNull( d, "DIM_00_01 - constructor is null") ;
		assertTrue( d instanceof Dimension, "DIM_00_02 - constructor is an instance of Plane.") ;
	}
	
	public function testInherit()
	{
		assertTrue( d instanceof CoreObject , "DIM_01 - inherit CoreObject failed.") ;
	}	
	
	public function testHashCode():Void
	{
		assertTrue( !isNaN(d.hashCode()) , "DIM_02 - hashCode failed : " + d.hashCode() ) ;
	}
	
	public function testToSource():Void
	{
		assertEquals( d.toSource() , "new pegas.geom.Dimension(100,200)", "DIM_03 - toSource failed : " + d.toSource() ) ;
	}

	public function testToString():Void
	{
		assertEquals( d.toString() , "[Dimension width:100,height:200]", "DIM_04 - toString failed : " + d.toString() ) ;
	}

	public function testWidth():Void
	{
		assertEquals( d.width , 100, "DIM_05 - width property failed : " + d.width ) ;
	}

	public function testHeight():Void
	{
		assertEquals( d.height , 200, "DIM_06 - height property failed : " + d.height ) ;
	}
	
	public function testClone():Void
	{
		var clone:Dimension = d.clone() ;
		clone.width = 10 ;
		clone.height = 20 ;
		assertTrue( clone instanceof Dimension , "DIM_09 - clone method failed, must return a Dimension reference." ) ;
		assertFalse( d.width == clone.width, "DIM_09 - clone property failed, d.width:" + d.width + " must be different of clone.width:" + clone.width ) ;
		assertFalse( d.height == clone.height, "DIM_09 - clone property failed, d.height:" + d.height + " must be different of clone.height:" + clone.height ) ;
	}
	
	public function testCopy():Void
	{
		var copy:Dimension = d.copy() ;
		copy.width = 10 ;
		copy.height = 20 ;
		assertTrue( copy instanceof Dimension , "DIM_10 - copy method failed, must return a Dimenstion reference." ) ;
		assertFalse( d.width == copy.width, "DIM_10 - copy property failed, d.width:" + d.width + " must be different of copy.width:" + copy.width ) ;
		assertFalse( d.height == copy.height, "DIM_10 - copy property failed, d.height:" + d.height + " must be different of copy.height:" + copy.height ) ;
	}

	public function testDecreaseSize():Void
	{
		var clone:Dimension = d.clone() ;
		clone.decreaseSize( new Dimension(50,50) ) ;
		assertEquals( clone.width, 50, "DIM_11_01 - decreaseSize method failed, width : " + clone.width ) ;
		assertEquals( clone.height, 150, "DIM_11_02 - decreaseSize method failed, height : " + clone.height ) ;
	}

	public function testEquals():Void
	{
		var e:Dimension = new Dimension(100, 200) ;
		assertTrue( d.equals(e) , "DIM_12 - equals method failed.") ;
	}

	public function testGetBounds():Void
	{
		var bounds:Rectangle = d.getBounds(10, 40) ;
		assertTrue( bounds instanceof Rectangle, "DIM_13_01 - getBounds method failed, the method must return a Rectangle reference.") ;	
		assertEquals( bounds.x, 10, "DIM_13_02 - getBounds method failed, x : " + bounds.x ) ;
		assertEquals( bounds.y, 40, "DIM_13_03 - getBounds method failed, y : " + bounds.y ) ;
		assertEquals( bounds.width, 100, "DIM_13_04 - getBounds method failed, width : " + bounds.width ) ;
		assertEquals( bounds.height, 200, "DIM_13_05 - getBounds method failed, height : " + bounds.height ) ;
	}
	
	public function testIncreaseSize():Void
	{
		var clone:Dimension = d.clone() ;
		clone.increaseSize( new Dimension(50,50) ) ;
		assertEquals( clone.width, 150, "DIM_14_01 - increaseSize method failed, width : " + clone.width ) ;
		assertEquals( clone.height, 250, "DIM_14_02 - increaseSize method failed, height : " + clone.height ) ;
	}
	
	public function testSetSize():Void
	{
		var clone:Dimension = d.clone() ;
		clone.setSize(250,250) ;
		assertEquals( clone.width, 250, "DIM_15_01 - setSize method failed, width : " + clone.width ) ;
		assertEquals( clone.height, 250, "DIM_15_02 - setSize method failed, height : " + clone.height ) ;
	}
	
}