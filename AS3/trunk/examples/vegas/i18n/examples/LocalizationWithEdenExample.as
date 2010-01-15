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
    import system.eden;
    import system.events.ActionEvent;
    
    import vegas.events.LocalizationEvent;
    import vegas.i18n.EdenLocalizationLoader;
    import vegas.i18n.Lang;
    import vegas.i18n.Locale;
    import vegas.i18n.Localization;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class LocalizationWithEdenExample extends Sprite 
    {
        public function LocalizationWithEdenExample()
        {
            localization  = Localization.getInstance() ;
            localization.addEventListener( LocalizationEvent.CHANGE , change ) ;
            
            var loader:EdenLocalizationLoader = localization.loader as EdenLocalizationLoader ;
            
            loader.addEventListener( ActionEvent.START , debug ) ;
            loader.addEventListener( ActionEvent.FINISH , debug ) ;
            
            loader.path = "locale/" ;
            loader.prefix = "" ;
            loader.suffix = "/localize.eden" ;
            
            trace( loader.prefix ) ;
            
            localization.current = Lang.FR ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var localization:Localization ;
        
        public function debug( e:Event ):void
        {
            trace("------- " + e.type ) ;
        }
        
        public function change( e:LocalizationEvent ):void
        {
            var current:Lang        = e.current ;
            var locale:Locale       = e.getLocale() ;
            
            trace("# change current " + current ) ;
            trace("# change locale  " + locale  ) ;
            
            trace( eden.serialize( locale ) ) ;
            
            trace( "--------" ) ;
            
            trace( "e.getLocale() : " + e.getLocale() ) ;
            trace( "e.getLocale( 'info' ) : " + e.getLocale( "info" ) ) ;
            trace( "e.getLocale( 'info.finish_loading' ) : " + e.getLocale( "info.finish_loading" ) ) ;
            
            trace( "e.getLocale() : " + e.getLocale("unknow") ) ;
            
            localization.throwError = true ;
            
            try
            {
                e.getLocale("unknow") ;
            }
            catch( e:Error )
            {
                trace( e.toString() ) ;
            }
            
            localization.throwError = false ;
            
            trace( "-------- map a dynamic object with the locale properties" ) ;
            
            var init:Object = {} ;
            
            localization.init( init ) ;
            
            trace( "init : " + eden.serialize( init ) ) ;
        }
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    localization.current = Lang.EN ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    localization.current = "fr" ;
                    break ;
                }
            }
        }
    }
}
