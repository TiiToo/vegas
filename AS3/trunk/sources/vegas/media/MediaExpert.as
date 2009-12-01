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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.media 
{
    import vegas.events.MediaExpertEvent;
    import vegas.logging.logger;
    import vegas.models.CoreModelObject;
    
    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    
    /**
     * This core expert is a basic implementation to create the MicrophoneExpert and CameraExpert class.
     */
    public class MediaExpert extends CoreModelObject 
    {
        /**
         * Creates a new MediaExpert instance.
         * @param id the id of the model.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function MediaExpert( id:* = null , global:Boolean = false, channel:String = null )
        {
            super( id , global, channel );
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
         * Updates the media settings.
         */
        public function update():void
        {
            
        }
        
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
                logger.info( this + " activity:"  + e.activating ) ;
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
                logger.info( this + " status code:" + code + " level:" + e.level ) ;
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
