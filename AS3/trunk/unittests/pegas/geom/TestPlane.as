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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.geom 
{
	import buRRRn.ASTUce.framework.TestCase;
	
	import vegas.core.CoreObject;	

	/**
	 * @author eKameleon
	 */
	public class TestPlane extends TestCase 
	{

		public function TestPlane(name:String = "")
		{
			super( name );
		}
		
        public var p:Plane;
        
        public function setUp():void
        {
            p = new Plane(10, 20, 30, 40) ;
        }
        
        public function tearDown():void
        {
            p = null ;
        }    
        
        public function testConstructor():void
        {   
            assertNotNull( p, "PLANE_00_01 - constructor is null") ;
            assertTrue( p is Plane, "PLANE_00_02 - constructor is an instance of Plane.") ;
        }
        
        public function testInherit():void
        {
            assertTrue( p is CoreObject , "PLANE_01_01 - inherit CoreObject failed.") ;
            assertTrue( p is IGeometry  , "PLANE_01_01 - implements IGeometry failed.") ;
        }   
        
        public function testHashCode():void
        {
            assertTrue( !isNaN(p.hashCode()) , "PLANE_02 - hashCode failed : " + p.hashCode() ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( p.toSource() , "new pegas.geom.Plane(10,20,30,40)", "PLANE_03 - toSource failed : " + p.toSource() ) ;
        }
    
        public function testToString():void
        {
            assertEquals( p.toString() , "[Plane:{10,20,30,40}]", "PLANE_04 - toString failed : " + p.toString() ) ;
        }
    
        public function testA():void
        {
            assertEquals( p.a , 10, "PLANE_05 - a property failed : " + p.a ) ;
        }
    
        public function testB():void
        {
            assertEquals( p.b , 20, "PLANE_06 - b property failed : " + p.b ) ;
        }
        
        public function testC():void
        {
            assertEquals( p.c , 30, "PLANE_07 - c property failed : " + p.c ) ;
        }
        
        public function testD():void
        {
            assertEquals( p.d , 40, "PLANE_08 - d property failed : " + p.d ) ;
        }   
    
        public function testClone():void
        {
            var clone:Plane = p.clone() ;
            clone.a = 100 ;
            clone.b = 200 ;
            clone.c = 300 ;
            clone.d = 400 ;
            assertTrue( clone is Plane , "PLANE_09 - clone method failed, must return a Plane reference." ) ;
            assertFalse( p.a == clone.a, "PLANE_09 - clone property failed, p.a:" + p.a + " must be different of clone.a:" + clone.a ) ;
            assertFalse( p.b == clone.b, "PLANE_09 - clone property failed, p.b:" + p.b + " must be different of clone.b:" + clone.b ) ;
            assertFalse( p.c == clone.c, "PLANE_09 - clone property failed, p.c:" + p.c + " must be different of clone.c:" + clone.c ) ;
            assertFalse( p.d == clone.d, "PLANE_09 - clone property failed, p.d:" + p.d + " must be different of clone.d:" + clone.d ) ;
        }
        
        public function testCopy():void
        {
            var copy:Plane = p.copy() ;
            copy.a = 100 ;
            copy.b = 200 ;
            copy.c = 300 ;
            copy.d = 400 ;
            assertTrue( copy is Plane , "PLANE_10 - copy method failed, must return a Plane reference." ) ;
            assertFalse( p.a == copy.a, "PLANE_10 - copy property failed, p.a:" + p.a + " must be different of copy.a:" + copy.a ) ;
            assertFalse( p.b == copy.b, "PLANE_10 - copy property failed, p.b:" + p.b + " must be different of copy.b:" + copy.b ) ;
            assertFalse( p.c == copy.c, "PLANE_10 - copy property failed, p.c:" + p.c + " must be different of copy.c:" + copy.c ) ;
            assertFalse( p.d == copy.d, "PLANE_10 - copy property failed, p.d:" + p.d + " must be different of copy.d:" + copy.d ) ;
        }
        
        public function testEquals():void
        {   
            var pe:Plane = new Plane(10, 20, 30, 40) ;
            assertTrue( p.equals(pe) , "PLANE_11 - equals method failed.") ;
        }
    
    }

}
    