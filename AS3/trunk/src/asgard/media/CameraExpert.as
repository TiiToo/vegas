﻿/*

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
    import flash.media.Camera;    

    /**
     * This expert manage all Camera reference in the application.
     * @author eKameleon
     */
    public class CameraExpert extends SimpleModelObject 
    {

		/**
		 * Creates a new CameraExpert instance.
		 * @param setting The CameraVO reference to set the current Camera object.
		 * @param name Specifies which camera to get, as determined from the array returned by the names property. For most applications, get the default camera by omitting this parameter.
		 * @param id the id of the model.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
        public function CameraExpert( setting:CameraVO = null , name:*=null , id:* = null , bGlobal:Boolean = false, sChannel:String = null )
        {
            super( id , bGlobal, sChannel );
            this.setting = setting || DEFAULT_SETTING ;
            setCamera(name) ;
        }
        
        /**
         * The default settings of the Camera objects.
         */
        public static var DEFAULT_SETTING:CameraVO = new CameraVO
        ({
            bandwidth     : 16384 , 
            favorarea     : true , 
            fps           : 24 , 
            height        : 120,
            motionLevel   : 50 , 
            motionTimeout : 2000 ,
            quality       : 0 , 
            width         : 160
        }) ;
         
		/**
		 * Returns the Camera client reference.
		 * @return the Camera client reference.
	 	*/
		public function get camera():Camera
		{
			return _camera ;
		}
		
		/**
		 * Determinates the settings of the current Camera object with a CameraVO object.
		 * <p>By default the expert use the DEFAULT_SETTING
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
			_sTypeActivity = ActivityEvent.ACTIVITY ;	
			_sTypeMuted    = MediaExpertEvent.MUTED ;
			_sTypeUnmuted  = MediaExpertEvent.UNMUTED ;
		}
        
		/**
		 * Sets the event name when the Camera activity change.
		 */
		public function setEventTypeACTIVITY(type:String ):void
		{
			_sTypeActivity = type || ActivityEvent.ACTIVITY ;		
		}

		/**
		 * Sets the event name when the Camera is muted.
		 */
		public function setEventTypeMUTED( type:String ):void
		{
			_sTypeMuted = type || MediaExpertEvent.MUTED ;		
        }
	
		/**
		 * Sets the event name when the Camera is unmuted.
		 */
		public function setEventTypeUNMUTED( type:String ):void
		{
			_sTypeUnmuted = type || MediaExpertEvent.UNMUTED ;	
		}
        
		/**
		 * Updates the Camera setting.
		 */
		public function update():void
		{
    		if ( camera != null && (setting as CameraVO) != null )
    		{	
                (setting as CameraVO).apply( camera ) ;
    		}
		}
        
        /**
         * Sets the camera reference of the expert.
         * @param name The name of the camera to use (default null to use the default system Camera object).
         */
        public function setCamera( name:* = null ):void
        {
        	if ( _camera != null )
        	{
                _camera.removeEventListener( ActivityEvent.ACTIVITY , onActivity ) ;
                _camera.removeEventListener( StatusEvent.STATUS     , onStatus ) ;
        	}
            _camera = Camera.getCamera( name != null ? String(name) : null ) ;
            if ( _camera != null )
            {
                _camera.addEventListener( ActivityEvent.ACTIVITY , onActivity ) ;
                _camera.addEventListener( StatusEvent.STATUS     , onStatus ) ;
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
            return value is CameraVO ;
        }        
                
		/**
		 * @private
		 */
		private var _camera:Camera ;
        
		/**
		 * @private
		 */		
		private var _sTypeActivity:String ;
	
		/**
		 * @private
		 */
		private var _sTypeMuted:String ;
		
		/**
		 * @private
		 */
		private var _sTypeUnmuted:String ;
                
		/**
		 * Invoked when the camera starts or stops detecting movement.
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
		 * Invoked when the camera status change.
		 */
		protected function onStatus( e:StatusEvent = null ):void
		{
			var code:String = e.code ;
			if ( verbose )
			{
				getLogger().info( this + " camera status, code:" + code + " level:" + e.level ) ;
			}
			switch( code )
			{
				case CameraStatus.MUTED :
				{
					dispatchEvent( new MediaExpertEvent( _sTypeMuted, this ) ) ;
                    break ;
				}	
				case CameraStatus.UNMUTED :
				{
					dispatchEvent( new MediaExpertEvent( _sTypeUnmuted, this ) ) ;
					break ;	
				}
			}
		}     
        
    }
}
