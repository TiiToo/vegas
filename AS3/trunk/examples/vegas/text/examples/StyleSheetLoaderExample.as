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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import vegas.strings.HTMLStringFormatter;
    import vegas.text.CoreTextField;
    import vegas.text.StyleSheetLoader;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.text.StyleSheet;
    import flash.text.TextFieldAutoSize;
    
    public class StyleSheetLoaderExample extends Sprite 
    {
        public function StyleSheetLoaderExample()
        {
            var style:StyleSheet = new StyleSheet() ;
            
            var loader:StyleSheetLoader = new StyleSheetLoader( style ) ;
            loader.addEventListener( Event.COMPLETE , complete ) ;
            
            var field:CoreTextField = new CoreTextField( null , 150 , 20 ) ;
            field.autoSize          = TextFieldAutoSize.LEFT ;
            field.styleSheet        = style ;
            field.x                 = 25 ;
            field.y                 = 25 ;
            field.htmlText          = HTMLStringFormatter.paragraph("hello world" , "my_style" ) ; 
            
            addChild(field) ;
            
            loader.load( new URLRequest( "style/style.css" ) ) ;
        }
        
        public function complete( e:Event ):void
        {
            trace( e ) ;
        }
    }
}
