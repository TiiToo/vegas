
package pegas.geom 
{
	import buRRRn.ASTUce.framework.TestCase;
	
	import vegas.core.CoreObject;		

	/**
	 * @author eKameleon
	 */
	public class TestMatrix4 extends TestCase 
	{

		public function TestMatrix4(name:String = "")
		{
			super( name );
		}
		
        public var m:Matrix4;
    
        public function setUp():void
        {
            m = new Matrix4() ;
        }
        
        public function tearDown():void
        {
            m = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( m, "MA4_00_01 - constructor is null") ;
            assertTrue( m is Matrix4 , "MA4_00_02 - constructor is an instance of Matrix4.") ;
        }
        
        public function testInherit():void
        {
            assertTrue( m is CoreObject , "MA4_01_01 - inherit CoreObject failed.") ;
            assertTrue( m is IGeometry  , "MA4_01_02 - implements IGeometry failed.") ;
        }   
        
        public function testHashCode():void
        {
            assertTrue( !isNaN(m.hashCode()) , "MA4_02 - hashCode failed : " + m.hashCode() ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( m.toSource() , "new pegas.geom.Matrix4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)", "MA4_03 - toSource failed : " + m.toSource() ) ;
        }
    
        public function testToString():void
        {
            assertEquals( m.toString() , "[Matrix4:[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]", "MA4_04 - toString failed : " + m.toString() ) ;
        }
        
        public function testClone():void
        {
            var clone:Matrix4 = m.clone() ;
            assertTrue( clone is Matrix4 , "MA4_05_01 - clone method failed, must return a Matrix4 reference." ) ;
        }
        
        public function testCopy():void
        {
            var copy:Matrix4 = m.copy() ;
            assertTrue( copy is Matrix4 , "MA4_06 - copy method failed, must return a Matrix4 reference." ) ;
        }
        
        public function testEquals():void
        {
            var ve:Matrix4 = new Matrix4() ;
            assertTrue( m.equals(ve) , "MA4_07 - equals method failed.") ;
        }
    
        public function testN11():void
        {
            assertEquals( m.n11, 1, "MA4_08 - n11 property failed : " + m.n11 ) ;
        }
    
        public function testN12():void
        {
            assertEquals( m.n12, 0, "MA4_09 - n12 property failed : " + m.n12 ) ;
        }
        
        public function testN13():void
        {
            assertEquals( m.n13, 0, "MA4_10 - n13 property failed : " + m.n13 ) ;
        }
    
        public function testN14():void
        {
            assertEquals( m.n14, 0, "MA4_11 - n14 property failed : " + m.n14 ) ;
        }
    
        public function testN21():void
        {
            assertEquals( m.n21, 0, "MA4_08 - n21 property failed : " + m.n21 ) ;
        }
    
        public function testN22():void
        {   
            assertEquals( m.n22, 1, "MA4_09 - n22 property failed : " + m.n22 ) ;
        }
        
        public function testN23():void
        {
            assertEquals( m.n23, 0, "MA4_10 - n23 property failed : " + m.n23 ) ;
        }   
    
        public function testN24():void
        {
            assertEquals( m.n24, 0, "MA4_11 - n24 property failed : " + m.n24 ) ;
        }
    
        public function testN31():void
        {   
            assertEquals( m.n31, 0, "MA4_12 - n31 property failed : " + m.n31 ) ;
        }

        public function testN32():void
        {
            assertEquals( m.n32, 0, "MA4_13 - n32 property failed : " + m.n32 ) ;
        }
        
        public function testN33():void
        {
            assertEquals( m.n33, 1, "MA4_14 - n33 property failed : " + m.n33 ) ;
        }
    
        public function testN34():void
        {
            assertEquals( m.n34, 0, "MA4_15 - n34 property failed : " + m.n34 ) ;
        }
    
        public function testN41():void
        {
            assertEquals( m.n41, 0, "MA4_12 - n41 property failed : " + m.n41 ) ;
        }
    
        public function testN42():void
        {   
            assertEquals( m.n42, 0, "MA4_13 - n42 property failed : " + m.n42 ) ;
        }
                
        public function testN43():void
        {
            assertEquals( m.n43, 0, "MA4_14 - n43 property failed : " + m.n43 ) ;
        }
    
        public function testN44():void
        {
            assertEquals( m.n44, 1, "MA4_15 - n44 property failed : " + m.n44 ) ;
        }        
            
    		
    }
 
}
