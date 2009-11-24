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
    import vegas.events.LocalizationEvent;
    import vegas.i18n.Lang;
    import vegas.i18n.Localization;
    import vegas.ioc.net.ECMAObjectLoader;
    
    import flash.display.MovieClip;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.text.TextField;
    import flash.ui.Keyboard;
    
    [SWF(width="740", height="400", frameRate="24", backgroundColor="#660000")]
    
    /**
     * The "i18n" resource example.
     */
    public class ECMAObjectLoader10Example extends MovieClip 
    {
        public function ECMAObjectLoader10Example()
        {
            //////////
            
            var loader:ECMAObjectLoader = new ECMAObjectLoader( "application_i18n_resource.eden" , "context/" ) ;
            
            loader.root = this ;
            
            loader.run() ;
            
            //////////
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        /**
         * The field reference of the application.
         */
        public var field:TextField ;
        
        /**
         * The Localization reference of the application to change the current lang.
         */
        public var localization:Localization ;
        
        /**
         * Invoked when the current localization of the application is changed.
         */
        public function changeLocalization( e:LocalizationEvent ):void
        {
            trace( e ) ;
            if ( field != null )
            {
                field.text = e.getLocale("field.text") ;
            }
        }
        
        /**
         * Invoked to change the current lang with the Keyboard.UP and Keyboard.DOWN keys.
         */
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
