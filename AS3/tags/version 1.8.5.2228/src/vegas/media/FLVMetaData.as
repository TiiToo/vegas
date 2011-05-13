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
    import core.reflect.getClassName;

    import vegas.vo.SimpleValueObject;
    
    /**
     * The FLVMetaData instances contains all datas values injected in the external FLV video.
     * <p>More informations in the <a href='http://www.buraks.com/flvmdi/'>flvmdi page</a> write by Burak.</p>
     */
    public dynamic class FLVMetaData extends SimpleValueObject 
    {
        /**
         * Creates a new FLVMetaData object.
         * @param o An object with all MetaData properties to fill this instance.
         */
        public function FLVMetaData( init:Object = null )
        {
            super( init );
        }
        
        /**
         * The AAC audio object type; 0, 1, or 2 are supported.
         */
        public var aacaot:int ;
        
        /**
         * AVC IDC level number such as 10, 11, 20, 21, and so on.
         */
        public var avclevel:Number ;
        
        /**
         * AVC profile number such as 55, 77, 100, and so on.
         */
        public var avcprofile:Number ;
        
        /**
         * Audio codec ID number used in the FLV. (Uncompressed = 0, ADPCM = 1, MP3 = 2, NellyMoser = 5 and 6).
         * @see vegas.media.AudioCodec
          */
        public var audiocodecid:* ;
            
        /**
         * A number that indicates the rate at which audio was encoded, in kilobytes per second. (Defaults to 0).
         */
        public var audiodatarate:Number ;
            
        /**
         * A number that indicates what time in the FLV file "time 0" of the original FLV file exists. The video content needs to be delayed by a small amount to properly synchronize the audio.
         * <p>Audio delay in seconds. Flash 8 encoder delays the video for better synch with audio.</p> 
         * (Audio and video does not start both at time 0, Video starts a bit later). 
         * <p>This value is also important for Flash 8 Video Encoder injected Cue Points, because logical time of the cue points does not correspond to physical time they are inserted in the FLV.  
         * (Cue points are injected before encoding, when the video is shifted by 'audio delay' seconds, cue points are also shifted and their physical time in the FLV changes).</p>
         */
        public var audiodelay:Number ;
        
        /**
         * The audio data size.
         */
        public var audiosize:Number ;
        
        /**
         * A Boolean value that is true if the FLV file is encoded with a keyframe on the last frame, which allows seeking to the end of a progressive -download video file.
         * <p>It is <code class="prettyprint">false</code> if the FLV file is not encoded with a keyframe on the last frame.</p>
         * <p>It is <code class="prettyprint">true</code> if the last video tag is a key frame and hence can be 'seek'ed.</p>
         */
        public var canSeekToEnd:Boolean ;
        
        /**
         * The date of creation of the video.
         */
        public var creationdate:String ;
        
        /**
         * An array of objects, one for each cue point embedded in the FLV file. Value is undefined if the FLV file does not contain any cue points. Each object has the following properties :
         * <ul>
         * <li>type</li>
         * <li>name</li>
         * <li>time</li>
         * <li>parameters</li>
         * </ul> 
         */
        public var cuePoints:Array ;
        
        /**
         * The data size of the video.
         */
        public var datasize:Number ;
            
        /**
         * Length of the FLV in seconds. FLVMDI computes this value for example.
         */
        public var duration:Number ;
        
        /**
         * The size of the file.
         */
        public var filesize:Number ;
        
        /**
         * The framerate of the video.
         */
        public var framerate:Number ;
        
        /**
         * Height of the video in pixels. (Flash exporter 1.1 sets this to 0).
         */
        public var height:Number ;
        
        /**
         * This object is added only if you specify the /k switch. 
         * 'keyframes' is known to FLVMDI and if /k switch is not specified, 'keyframes' object will be deleted.
         * 'keyframes' object has 2 arrays : 'filepositions' and 'times'. 
         * Both arrays have the same number of elements, which is equal to the number of key frames in the FLV.
         * Values in times array are in 'seconds'. Each correspond to the timestamp of the n'th key frame.
         * Values in filepositions array are in 'bytes'. Each correspond to the fileposition of the nth key frame video tag (which starts with byte tag type 9).
         */
        public var keyframes:Object ;
        
        /**
         * TimeStamp of the last video tag which is a key frame. 
         * This info might be needed because seeking a frame after this time usually does not work.
         */
        public var lastkeyframetimestamp:Number ;
        
        /**
         * TimeStamp of the last tag in the FLV file. 
         */
        public var lasttimestamp:Number ;
        
        /**
         * The metadata name of the creator.
         */
        public var metadatacreator:String = "" ;
        
        /**
         * The metadata date of the video.
         */
        public var metadatadate:Date ;
        
        /**
         * An array that lists the available keyframes as timestamps in milliseconds. Optional.
         */
        public var seekPoints:Array ;
        
        /**
         * An array of key-value pairs that represent the information in the “list” atom, which is the equivalent of ID3 tags for MP4 files. iTunes uses these tags. Can be used to display artwork, if available.
         */
        public var tags:Array ;
        
        /**
         * Object that provides information on all the tracks in the MP4 file, including their sample description ID.
         */
        public var trackinfo:* ;
        
        /**
         * A string that is the codec version that was used to encode the video. - for example, “avc1” or “VP6F”.
         * <p>In the old version, is a Video codec ID number used in the FLV. (Sorenson H.263 =2, Screen Video =3, On2 VP6 = 4 and 5, Screen Video V2 = 6).</p>
         */
        public var videocodecid:* ;
        
        /**
         * The video data rate (Defaults to 0).
         */
        public var videodatarate:Number ;
        
        /**
         * Framerate of the MP4 video.
         */
        public var videoframerate:Number ;
        
        /**
         * The video data size.
         */
        public var videosize:Number ;
        
        /**
         * A number that is the width of the FLV file, in pixels (Flash exporter 1.1 sets this to 0).
         */
        public var width:Number ;
        
        /**
         * Additional string data if specified.
         */
        public var xtradata:String ;
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public override function toObject():Object
        {
            var r:Object =
            {
                aacaot:aacaot,
                avclevel:avclevel,
                avcprofile:avcprofile,
                audiocodecid:audiocodecid,
                audiodatarate:audiodatarate,
                audiodelay:audiodelay,
                audiosize:audiosize,
                canSeekToEnd:canSeekToEnd,
                creationdate:creationdate,
                cuePoints:cuePoints,
                datasize:datasize,
                duration:duration,
                filesize:filesize,
                framerate:framerate,
                height:height,
                keyframes:keyframes,
                lastkeyframetimestamp:lastkeyframetimestamp,
                lasttimestamp:lasttimestamp,
                metadatacreator:metadatacreator,
                metadatadate:metadatadate,
                seekPoints:seekPoints,
                tags:tags,
                trackinfo:trackinfo,
                videocodecid:videocodecid,
                videodatarate:videodatarate,
                videoframerate:videoframerate,
                videosize:videosize,
                width:width,
                xtradata:xtradata
            };
            return r ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            return formatToString( getClassName(this) , "width" , "height" , "duration" ) ;
        }
    }
}