/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.media 
{
    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    import flash.media.Microphone;    

    /**
     * This expert manage all Microphone reference in the application.
     * @author eKameleon
     */
    public class MicrophoneExpert extends MediaExpert 
    {

		/**
		 * Creates a new MicrophoneExpert instance.
		 * @param setting The MicrophoneVO reference to set the current Microphone object.
		 * @param index The index value of the microphone. 
		 * @param id the id of the model.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
        public function MicrophoneExpert( setting:MicrophoneVO = null , index:int = 0 , id:* = null , bGlobal:Boolean = false, sChannel:String = null )
        {
            super( id , bGlobal, sChannel );
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
		 * @private
		 */
		private var _micro:Microphone ;
        
    }
}
