﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is VEGAS Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2010  the Initial Developer. All Rights Reserved.    Contributor(s) :    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.  */package vegas.net {    import system.events.CoreEventDispatcher;    import system.numeric.Mathematics;    import system.signals.Signal;    import system.signals.Signaler;        import vegas.events.SoundEvent;    import vegas.logging.logger;    import vegas.media.FLVMetaData;        import flash.events.AsyncErrorEvent;    import flash.events.ErrorEvent;    import flash.events.IOErrorEvent;    import flash.events.NetStatusEvent;    import flash.media.SoundTransform;    import flash.media.Video;    import flash.net.NetStream;        /**     * Specifies the advanced object on which callback methods are invoked by a NetStream object.     */    public class NetStreamClient extends CoreEventDispatcher implements INetStreamClient    {        /**         * Creates a new NetStreamClient instance.         * @param netStream The NetStream reference of this advanced proxy client manager.         * @param video The Video reference of this netstream client to register automatickly the stream with the video.         */        public function NetStreamClient( netStream:NetStream = null , video:Video = null )         {            this.netStream = netStream ;            this.video     = video ;        }                /**         * Indicates the number of seconds to save the buffer in memory.         */        public function get bufferLength():Number        {            return _netStream ? _netStream.bufferLength : 0 ;        }                /**         * Specifies the percentage (value between 0 and 1) of the buffer that is filled.         */        public function get bufferPercent():Number        {            return _netStream ? Mathematics.normalize( Mathematics.percentage( bufferLength , bufferTime ) , 0 , 100 ) : 0 ;        }                /**         * Indicates the buffer time of the stream.         */        public function get bufferTime():Number        {            return _netStream ? _netStream.bufferTime : 0 ;        }                /**         * @private         */        public function set bufferTime( value:Number ):void        {            if( _netStream )            {                _netStream.bufferTime = value ;            }        }                /**         * This signal emit cuepoint informations when an embedded cue point is reached while playing an FLV file.         */        public function get cuePoint():Signaler        {            return _cuePoint ;        }                /**         * Indicates the duration of the media.         * This feature work only if the client property is NetServerStream and the metadaData object is initialize with the duration value, else return 0.         */        public function get duration():Number         {            return isNaN(_duration) ? 0 : _duration ;        }                /**         * This signal emit when the Flash Player notify an ErrorEvent.         */        public function get error():Signaler        {            return _error ;        }                /**         * This signal emit when Flash Player receives image data as a byte array embedded in a media file that is playing.          * The image data can produce either JPEG, PNG or GIF content.          * Use the flash.display.Loader.loadBytes() method to load the byte array into a display object.         */        public function get imageData():Signaler        {            return _imageData ;        }                /**         * This signal emit metadatas informations when the application receives descriptive information embedded in the video being played.         */        public function get meta():Signaler        {            return _meta ;        }                /**         * The flv metadata object.         */        public var metadata:FLVMetaData ;                /**         * This signal emit when the sound is muted.          */        public function get muteIt():Signaler        {            return _muteIt ;        }                /**         * @private         */        public function set muteIt( signal:Signaler ):void        {            _muteIt = signal || new Signal() ;        }                /**         * Specifies the left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right).          * A value of 0 represents no panning (balanced center between right and left).          */        public function get pan():Number        {            return _pan ;        }                /**         * @private         */        public function set pan( value:Number ):void        {            _pan = isNaN(value) ? 0 : value ;            if ( _netStream )            {                _netStream.soundTransform = new SoundTransform( ___isMute___ ? 0 : _volume , _pan ) ;            }             _fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;        }                /**         * This signal emit when the application receives descriptive information embedded in the video being played.          * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.         * @see NetStreamStatus.PLAY_COMPLETE         * @see NetStreamStatus.PLAY_SWITCH         */        public function get playStatus():Signaler         {            return _playStatus ;        }                /**         * Specifies the percentage progress value of the stream. Using duration and time properties.         */        public function get progress():Number        {            if ( _netStream != null )            {                var p:Number = Mathematics.percentage( _netStream.time , duration ) ;                return isNaN(p) ? 0 : p ;            }            else            {                return 0 ;            }        }                /**         * The owner NetStream reference of this object.         */        public function get netStream():NetStream        {            return _netStream ;        }                /**         * @private         */        public function set netStream( netStream:NetStream ):void        {            if( _netStream != null )            {                _netStream.client = null ;                _netStream.removeEventListener( AsyncErrorEvent.ASYNC_ERROR , handleError     ) ;                _netStream.removeEventListener( IOErrorEvent.IO_ERROR       , handleError     ) ;                _netStream.removeEventListener( NetStatusEvent.NET_STATUS   , netStatus ) ;            }            _netStream  = netStream  ;            if( _netStream != null )            {                _netStream.client         = this ;                _netStream.soundTransform = new SoundTransform( ___isMute___ ? 0 : _volume , _pan ) ;                _netStream.addEventListener( AsyncErrorEvent.ASYNC_ERROR , handleError ) ;                _netStream.addEventListener( IOErrorEvent.IO_ERROR       , handleError ) ;                _netStream.addEventListener( NetStatusEvent.NET_STATUS   , netStatus   ) ;                checkForModification() ;            }        }                /**         * This signal emit when the application receives descriptive information embedded in the video being played.          * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.         * @see NetStreamStatus.PLAY_COMPLETE         * @see NetStreamStatus.PLAY_SWITCH         */        public function get status():Signaler         {            return _status ;        }                /**         * This signal emit when the Flash Player receives text data embedded in a media file that is playing.         */        public function get textData():Signaler         {            return _textData ;        }                /**         * Indicates the time value in seconds of the stream.         */        public function get time():Number        {            return _netStream ? _netStream.time : 0 ;        }                /**         * This signal emit when the sound is unmuted.          */        public function get unmuteIt():Signaler        {            return _unmuteIt ;        }                /**         * @private         */        public function set unmuteIt( signal:Signaler ):void        {            _unmuteIt = signal || new Signal() ;        }                /**         * The verbose mode.         */        public var verbose:Boolean ;                /**         * The Video reference of this expert.         */        public function get video():Video        {            return _video ;        }                /**         * @private         */        public function set video( video:Video ):void        {            if ( _video )            {                _video.attachNetStream( null ) ;            }            _video = video ;            checkForModification() ;        }                /**         * Specifies the volume, ranging from 0 (silent) to 1 (full volume).          */        public function get volume():Number        {            return _volume ;        }                /**         * @private         */        public function set volume( value:Number ):void        {            _volume = Mathematics.clamp( isNaN(value) ? 0 : value , 0, 1) ;            if ( _netStream )            {                _netStream.soundTransform = new SoundTransform( ___isMute___ ? 0 : _volume , _pan ) ;            }             _fireSoundEvent( SoundEvent.SOUND_UPDATE ) ;        }                 /**         * This signal emit when receives information specific to Adobe Extensible Metadata Platform (XMP)          * that is embedded in the Adobe F4V or FLV video file.          * <p>The XMP metadata includes cue points as well as other video metadata. XMP metadata support is introduced with Flash Player 10 and Adobe AIR 1.5 and supported by subsequent versions of Flash Player and AIR.</p>         */        public function get xmpData():Signaler        {            return _xmpData ;        }                /**         * Clear the video reference.         */        public function clear():void        {            if ( video )            {                video.clear() ;            }            else if ( verbose )            {                logger.warn( this + " clear failed, the video reference not mut be null." ) ;            }        }                /**         * Returns <code class="prettyprint">true</code> if the sound is muted.         * @return <code class="prettyprint">true</code> if the sound is muted.         */        public function isMuted():Boolean         {            return ___isMute___ ;        }                /**         * Mute the sound of the netstream.         */        public function mute():void         {            ___isMute___ = true ;            if ( _netStream )            {                _netStream.soundTransform = new SoundTransform( 0 , _pan ) ;            }            _muteIt.emit( this ) ;        }                /**         * Invoked when an embedded cue point is reached while playing an FLV file.         */        public function onCuePoint( info:Object ):void         {            if ( verbose )            {                 logger.info( this + " cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type) ;            }            _cuePoint.emit( info ) ;        }                /**         * Dispatched when Flash Player receives image data as a byte array embedded in a media file that is playing.          * The image data can produce either JPEG, PNG or GIF content.          * Use the flash.display.Loader.loadBytes() method to load the byte array into a display object.         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * public function onImageData(imageData:Object):void          * {         *     // display track number         *     trace(imageData.trackid);         *     var loader:Loader = new Loader();         *     //imageData.data is a ByteArray object         *     loader.loadBytes(imageData.data);         *     addChild(loader);         * }          * </pre>         */        public function onImageData( imageData:Object ):void        {            if ( verbose )            {                 logger.info( this + " onImageData imageData:" + imageData ) ;            }            _imageData.emit( imageData ) ;        }                  /**         * Dispatched when the application receives descriptive information embedded in the video being played.          * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.         */        public function onMetaData(info:Object):void         {            if ( verbose )            {                 logger.info( this + " onMetaData info:" + info ) ;            }            metadata = new FLVMetaData( info ) ;            if ( metadata != null )            {                setDuration( metadata.duration ) ;            }            _meta.emit( metadata ) ;        }                /**         * Dispatched when the application receives descriptive information embedded in the video being played.          * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.         * @see NetStreamStatus.PLAY_COMPLETE         * @see NetStreamStatus.PLAY_SWITCH         */        public function onPlayStatus( info:Object ):void         {            if ( verbose )            {                 logger.info( this + " onPlayStatus info:" + info ) ;            }            _playStatus.emit( info ) ;        }                /**         * The onTextData event sends text data through an AMF0 data channel. This callback method is invoked when Flash Player receives text data embedded in a media file that is playing.          * <p>The text data is in UTF-8 format and can contain information about formatting based on the 3GP timed text specification.</p>         * <p>This specification defines a standardized subtitle format.         * Define an onTextData() callback method to process this information, in the same way that you would define callback methods for onCuePoint or onMetaData. In the following example, the onTextData() method displays the track ID number and corresponding track text.</p>         * <p>This special event is intended for use with Flash Media Server; for more information, see the class description. You cannot use the addEventListener() method, or any other EventDispatcher methods, to listen for, or process, this event.          * Rather, you must define a single callback function and attach it directly to the textData object.</p>         * <p>This event is triggered after a call to the NetStream.play() method, but before the video playhead has advanced.</p>         * <p>The onTextData event object contains one property for each piece of text data.</p>         * <p><b>Example :</b></p>         * <pre class="prettyprint">         * public function onTextData(textData:Object):void         * {         *     // display the track number         *     trace( textData.trackid ) ;         *     // displays the text, which can be a null string, indicating old text that should be erased         *     trace( textData.text ) ;         * }         * </pre>         */        public function onTextData( textData:Object ):void         {            if ( verbose )            {                 logger.info( this + " onTextData textData:" + textData ) ;            }            _textData.emit( textData ) ;        }                /**         * The onXMPData() callback function receives information specific to Adobe Extensible Metadata Platform (XMP)          * that is embedded in the Adobe F4V or FLV video file.          * <p>The XMP metadata includes cue points as well as other video metadata. XMP metadata support is introduced with Flash Player 10 and Adobe AIR 1.5 and supported by subsequent versions of Flash Player and AIR.</p>         */        public function onXMPData( info:Object ):void        {            if ( verbose )            {                 logger.info( this + " onXMPData info:" + info ) ;            }            _xmpData.emit( info ) ;        }                /**         * Sets the duration of the stream video.         */        public function setDuration( duration:Number = 0 ):void        {            _duration = duration > 0 ? duration : 0 ;        }                /**         * @private         */        protected var _netStream:NetStream ;                /**         * Invoked when a modification of the expert is success.         */        protected function checkForModification():void        {            if ( _video && netStream )            {                _video.attachNetStream( netStream ) ;             }        }                /**         * Invoked when the NetStream notify an ErrorEvent.         */        protected function handleError( e:ErrorEvent ):void        {            if ( verbose )            {                logger.error( this + " error:" + e ) ;            }            dispatchEvent(e) ;            _error.emit( e ) ;        }                /**         * Invoked when the NetStream status is changed.         */        protected function netStatus( e:NetStatusEvent ):void        {            if ( verbose )            {                logger.info( this + " netStatus, code:" + e.info.code + " level:" + e.info.level ) ;            }            _status.emit( e.info ) ;        }                /**         * Unmute the sound of the netstream.         */        public function unmute():void         {            ___isMute___ = false ;            if ( _netStream )            {                _netStream.soundTransform = new SoundTransform( _volume , _pan ) ;            }             _unmuteIt.emit( this ) ;        }                /**         * @private         */        private var _cuePoint:Signaler = new Signal() ;                /**         * @private         */        private var _duration:Number = 0 ;                /**         * @private         */        private var _error:Signaler = new Signal() ;                /**         * @private         */        private var _imageData:Signaler = new Signal() ;                /**         * The internal flag to indicates if the sound is muted or not.         * @private         */         private var ___isMute___:Boolean ;                /**         * @private         */        private var _meta:Signaler = new Signal() ;                /**         * @private         */        private var _muteIt:Signaler = new Signal() ;                /**         * @private         */        private var _pan:Number = 0 ;                /**         * @private         */        private var _playStatus:Signaler = new Signal() ;                /**         * @private         */        private var _status:Signaler = new Signal() ;                /**         * @private         */        private var _textData:Signaler = new Signal() ;                /**         * @private         */        private var _unmuteIt:Signaler = new Signal() ;                /**         * @private         */        private var _video:Video ;                /**         * @private         */        private var _volume:Number = 1 ;                /**         * @private         */        private var _xmpData:Signaler = new Signal() ;                /**         * @private         */        private function _fireSoundEvent( type:String ):void        {            if ( isLocked() )            {                return ;            }            dispatchEvent( new SoundEvent( type, this , _netStream.soundTransform ) ) ;         }    }}