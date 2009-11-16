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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.net 
{
    import asgard.events.SoundEvent;
    import asgard.logging.logger;
    import asgard.media.FLVMetaData;
    
    import system.events.CoreEventDispatcher;
    import system.numeric.Mathematics;
    
    import flash.events.AsyncErrorEvent;
    import flash.events.IOErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.media.SoundTransform;
    import flash.net.NetStream;
    
    /**
     * Specifies the advanced object on which callback methods are invoked by a NetStream object.
     */
    public class NetStreamClient extends CoreEventDispatcher implements INetStreamClient
    {
        /**
         * Creates a new NetStreamClient instance.
         * @param netStream The NetStream reference of this advanced proxy client manager.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function NetStreamClient( netStream:NetStream = null , global:Boolean = false , channel:String = null ) 
        {
            super( global , channel ) ;
            if ( netStream != null )
            {
                this.netStream = netStream ;
            }
        }
        
        /**
         * Specifies the percentage of the buffer that is filled.
         */
        public function get bufferPercent():Number
        {
            if ( _netStream != null )
            {
                var p:Number = Mathematics.percentage( _netStream.bufferLength , _netStream.bufferTime ) ;
                return isNaN(p) ? 0 : p ;
            }
            else
            {
                return 0 ;
            }
        }
        
        /**
         * (read-only) Indicates the duration of the media.
         * This feature work only if the client property is NetServerStream and the metadaData object is initialize with the duration value, else return 0.
         */
        public function get duration():Number 
        {
            return _duration ;
        }
        
        /**
         * The flv metadata object.
         */
        public var metadata:FLVMetaData ;
        
        /**
         * Specifies the left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right). 
         * A value of 0 represents no panning (balanced center between right and left). 
         */
        public function get pan():Number
        {
            return _pan ;
        }
        
        /**
         * @private
         */
        public function set pan( value:Number ):void
        {
            _pan = isNaN(value) ? 0 : value ;
            if ( _netStream != null )
            {
                _netStream.soundTransform = new SoundTransform( _volume , _pan ) ;
            } 
            _fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
        }
        
        /**
         * Specifies the percentage progress value of the stream. Using duration and time properties.
         */
        public function get progress():Number
        {
            if ( _netStream != null )
            {
                var p:Number = Mathematics.percentage( _netStream.time , duration ) ;
                return isNaN(p) ? 0 : p ;
            }
            else
            {
                return 0 ;
            }
        }
        
        /**
         * The owner NetStream reference of this object.
         */
        public function get netStream():*
        {
            return _netStream ;
        }
        
        /**
         * @private
         */
        public function set netStream( netStream:NetStream ):void
        {
            if( _netStream != null )
            {
                _netStream.client = null ;
                _netStream.removeEventListener( AsyncErrorEvent.ASYNC_ERROR , asyncError ) ;
                _netStream.removeEventListener( IOErrorEvent.IO_ERROR       , ioError    ) ;
                _netStream.removeEventListener( NetStatusEvent.NET_STATUS   , netStatus  ) ;
            }            
            _netStream  = netStream  ;
            if( _netStream != null )
            {
                _netStream.client         = this ;
                _netStream.soundTransform = new SoundTransform( _volume , _pan ) ;
                _netStream.addEventListener( AsyncErrorEvent.ASYNC_ERROR , asyncError ) ;
                _netStream.addEventListener( IOErrorEvent.IO_ERROR       , ioError    ) ;
                _netStream.addEventListener( NetStatusEvent.NET_STATUS   , netStatus  ) ;
            }
        }
        
        /**
         * The verbose mode.
         */
        public var verbose:Boolean ;
        
        /**
         * Specifies the volume, ranging from 0 (silent) to 1 (full volume). 
         */
        public function get volume():Number
        {
            return _volume ;
        }
        
        /**
         * @private
         */
        public function set volume( value:Number ):void
        {
            _volume = Mathematics.clamp( isNaN(value) ? 0 : value , 0, 1) ;
            if ( _netStream )
            {
                _netStream.soundTransform = new SoundTransform( _volume , _pan ) ;
            } 
            _fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;
        } 
        
        /**
         * Invoked when an embedded cue point is reached while playing an FLV file.
         * This method can be overrides easily.
         */        
        public function onCuePoint( info:Object ):void 
        {
            if ( verbose )
            {
                 logger.info( this + " cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type) ;
            }
        }
        
        /**
         * Dispatched when Flash Player receives image data as a byte array embedded in a media file that is playing. 
         * The image data can produce either JPEG, PNG or GIF content. 
         * Use the flash.display.Loader.loadBytes() method to load the byte array into a display object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * public function onImageData(imageData:Object):void 
         * {
         *     // display track number
         *     trace(imageData.trackid);
         *     var loader:Loader = new Loader();
         *     //imageData.data is a ByteArray object
         *     loader.loadBytes(imageData.data);
         *     addChild(loader);
         * } 
         * </pre>
         */
        public function onImageData( imageData:Object ):void
        {
            //
        }
          
        /**
         * Dispatched when the application receives descriptive information embedded in the video being played. 
         * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.
         */
        public function onMetaData(info:Object):void 
        {
            metadata = new FLVMetaData( info ) ;
            if ( metadata != null )
            {
                setDuration( metadata.duration ) ;
            }
        }
        
        /**
         * Dispatched when the application receives descriptive information embedded in the video being played. 
         * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.
         * @see NetStreamStatus.PLAY_COMPLETE
         * @see NetStreamStatus.PLAY_SWITCH
         */
        public function onPlayStatus(info:Object):void 
        {
            // 
        }
        
        /**
         * Invoked when the status of the stream change.
         */
        public function onStatus( info:Object ):void
        {
            //
        }
        
        /**
         * The onTextData event sends text data through an AMF0 data channel. This callback method is invoked when Flash Player receives text data embedded in a media file that is playing. 
         * <p>The text data is in UTF-8 format and can contain information about formatting based on the 3GP timed text specification.</p>
         * <p>This specification defines a standardized subtitle format.
         * Define an onTextData() callback method to process this information, in the same way that you would define callback methods for onCuePoint or onMetaData. In the following example, the onTextData() method displays the track ID number and corresponding track text.</p>
         * <p>This special event is intended for use with Flash Media Server; for more information, see the class description. You cannot use the addEventListener() method, or any other EventDispatcher methods, to listen for, or process, this event. 
         * Rather, you must define a single callback function and attach it directly to the textData object.</p>
         * <p>This event is triggered after a call to the NetStream.play() method, but before the video playhead has advanced.</p>
         * <p>The onTextData event object contains one property for each piece of text data.</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * public function onTextData(textData:Object):void
         * {
         *     // display the track number
         *     trace( textData.trackid ) ;
         *     // displays the text, which can be a null string, indicating old text that should be erased
         *     trace( textData.text ) ;
         * }
         * </pre>
         */
        public function onTextData(textData:Object):void 
        {
            //
        }
        
        /**
         * The onXMPData() callback function receives information specific to Adobe Extensible Metadata Platform (XMP) 
         * that is embedded in the Adobe F4V or FLV video file. 
         * <p>The XMP metadata includes cue points as well as other video metadata. XMP metadata support is introduced with Flash Player 10 and Adobe AIR 1.5 and supported by subsequent versions of Flash Player and AIR.</p>
         */
        public function onXMPData( info:Object ):void
        {
            //
        }
        
        /**
         * Sets the duration of the stream video.
         */
        public function setDuration( duration:Number = 0 ):void
        {
            _duration = duration > 0 ? duration : 0 ;
        }        
        
        /**
         * @private
         */
        protected var _netStream:NetStream ;
        
        /**
         * Invoked when the NetStream invoked an AsyncErrorEvent.
         */
        protected function asyncError( e:AsyncErrorEvent ):void
        {
            if ( verbose )
            {
                logger.error( this + " ioError " + e ) ;
            }
            dispatchEvent(e) ;
        }
        
        /**
         * Invoked when the NetStream invoked an IOErrorEvent.
         */
        protected function ioError( e:IOErrorEvent ):void
        {
            if ( verbose )
            {
                logger.error( this + " ioError " + e ) ;
            }
            dispatchEvent(e) ;
        }
        
        /**
         * Invoked when the NetStream invoked a NetStatusEvent.
         */
        protected function netStatus( e:NetStatusEvent ):void
        {
            if ( verbose )
            {
                logger.info( this + " netStatus, code:" + e.info.code + " level:" + e.info.level ) ;
            }
            onStatus( e.info ) ;
            dispatchEvent(e) ;
        }
        
        /**
         * @private
         */
        private var _duration:Number = 0 ;
        
        /**
         * @private
         */
        private var _pan:Number = 0 ;
        
        /**
         * @private
         */
        private var _volume:Number = 1 ;
        
        /**
         * @private
         */
        private function _fireSoundEvent( type:String ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( new SoundEvent( type, this , _netStream.soundTransform ) ) ; 
        }
    }
}
