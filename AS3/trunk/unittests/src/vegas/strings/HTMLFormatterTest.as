/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package vegas.strings 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    public class HTMLFormatterTest extends TestCase 
    {
        public function HTMLFormatterTest(name:String = "")
        {
            super(name);
        }
        
        public function testAnchor():void
        {
            assertEquals( '<a name="my_name">hello world</a>' , HTMLFormatter.anchor("hello world", "my_name" ) ) ;
        }
        
        public function testBig():void
        {
            assertEquals( '<big>hello world</big>' , HTMLFormatter.big("hello world") ) ;
        }
        
        public function testBlink():void
        {
            assertEquals( '<blink>hello world</blink>' , HTMLFormatter.blink("hello world") ) ;
        }
        
        public function testBold():void
        {
            assertEquals( '<b>hello world</b>' , HTMLFormatter.bold("hello world") ) ;
        }
        
        public function testFixed():void
        {
            assertEquals( '<tt>hello world</tt>' , HTMLFormatter.fixed("hello world") ) ;
        }
        
        public function testFontColor():void
        {
            assertEquals( '<font color="#000099">hello world</font>' , HTMLFormatter.fontColor("hello world" , "#000099" ) ) ;
        }
        
        public function testFontSize():void
        {
            assertEquals( '<font size="12">hello world</font>' , HTMLFormatter.fontSize("hello world" , 12 ) ) ;
            assertEquals( '<font size="+1">hello world</font>' , HTMLFormatter.fontSize("hello world" , "+1" ) ) ;
        }
        
        public function testItalics():void
        {
            assertEquals( '<i>hello world</i>' , HTMLFormatter.italics("hello world") ) ;
        }
        
        public function testParagraph():void
        {
            assertEquals( '<p>hello world</p>' , HTMLFormatter.paragraph("hello world") ) ;
            assertEquals( '<p class="my_class">hello world</p>' , HTMLFormatter.paragraph("hello world","my_class") ) ;
        }
        
        public function testSmall():void
        {
            assertEquals( '<small>hello world</small>' , HTMLFormatter.small("hello world") ) ;
        }
        
        public function testSpan():void
        {
            assertEquals( '<span>hello world</span>' , HTMLFormatter.span("hello world") ) ;
            assertEquals( '<span class="my_class">hello world</span>' , HTMLFormatter.span("hello world","my_class") ) ;
        }
        
        public function testSub():void
        {
            assertEquals( '<sub>hello world</sub>' , HTMLFormatter.sub("hello world") ) ;
        }
        
        public function testSup():void
        {
            assertEquals( '<sup>hello world</sup>' , HTMLFormatter.sup("hello world") ) ;
        }
        
        public function testUnderline():void
        {
            assertEquals( '<u>hello world</u>' , HTMLFormatter.underline("hello world") ) ;
        }
    }
}
