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
    import andromeda.model.SimpleModelObject;
    
    import asgard.events.MediaExpertEvent;
    
    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    import flash.media.Microphone;    

    /**
     * This expert manage all Microphone reference in the application.
     * @author eKameleon
     */
    public class MicrophoneExpert extends SimpleModelObject 
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
        	loopBack           : true ,
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
		 * Indicates if the expert use verbose debug mode or not.
		 */
		public var verbose:Boolean = true ;

        /**
         * This method is invoked in the constructor of the class to initialize all events.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sActivityType = ActivityEvent.ACTIVITY ;   
            _sMutedType    = MediaExpertEvent.MUTED ;
            _sUnmutedType  = MediaExpertEvent.UNMUTED ;            
        }		
        
		/**
		 * Sets the event name when the Camera activity change.
		 */
		public function setEventTypeACTIVITY(type:String ):void
		{
			_sActivityType = type || ActivityEvent.ACTIVITY ;		
		}

		/**
		 * Sets the event name when the Camera is muted.
		 */
		public function setEventTypeMUTED( type:String ):void
		{
			_sMutedType = type || MediaExpertEvent.MUTED ;		
        }
	
		/**
		 * Sets the event name when the Camera is unmuted.
		 */
		public function setEventTypeUNMUTED( type:String ):void
		{
			_sUnmutedType = type || MediaExpertEvent.UNMUTED ;	
		}
        
		/**
		 * Updates the Camera setting.
		 */
		public function update():void
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
        
		/**
		 * @private
		 */		
		private var _sActivityType:String ;
	
		/**
		 * @private
		 */
		private var _sMutedType:String ;
		
		/**
		 * @private
		 */
		private var _sUnmutedType:String ;
                
		/**
		 * Invoked when the microphone starts or stops detecting sound.
		 */
		protected function onActivity( e:ActivityEvent = null ):void
		{
			if ( verbose )
			{
				getLogger().info( this + " activity:"  + e.activating ) ;
			}
            dispatchEvent( e ) ;
        }

		/**
		 * Invoked when the microphone status change.
		 */
		protected function onStatus( e:StatusEvent = null ):void
		{
			var code:String = e.code ;
			if ( verbose )
			{
				getLogger().info( this + " microphone status, code:" + code + " level:" + e.level ) ;
			}
			switch( code )
			{
				case MicrophoneStatus.MUTED :
				{
					dispatchEvent( new MediaExpertEvent( _sMutedType, this ) ) ;
                    break ;
				}	
				case MicrophoneStatus.UNMUTED :
				{
					dispatchEvent( new MediaExpertEvent( _sUnmutedType, this ) ) ;
					break ;	
				}
			}
		}     
        
    }
}
