﻿/*
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
    
    public class LocalizationExample extends Sprite 
    {
        public function LocalizationExample()
        {
            localization  = Localization.getInstance() ;
            localization.addEventListener( LocalizationEvent.CHANGE , change ) ;
            
            var loader:EdenLocalizationLoader = localization.loader as EdenLocalizationLoader ;
            
            loader.addEventListener( ActionEvent.START , debug ) ;
            loader.addEventListener( ActionEvent.FINISH , debug ) ;
            
            loader.path = "locale/" ;
            
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