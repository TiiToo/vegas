/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.colors 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import graphics.colors.RGB;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    
    public class ColorTest extends TestCase 
    {
        public function ColorTest(name:String = "")
        {
            super( name );
        }
        
        public var display:DisplayObject ;
        
        public var color:Color ;
        
        public function setUp():void
        {
            display = new Sprite() ;
            color   = new Color( display ) ;
        }
        
        public function tearDown():void
        {
            color   = undefined ;
            display = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( color                   , "01-01 Color constructor failed" ) ;
            assertEquals ( color.display , display , "01-02 Color constructor failed" ) ;
            
            try
            {
               new Color(null) ;
               fail( "02-01 Color constructor failed with a null argument" ) ;  
            }
            catch( e:Error )
            {
                 assertTrue( e is ArgumentError , "02-02 Color constructor failed with a null argument" ) ;                 
                 assertEquals( e.message , "[object Color] constructor failed, the passed-in DisplayObject must not be null or undefined." , "02-03 Color constructor failed with a null argument" ) ;
            }
        }
        
        public function testColorTransform():void
        {
            assertTrue( color.colorTransform is ColorTransform , "01 Color.colorTransform is not a ColorTransform" ) ;
       }
        
        public function testDisplay():void
        {
            assertTrue( color.display is DisplayObject , "01 Color.display is not a DisplayObject" ) ;
        }        
        
        public function testEVALUATOR():void
        {
            assertNotNull( Color.EVALUATOR                   , "01 - The evaluator reference must not be null."       ) ;
            assertTrue   ( Color.EVALUATOR is ColorEvaluator , "02 - The evaluator reference must be ColorEvaluator." ) ;
        }
        
        public function testRGB():void
        {
            // Test the black color.
            assertEquals ( color.rgb , 0 , "01 - getRGB() failed" ) ;
            
            color.rgb = 0xFF0000 ;
            
            // Test the red color.
            assertEquals ( color.rgb , 16711680 , "02 - getRGB() failed" ) ;
            
            color.reset() ;
            
            assertEquals ( color.rgb , 0 , "03 - getRGB() failed" ) ;
        }
          
        public function testGetRGB():void
        {
            // Test the default color.
            assertEquals ( color.getRGB() , 0 , "01 - getRGB() failed" ) ;
            
            // Test the red color.
            color.setRGB( 0xFF0000 ) ;
            assertEquals ( color.getRGB() , 16711680 , "02 - getRGB() failed" ) ;
            
            // test reset
            color.reset() ;
            assertEquals ( color.getRGB() , 0 , "03 - getRGB() failed" ) ;
        }
        
        public function testGetTransform():void
        {
            var o:Object ;
            
            var o1:Object = { ra : 100 , rb : 0   , ga : 100 , gb : 0   , ba : 100 , bb : 0   , aa : 100 , ab : 0 } ;
            var o2:Object = { ra : 0   , rb : 255 , ga : 0   , gb : 0   , ba : 0   , bb : 0   , aa : 100 , ab : 0 } ;
            var o3:Object = { ra : 0   , rb : 0   , ga : 0   , gb : 255 , ba : 0   , bb : 0   , aa : 100 , ab : 0 } ;
            var o4:Object = { ra : 0   , rb : 0   , ga : 0   , gb : 0   , ba : 0   , bb : 255 , aa : 100 , ab : 0 } ;
            var o5:Object = { ra : 0   , rb : 255 , ga : 0   , gb : 255 , ba : 0   , bb : 255 , aa : 100 , ab : 0 } ;
            
            // Test color black (default)
            
            o = color.getTransform() ; 
            
            assertNotNull( o , "01-01 getTransform() failed" ) ;
                
            assertEquals( o.ra , o1.ra , "02-01 getTransform() failed " ) ;
            assertEquals( o.rb , o1.rb , "02-02 getTransform() failed " ) ;
            assertEquals( o.ga , o1.ga , "02-03 getTransform() failed " ) ;
            assertEquals( o.gb , o1.gb , "02-04 getTransform() failed " ) ;
            assertEquals( o.ba , o1.ba , "02-05 getTransform() failed " ) ;
            assertEquals( o.bb , o1.bb , "02-06 getTransform() failed " ) ;
            assertEquals( o.aa , o1.aa , "02-07 getTransform() failed " ) ;
            assertEquals( o.ab , o1.ab , "02-08 getTransform() failed " ) ;
            
            color.rgb = 0xFF0000 ;
            o         = color.getTransform() ;
            
            // Test color red.
            assertEquals( o.ra , o2.ra , "03-01 getTransform() failed." ) ;
            assertEquals( o.rb , o2.rb , "03-02 getTransform() failed." ) ;
            assertEquals( o.ga , o2.ga , "03-03 getTransform() failed." ) ;
            assertEquals( o.gb , o2.gb , "03-04 getTransform() failed." ) ;
            assertEquals( o.ba , o2.ba , "03-05 getTransform() failed." ) ;
            assertEquals( o.bb , o2.bb , "03-06 getTransform() failed." ) ;
            assertEquals( o.aa , o2.aa , "03-07 getTransform() failed." ) ;
            assertEquals( o.ab , o2.ab , "03-08 getTransform() failed." ) ;
            
            // Test color green.
            
            color.rgb = 0x00FF00 ;
            o         = color.getTransform() ;
            
            assertEquals( o.ra , o3.ra , "04-01 getTransform() failed." ) ;
            assertEquals( o.rb , o3.rb , "04-02 getTransform() failed." ) ;
            assertEquals( o.ga , o3.ga , "04-03 getTransform() failed." ) ;
            assertEquals( o.gb , o3.gb , "04-04 getTransform() failed." ) ;
            assertEquals( o.ba , o3.ba , "04-05 getTransform() failed." ) ;
            assertEquals( o.bb , o3.bb , "04-06 getTransform() failed." ) ;
            assertEquals( o.aa , o3.aa , "04-07 getTransform() failed." ) ;
            assertEquals( o.ab , o3.ab , "04-08 getTransform() failed." ) ;
            
            // Test color blue.
            
            color.rgb = 0x0000FF ;
            o         = color.getTransform() ;
            
            assertEquals( o.ra , o4.ra , "05-01 getTransform() failed." ) ;
            assertEquals( o.rb , o4.rb , "05-02 getTransform() failed." ) ;
            assertEquals( o.ga , o4.ga , "05-03 getTransform() failed." ) ;
            assertEquals( o.gb , o4.gb , "05-04 getTransform() failed." ) ;
            assertEquals( o.ba , o4.ba , "05-05 getTransform() failed." ) ;
            assertEquals( o.bb , o4.bb , "05-06 getTransform() failed." ) ;
            assertEquals( o.aa , o4.aa , "05-07 getTransform() failed." ) ;
            assertEquals( o.ab , o4.ab , "05-08 getTransform() failed." ) ;
            
            // Test color white.
                        
            color.rgb = 0xFFFFFF ;
            o         = color.getTransform() ;
            
            assertEquals( o.ra , o5.ra , "06-01 getTransform() failed." ) ;
            assertEquals( o.rb , o5.rb , "06-02 getTransform() failed." ) ;
            assertEquals( o.ga , o5.ga , "06-03 getTransform() failed." ) ;
            assertEquals( o.gb , o5.gb , "06-04 getTransform() failed." ) ;
            assertEquals( o.ba , o5.ba , "06-05 getTransform() failed." ) ;
            assertEquals( o.bb , o5.bb , "06-06 getTransform() failed." ) ;
            assertEquals( o.aa , o5.aa , "06-07 getTransform() failed." ) ;
            assertEquals( o.ab , o5.ab , "06-08 getTransform() failed." ) ;
            
            color.reset() ;
        }
        
        public function testInvert():void
        {
            color.invert() ;
            
            assertEquals( color.rgb , 0xFFFFFF , "01 - The invert color must be white." ) ;
            
            color.invert() ;
            
            assertEquals( color.rgb , 0 , "01 - The invert color must be black." ) ;
            
            color.reset() ;
        }  
        
        public function testSetRGB():void
        {
            color.setRGB( 0xFF0000 ) ;
            
            // Test the red color.
            assertEquals ( color.getRGB() , 0xFF0000 , "01 - setRGB() failed" ) ;
            
            color.reset() ;
            
            assertEquals ( color.getRGB() , 0 , "02 - setRGB() failed" ) ;
            
        }
        
        public function testSetRGBWithStringArgument():void
        {
            color.setRGB( "0xFF0000" ) ;
            
            // Test the red color.
            assertEquals ( color.rgb, 0xFF0000 , "01 - setRGB() failed" ) ;
            
            color.reset() ;
        }
        
        public function testSetRGBWithStringArgumentNoValidPattern():void
        {
            color.setRGB( "oxFF0000" ) ;
            
            assertEquals ( color.rgb , 0 , "01 - setRGB failed." ) ;
            
            color.reset() ;
            
            color.setRGB( "#FF000Z" ) ;
            assertEquals ( color.rgb , 0 , "02 - setRGB failed" ) ;
            
            color.reset() ;
            color.setRGB( "#FF00000" ) ;
            assertEquals ( color.rgb , 0 , "03 - setRGB failed" ) ;
            
            color.reset() ;
        }
        
        public function testSetRGBWithRGBArgument():void
        {
            var rgb:RGB = new RGB(255,0,0) ;
            
            color.setRGB( rgb ) ;
            
            // Test the red color.
            assertEquals ( color.rgb, 0xFF0000 , "setRGB() failed with RGB parameter" ) ;
            
            color.reset() ;
        }
        
        public function testSetTransform():void
        {
            var o:Object = {} ;
            var o1:Object = { ra : 100 , rb : 255 , ga : 0 , gb : 0 , ba : 100 , bb : 0 , aa : 100 , ab : 0 } ;
            var o2:Object = {} ;
            
            color.setTransform( o1 ) ;
            o = color.getTransform() ;
                    
            assertTrue( color.colorTransform is ColorTransform , "01-01 - Color.setTransform is not a ColorTransform" ) ;
            assertEquals( o.ra , o1.ra , "01-02 setTransform() failed" ) ;
            assertEquals( o.rb , o1.rb , "01-03 setTransform() failed" ) ;
            assertEquals( o.ga , o1.ga , "01-04 setTransform() failed" ) ;
            assertEquals( o.gb , o1.gb , "01-05 setTransform() failed" ) ;
            assertEquals( o.ba , o1.ba , "01-06 setTransform() failed" ) ;
            assertEquals( o.bb , o1.bb , "01-07 setTransform() failed" ) ;
            assertEquals( o.aa , o1.aa , "01-08 setTransform() failed" ) ;
            assertEquals( o.ab , o1.ab , "01-09 setTransform() failed" ) ;
            
            color.setTransform( o2 ) ;
            o = color.getTransform() ;
            
            assertEquals( o.ra , 100 , "02-01 setTransform() failed" ) ;
            assertEquals( o.rb , 0   , "02-02 setTransform() failed" ) ;
            assertEquals( o.ga , 100 , "02-03 setTransform() failed" ) ;
            assertEquals( o.gb , 0   , "02-04 setTransform() failed" ) ;
            assertEquals( o.ba , 100 , "02-05 setTransform() failed" ) ;
            assertEquals( o.bb , 0   , "02-06 setTransform() failed" ) ;
            assertEquals( o.aa , 100 , "02-07 setTransform() failed" ) ;
            assertEquals( o.ab , 0   , "02-08 setTransform() failed" ) ;
            
            color.setTransform( null ) ;
            o = color.getTransform() ;
            
            assertEquals( o.ra , 100 , "03-01 setTransform() failed" ) ;
            assertEquals( o.rb , 0   , "03-02 setTransform() failed" ) ;
            assertEquals( o.ga , 100 , "03-03 setTransform() failed" ) ;
            assertEquals( o.gb , 0   , "03-04 setTransform() failed" ) ;
            assertEquals( o.ba , 100 , "03-05 setTransform() failed" ) ;
            assertEquals( o.bb , 0   , "03-06 setTransform() failed" ) ;
            assertEquals( o.aa , 100 , "03-07 setTransform() failed" ) ;
            assertEquals( o.ab , 0   , "03-08 setTransform() failed" ) ;
            
            color.setTransform( undefined ) ;
            o = color.getTransform() ;
            
            assertEquals( o.ra , 100 , "04-01 setTransform() failed" ) ;
            assertEquals( o.rb , 0   , "04-02 setTransform() failed" ) ;
            assertEquals( o.ga , 100 , "04-03 setTransform() failed" ) ;
            assertEquals( o.gb , 0   , "04-04 setTransform() failed" ) ;
            assertEquals( o.ba , 100 , "04-05 setTransform() failed" ) ;
            assertEquals( o.bb , 0   , "04-06 setTransform() failed" ) ;
            assertEquals( o.aa , 100 , "04-07 setTransform() failed" ) ;
            assertEquals( o.ab , 0   , "04-08 setTransform() failed" ) ;
            
            color.reset() ;
        }  
        
        public function testToRGBString():void
        {
            var s:String = color.toRGBString() ;
            
            // Test the black color.
            assertEquals ( s , "000000" , "01 - toRGBString() failed" ) ;
            
            color.rgb = 0xFF0000 ;
            
            // Test the red color.
            assertEquals ( color.toRGBString() , "FF0000" , "02 - toRGBString() failed" ) ;
            
            color.reset() ;
            
            // Test the black color.
            assertEquals ( color.toRGBString() , "000000" , "03 - toRGBString() failed" ) ;
        }
    }
}