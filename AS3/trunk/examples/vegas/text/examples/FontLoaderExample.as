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

package examples 
{
    import vegas.events.FontEvent;
    import vegas.text.CoreTextField;
    import vegas.text.FontLoader;

    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.text.Font;
    import flash.text.TextFormat;

    public class FontLoaderExample extends MovieClip 
    {
        public function FontLoaderExample()
        {
            field1            = new CoreTextField( null , 150 , 20 ) ;
            field1.border     = true ;
            field1.embedFonts = true ;  
            field1.x          = 25 ;
            field1.y          = 25 ;
            
            field2            = new CoreTextField( null , 150 , 20 ) ;
            field2.border     = true ;
            field2.embedFonts = true ;
            field2.x          = 25 ;
            field2.y          = 50 ;
            
            addChild(field1) ;
            addChild(field2) ;
            
            var request:URLRequest = new URLRequest( "fonts/fonts.swf" ) ;
            
            var loader:FontLoader = new FontLoader() ;
            
            loader.context = new LoaderContext( false , ApplicationDomain.currentDomain ) ;
            
            loader.contentLoaderInfo.addEventListener( Event.COMPLETE , complete ) ;
            
            loader.addEventListener( FontEvent.ADD_FONT , addFont ) ;
            
            // Register the full class name of the fonts in the external library
            
            loader.registerFontClassName( "ArialBlack" ) ; 
            loader.registerFontClassName( "MyriadPro" ) ;
            
            // you can use the autoRegister flag, the loader find the Font class in the external library for you
            
            // loader.autoRegister = true ;
            
            loader.load( request  ) ;
        }
        
        public var field1:CoreTextField ;
        
        public var field2:CoreTextField ;
        
        public function addFont( e:FontEvent ):void
        {
            trace( e.type + " font:" + e.font ) ;
        }
        
        public function complete( e:Event ):void
        {
            trace( "fonts : " + Font.enumerateFonts() ) ;   
            
            field1.defaultTextFormat = new TextFormat("Arial Black", 13 , 0xFFFFFF ) ;  
            field1.text = "hello world" ;   
            
            field2.defaultTextFormat = new TextFormat("Myriad Pro", 13 , 0xF7EEA2 ) ;   
            field2.text = "hello world" ;
        }
    }
}
