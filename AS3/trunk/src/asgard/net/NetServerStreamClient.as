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
package asgard.net 
{
    import asgard.media.FLVMetaData;
    
    import vegas.events.CoreEventDispatcher;
    
    import flash.net.NetStream;    

    /**
     * Specifies the object on which callback methods are invoked by a NetStream object.
     * @author eKameleon
     */
    public class NetServerStreamClient extends CoreEventDispatcher implements INetServerStreamClient
    {

        /**
         * Creates a new NetServerStreamClient instance.
         * @param stream The owner NetStream reference of this object.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function NetServerStreamClient( netStream:NetStream=null , bGlobal:Boolean = false , sChannel:String = null ) 
        {
            super( bGlobal , sChannel ) ;
            if ( netStream != null )
            {
                this.netStream = netStream ;
            }
        }
        
        /**
         * The flv metadata object.
         */
        public var metadata:FLVMetaData ;
                
        /**
         * The owner NetStream reference of this object.
         */
        public function get netStream():NetStream
        {
            return _netStream ;
        }
        
        /**
         * @private
         */
        public function set netStream( ns:NetStream ):void
        {
            _netStream = ns ;
            if( _netStream != null )
            {
            	_netStream.client = this ;
            }
        }
                  
        /**
         * Invoked when an embedded cue point is reached while playing an FLV file.
         * This method can be overrides easily.
         */        
        public function onCuePoint( info:Object ):void 
        {
            // overrides
            // getLogger().info( this + " cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
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
               if ( metadata != null && ( netStream as NetServerStream != null ) )
               {
                   (netStream as NetServerStream).setDuration( metadata.duration ) ;    
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
         * @private
         */
        protected var _netStream:NetStream ;        
        
    
    }
}
