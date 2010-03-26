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

package vegas.net 
{
    /**
     * This interface provides all callback methods invoked in a NetStream object.
     */
    public interface INetStreamClient 
    {
        /**
         * Invoked when an embedded cue point is reached while playing an FLV file.
         * This method can be overrides easily.
         */
        function onCuePoint( info:Object ):void ;
        
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
        function onImageData( imageData:Object ):void ;
        
        /**
         * Dispatched when the application receives descriptive information embedded in the video being played. 
         * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.
         */
        function onMetaData(info:Object):void ;
        
        /**
         * Dispatched when the application receives descriptive information embedded in the video being played. 
         * For information about video file formats supported by Flash Media Server, see the Flash Media Server documentation.
         * @see NetStreamStatus.PLAY_COMPLETE
         * @see NetStreamStatus.PLAY_SWITCH
         */
        function onPlayStatus(info:Object):void ;
        
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
        function onTextData(textData:Object):void ;
        
        /**
         * The onXMPData() callback function receives information specific to Adobe Extensible Metadata Platform (XMP) 
         * that is embedded in the Adobe F4V or FLV video file. 
         * <p>The XMP metadata includes cue points as well as other video metadata. XMP metadata support is introduced with Flash Player 10 and Adobe AIR 1.5 and supported by subsequent versions of Flash Player and AIR.</p>
         */
        function onXMPData( info:Object ):void ;
    }
}
