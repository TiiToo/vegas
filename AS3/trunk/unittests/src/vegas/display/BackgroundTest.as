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
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.display 
{
    import buRRRn.ASTUce.framework.TestCase;

    import graphics.Align;
    import graphics.Directionable;
    import graphics.Drawable;

    public class BackgroundTest extends TestCase 
    {
        public function BackgroundTest(name:String = "")
        {
            super(name);
        }
        
        public var background:Background ;
        
        public function setUp():void
        {
            background = new Background() ;
        }
        
        public function tearDown():void
        {
            background = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( background ) ;
            assertNull( background.id ) ; 
            assertFalse( background.isFull ) ;
        }
        
        public function testConstructorWithParameters():void
        {
            background = new Background( "background" , true , "my_background" ) ;
            assertNotNull( background ) ;
            assertEquals( background.name  , "my_background" ) ;
            assertTrue( background.isFull ) ;
        }
        
        public function testInherit():void
        {
             assertTrue( background is CoreSprite ) ;
        }
        
        public function testInterface():void
        {
             assertTrue( background is Directionable ) ;
             assertTrue( background is Drawable ) ;
        }
        
        public function testAlign():void
        {
            assertEquals( Align.TOP_LEFT , background.align ) ; 
            background.align = Align.BOTTOM ;
            assertEquals( Align.BOTTOM , background.align ) ;
        }
        
        public function testAutoSize():void
        {
            assertFalse( background.autoSize ) ;             background.autoSize = true ;
            assertTrue( background.autoSize ) ;
            background.autoSize = false ; 
            assertFalse( background.autoSize ) ; 
        }
        
        public function testSetCornerRadius():void
        {
            background.setCornerRadius( -10 ) ;
            assertEquals( 0 , background.bottomLeftRadius ) ;
            assertEquals( 0 , background.bottomRightRadius ) ;
            assertEquals( 0 , background.topLeftRadius ) ;
            assertEquals( 0 , background.topRightRadius ) ;
            background.setCornerRadius( 0 ) ;
            assertEquals( 0 , background.bottomLeftRadius ) ;
            assertEquals( 0 , background.bottomRightRadius ) ;
            assertEquals( 0 , background.topLeftRadius ) ;
            assertEquals( 0 , background.topRightRadius ) ;
            background.setCornerRadius( 20 ) ;
            assertEquals( 20 , background.bottomLeftRadius ) ;
            assertEquals( 20 , background.bottomRightRadius ) ;
            assertEquals( 20 , background.topLeftRadius ) ;
            assertEquals( 20 , background.topRightRadius ) ;
            background.setCornerRadius( 10 ) ;
            assertEquals( 10 , background.bottomLeftRadius ) ;            assertEquals( 10 , background.bottomRightRadius ) ;            assertEquals( 10 , background.topLeftRadius ) ;            assertEquals( 10 , background.topRightRadius ) ;
            background.setCornerRadius( 20 ) ;
            assertEquals( 20 , background.bottomLeftRadius ) ;
            assertEquals( 20 , background.bottomRightRadius ) ;
            assertEquals( 20 , background.topLeftRadius ) ;
            assertEquals( 20 , background.topRightRadius ) ;
        }
    }
}
