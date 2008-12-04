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
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :

  Nicolas Surian <nicolas.surian@gmail.com>
    
*/

package pegas.colors 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import flash.display.MovieClip;        

    /**
     * The Test class fo the pegas.colors.Color class.
     */
    public class ColorTest extends TestCase 
    {
        
        public function ColorTest(name:String = "")
        {
            super( name );
        }
                
        public function testGetRGB():void
        {
        	var color:Color   = new Color( new MovieClip() ) ;
        	var number:Number = color.getRGB() ;
        	
        	// Test the black color.
        	assertNotNull( number , "01 - 01 testGetRGB() failed" ) ;
            assertEquals ( number , "0" , "01 - 02 testGetRGB() failed" ) ;
        	
        	color.rgb = 0xFF0000 ;
        	number    = color.getRGB() ;

            // Test the red color.
            assertNotNull( number , "02 - 01 testGetRGB() failed" ) ;
            assertEquals ( number , "16711680" , "02 - 02 testGetRGB() failed" ) ;
        }
        
        public function testGetRGBStr():void
        {
            var color:Color   = new Color( new MovieClip() ) ;
            var str:String    = Color.getRGBStr( color ) ;
            
            // Test the black color.
            assertNotNull( str , "01 - 01 testGetRGBStr() failed" ) ;
            assertEquals ( str , "000000" , "01 - 02 testGetRGBStr() failed" ) ;
            
            color.rgb = 0xFF0000 ;
            str       = Color.getRGBStr( color ) ;

            // Test the red color.
            assertNotNull( str , "02 - 01 testGetRGBStr() failed" ) ;
            assertEquals ( str , "FF0000" , "02 - 02 testGetRGBStr() failed" ) ;
        	
        }
        
        public function testGetTransform():void
        {
            var color:Color   = new Color( new MovieClip() ) ;
            var o:Object      = color.getTransform() ;
            var o1:Object     = { ra : 100 , rb : 0   , ga : 100 , gb : 0   , ba : 100 , bb : 0   , aa : 100 , ab : 0 } ;
            var o2:Object     = { ra : 0   , rb : 255 , ga : 0   , gb : 0   , ba : 0   , bb : 0   , aa : 100 , ab : 0 } ;
            var o3:Object     = { ra : 0   , rb : 0   , ga : 0   , gb : 255 , ba : 0   , bb : 0   , aa : 100 , ab : 0 } ;
            var o4:Object     = { ra : 0   , rb : 0   , ga : 0   , gb : 0   , ba : 0   , bb : 255 , aa : 100 , ab : 0 } ;
            var o5:Object     = { ra : 0   , rb : 255 , ga : 0   , gb : 255 , ba : 0   , bb : 255 , aa : 100 , ab : 0 } ;
            
            assertNotNull( o , "01 - 01 testGetTransform() failed" ) ;

            // Test color black.            
            assertEquals( o.ra , o1.ra , "02 - 01 testGetTransform() failed " ) ;
            assertEquals( o.rb , o1.rb , "02 - 02 testGetTransform() failed " ) ;
            assertEquals( o.ga , o1.ga , "02 - 03 testGetTransform() failed " ) ;
            assertEquals( o.gb , o1.gb , "02 - 04 testGetTransform() failed " ) ;
            assertEquals( o.ba , o1.ba , "02 - 05 testGetTransform() failed " ) ;
            assertEquals( o.bb , o1.bb , "02 - 06 testGetTransform() failed " ) ;
            assertEquals( o.aa , o1.aa , "02 - 07 testGetTransform() failed " ) ;
            assertEquals( o.ab , o1.ab , "02 - 08 testGetTransform() failed " ) ;
            
            color.rgb = 0xFF0000 ;
            o         = color.getTransform() ;
            
            // Test color red.
            assertEquals( o.ra , o2.ra , "03 - 01 testGetTransform() failed " ) ;
            assertEquals( o.rb , o2.rb , "03 - 02 testGetTransform() failed " ) ;
            assertEquals( o.ga , o2.ga , "03 - 03 testGetTransform() failed " ) ;
            assertEquals( o.gb , o2.gb , "03 - 04 testGetTransform() failed " ) ;
            assertEquals( o.ba , o2.ba , "03 - 05 testGetTransform() failed " ) ;
            assertEquals( o.bb , o2.bb , "03 - 06 testGetTransform() failed " ) ;
            assertEquals( o.aa , o2.aa , "03 - 07 testGetTransform() failed " ) ;
            assertEquals( o.ab , o2.ab , "03 - 08 testGetTransform() failed " ) ;

            color.rgb = 0x00FF00 ;
            o         = color.getTransform() ;
            
            // Test color green.
            assertEquals( o.ra , o3.ra , "04 - 01 testGetTransform() failed " ) ;
            assertEquals( o.rb , o3.rb , "04 - 02 testGetTransform() failed " ) ;
            assertEquals( o.ga , o3.ga , "04 - 03 testGetTransform() failed " ) ;
            assertEquals( o.gb , o3.gb , "04 - 04 testGetTransform() failed " ) ;
            assertEquals( o.ba , o3.ba , "04 - 05 testGetTransform() failed " ) ;
            assertEquals( o.bb , o3.bb , "04 - 06 testGetTransform() failed " ) ;
            assertEquals( o.aa , o3.aa , "04 - 07 testGetTransform() failed " ) ;
            assertEquals( o.ab , o3.ab , "04 - 08 testGetTransform() failed " ) ;
            
            color.rgb = 0x0000FF ;
            o         = color.getTransform() ;
            
            // Test color blue.
            assertEquals( o.ra , o4.ra , "05 - 01 testGetTransform() failed " ) ;
            assertEquals( o.rb , o4.rb , "05 - 02 testGetTransform() failed " ) ;
            assertEquals( o.ga , o4.ga , "05 - 03 testGetTransform() failed " ) ;
            assertEquals( o.gb , o4.gb , "05 - 04 testGetTransform() failed " ) ;
            assertEquals( o.ba , o4.ba , "05 - 05 testGetTransform() failed " ) ;
            assertEquals( o.bb , o4.bb , "05 - 06 testGetTransform() failed " ) ;
            assertEquals( o.aa , o4.aa , "05 - 07 testGetTransform() failed " ) ;
            assertEquals( o.ab , o4.ab , "05 - 08 testGetTransform() failed " ) ;
            
            color.rgb = 0xFFFFFF ;
            o         = color.getTransform() ;
            
            // Test color white.
            assertEquals( o.ra , o5.ra , "06 - 01 testGetTransform() failed " ) ;
            assertEquals( o.rb , o5.rb , "06 - 02 testGetTransform() failed " ) ;
            assertEquals( o.ga , o5.ga , "06 - 03 testGetTransform() failed " ) ;
            assertEquals( o.gb , o5.gb , "06 - 04 testGetTransform() failed " ) ;
            assertEquals( o.ba , o5.ba , "06 - 05 testGetTransform() failed " ) ;
            assertEquals( o.bb , o5.bb , "06 - 06 testGetTransform() failed " ) ;
            assertEquals( o.aa , o5.aa , "06 - 07 testGetTransform() failed " ) ;
            assertEquals( o.ab , o5.ab , "06 - 08 testGetTransform() failed " ) ;
        }
    }
}