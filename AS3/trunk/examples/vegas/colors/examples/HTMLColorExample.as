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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com>  

*/

package examples 
{
    import vegas.colors.HTMLColor;
    
    import flash.display.Sprite;
    
    public class HTMLColorExample extends Sprite 
    {
        public function HTMLColorExample()
        {
            var n:Number = HTMLColor.htmlToNumber( "#FF0000" ) ;
            trace("convert #FF0000 : "  + n) ; // convert #FF0000 : 16711680
            
            var c:HTMLColor = HTMLColor.YELLOW ;
            trace("c.toString() : " + c.toString() ) ; // c.toString() : Yellow
            
            trace("c.valueOf() : " + c.valueOf() ) ; // c.valueOf() : 16776960
            
            var htmlCode:String = HTMLColor.hexToHtml( 0xFF0000 ) ;
            trace("convert 0xFF0000 : "  + htmlCode) ; // convert 0xFF0000 : #FF0000
        }
    }
}
