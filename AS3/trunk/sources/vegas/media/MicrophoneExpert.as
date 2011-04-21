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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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

package vegas.media 
{
    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    import flash.media.Microphone;
    
    /**
     * This expert manage all Microphone reference in the application.
     */
    public class MicrophoneExpert extends MediaExpert 
    {
        /**
         * Creates a new MicrophoneExpert instance.
         * @param setting The MicrophoneVO reference to set the current Microphone object.
         * @param index The index value of the microphone. 
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         * @param id the id of the model.
         */
        public function MicrophoneExpert( setting:MicrophoneVO = null , index:int = 0 , global:Boolean = false, channel:String = null , id:* = null )
        {
            super( global, channel , id ) ;
            this.setting = setting || DEFAULT_SETTING ;
            setMicrophone( index ) ;
        }
        
        /**
         * The default settings of the Microphone objects.
         */
        public static var DEFAULT_SETTING:MicrophoneVO = new MicrophoneVO
        ({
            loopBack           : false ,
            rate               : 11   , 
            silenceLevel       : 10   , 
            silenceTimeout     : 1000 , 
            useEchoSuppression : false
        }) ;
         
        /**
         * Returns the Microphone client reference.
         * @return the Microphone client reference.
         */
        public function get microphone():Microphone
        {
            return _micro ;
        }
        
        /**
         * Determinates the settings of the current Microphone object with a MicrophoneVO object.
         */
        public function get setting():*
        {
            return getCurrentVO() as MicrophoneVO ;
        }
        
        /**
         * @private
         */
        public function set setting( value:* ):void
        {
            setCurrentVO( ( value as MicrophoneVO ) || DEFAULT_SETTING ) ;
            update() ;
        }
        
        /**
         * Sets the camera reference of the expert.
         * @param name The name of the camera to use (default null to use the default system Camera object).
         */
        public function setMicrophone( index:int = 0 ):void
        {
            if ( _micro != null )
            {
                _micro.removeEventListener( ActivityEvent.ACTIVITY , onActivity ) ;
                _micro.removeEventListener( StatusEvent.STATUS     , onStatus ) ;
            }
            _micro = Microphone.getMicrophone( index ) ;
            if ( _micro != null )
            {
                _micro.addEventListener( ActivityEvent.ACTIVITY , onActivity ) ;
                _micro.addEventListener( StatusEvent.STATUS     , onStatus ) ;
                update() ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">IValidator</code> object validate the value. Overrides this method in your concrete IModelObject class.
         * @param value the object to test.
         * @return <code class="prettyprint">true</code> is this specific value is valid.
         */
        public override function supports( value:* ):Boolean 
        {
            return value is MicrophoneVO ;
        }
        
        /**
         * Updates the Microphone settings.
         */
        public override function update():void
        {
            if ( _micro != null && (setting as MicrophoneVO) != null )
            {   
                ( setting as MicrophoneVO).apply( _micro ) ;
            }
        }
        
        /**
         * @private
         */
        private var _micro:Microphone ;
    }
}
