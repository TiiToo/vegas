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
