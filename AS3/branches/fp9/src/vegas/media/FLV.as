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
    import flash.display.BitmapData;
    import flash.utils.ByteArray;
    
    [ExcludeClass]
    
    /**
     * The FLV file is a ByteArray based on <a href="http://www.adobe.com/devnet/flv/">the official FLV specification</a>.
     * Notes : For the moment this class create an only stream file (not audio). This class is in progress, not use it please.
     * <p>FLV structure summary:</p>
     * <pre>
     *  ------------------------------
     *  header
     *  
     *  previoustagsize
     *  flvtag
     *      [info]
     *      videodata
     *          [info]
     *          screenvideopacket
     *              [info]
     *              imageblocks
     *              imageblocks
     *  previoustagsize
     *  flvtag
     *  ------------------------------
     *  FLV file format:
     *  
     *      header
     *      
     *      last tag size
     *      
     *      FLVTAG:
     *          tagtype
     *          datasize
     *          timestamp
     *          timestampextended
     *          streamid
     *          data [VIDEODATA]:
     *              frametype
     *              codecid
     *              videodata [SCREENVIDEOPACKET]:
     *                  blockwidth                      ub[4]
     *                  imagewidth                      ub[12]
     *                  blockheight                     ub[4]
     *                  imageheight                     ub[12]
     *                  imageblocks [IMAGEBLOCKS[]]:    
     *                      datasize                    ub[16] <same as 'ub16', i think>
     *                      data..
     *      
     *      last tag size
     *      
     *      FLVTAG
     *      
     *      etc.
     * ------------------------------
     */
    public class FLV extends ByteArray
    {
        /**
         * Creates a new FLVFile instance.
         * @param width The frame width of the video.
         * @param height The frame height of the video.
         * @param frameRate The frames rate of the video.
         * @param duration The duration in second of the video.
         */
        public function FLV( width:uint = 320 , height:uint = 240 , frameRate:Number = 24 , duration:Number = 0 , metaData:FLVMetaData = null ):void
        {
            _width    = width ;
            _height   = height ;
            _rate     = frameRate ;
            _duration = duration ;
            _metaData = metaData || new FLVMetaData() ;
        }
        
        /**
         * The duration in sedonc of the video.
         */
        public function get duration():Number
        {
            return _duration ;
        }
        
        /**
         * Indicates the frame rate of the FLV video stream.
         */
        public function get frameRate():Number
        {
            return _rate ;
        }
        
        /**
         * The frame height of the FLV video stream.
         */
        public function get height():int
        {
            return _height ;
        }
        
        /**
         * The frame width of the FLV video stream.
         */
        public function get width():int
        {
            return _width ;
        }
        
        /**
         * Adds a new frame (BitmapData) in the video stream.
         * Note : The bitmap dimensions should be the same like the FLV file.
         */
        public function addFrame( frame:BitmapData ):void 
        {
            writeUnsignedInt( previousTagSize ) ;
            writeBytes( videoTag( frame ) ) ;  
        }
        
        /**
         * Adds a collection of frames(BitmapData) in the video stream.
         */
        public function addFrames( frames:Array ):void 
        {
            if( frames && frames.length > 0 )
            {
                for each( var frame:BitmapData in frames )
                {
                    addFrame( frame ) ;
                }
            }
        }
        
        /**
         * Clears the contents of the FLV byte array and resets the tags inside.
         */
        public function reset():void
        {
            clear() ;
            writeBytes( header() ) ;
            writeUnsignedInt( previousTagSize ) ;
            writeBytes( metaTag() ) ;
        }

        private function clear():void
        {
        }
        
        /**
         * @private
         */
        protected var _duration:Number ;
        
        /**
         * @private
         */
        protected var _height:int ;
        
        /**
         * @private
         */
        protected var _metaData:FLVMetaData ;
        
        /**
         * @private
         */
        protected var _rate:Number ;
        
        /**
         * @private
         */
        protected var _width:int  ;
        
        /**
         * @private
         */
        protected var iteration:int ;
        
        /**
         * @private
         */
        protected var metadatacreator:String = "VEGAS code.google.com/p/vegas - vegas.media.FLV"; // FIXME use a FLVMetaData object to initialize the FLV
        
        /**
         * @private
         */
        protected var previousTagSize:uint ;
        
        /**
         * Creates the header of the FLV file.
         */
        protected function header():ByteArray 
        {
            var header:ByteArray = new ByteArray();
            header.writeByte( 0x46 ) ; // 'F'
            header.writeByte( 0x4C ) ; // 'L'
            header.writeByte( 0x56 ) ; // 'V'
            header.writeByte( 0x01 ) ; // File version ( 0x01 = version 1 )
            header.writeByte( 0x01 ) ; // misc flags - video stream only
            header.writeUnsignedInt(0x09) ; // header length
            return header;
        }
        
        /**
         * @private
         */
        private function metaData():ByteArray 
        {
            // onMetaData info goes in a ScriptDataObject of data type 'ECMA Array'
            
            var b:ByteArray = new ByteArray();
            
            // ObjectNameType (always 2)
            
            b.writeByte(2); 
            
            // ObjectName (type SCRIPTDATASTRING)
            
            writeUI16(b, "onMetaData".length) ; // StringLength
            b.writeUTFBytes("onMetaData") ; // StringData
            
            // ObjectData (type SCRIPTDATAVALUE)
            
            b.writeByte(8) ; // Type (ECMA array = 8)
            b.writeUnsignedInt(7) ;// // Elements in array
            
            // SCRIPTDATAVARIABLES
            
            if ( _duration > 0 ) 
            {
                writeUI16(b, "duration".length ) ;
                b.writeUTFBytes("duration") ;
                b.writeByte(0) ; 
                b.writeDouble( _duration ) ;
            }
            
            // width
            
            writeUI16(b, "width".length);
            b.writeUTFBytes("width");
            b.writeByte(0); 
            b.writeDouble(_width);
            
            // height
            
            writeUI16(b, "height".length);
            b.writeUTFBytes("height");
            b.writeByte(0); 
            b.writeDouble(_height);
            
            writeUI16(b, "framerate".length) ;
            b.writeUTFBytes("framerate") ;
            b.writeByte(0); 
            b.writeDouble(_rate) ;
            
            writeUI16(b, "videocodecid".length);
            b.writeUTFBytes("videocodecid") ;
            b.writeByte(0); 
            b.writeDouble(3); // 'Screen Video' = 3
            writeUI16(b, "canSeekToEnd".length);
            b.writeUTFBytes("canSeekToEnd");
            b.writeByte(1); 
            b.writeByte(int(true));
            
            writeUI16(b, "metadatacreator".length) ;
            b.writeUTFBytes("metadatacreator") ;
            b.writeByte( 2 ) ; 
            writeUI16( b , metadatacreator.length ) ;
            b.writeUTFBytes( metadatacreator );
            
            writeUI24(b, 9) ; // VariableEndMarker1 (type UI24 - always 9)
            return b;
        }
        
        /**
         * @private
         */
        protected function metaTag():ByteArray 
        {
            var tag:ByteArray = new ByteArray();
            var datas:ByteArray = metaData();
            
            // header
            
            tag.writeByte(18) ; // tagType = script data
            writeUI24(tag, datas.length) ; // data size
            writeUI24(tag, 0) ; // timestamp should be 0 for onMetaData tag
            tag.writeByte(0) ; // timestamp extended
            writeUI24(tag, 0) ; // streamID always 0
            
            // datas
            tag.writeBytes( datas ) ;
            
            previousTagSize = tag.length;
            return tag;
        }
        
        /**
         * @private
         */
        private function videoData( frame:BitmapData ):ByteArray 
        {
            var stream:ByteArray = new ByteArray;
            
            // VIDEODATA 'header'
            
            stream.writeByte(0x13); // frametype (1) + codecid (3)
            
            // SCREENVIDEOPACKET 'header'
            
            // blockwidth/16-1 (4bits) + imagewidth (12bits)
            
            writeUI4_12( stream , int(blockWidth / 16) - 1, _width) ;
            
            // blockheight/16-1 (4bits) + imageheight (12bits)
            
            writeUI4_12( stream , int(blockHeight / 16) - 1, _height) ;
            
            // VIDEODATA > SCREENVIDEOPACKET > IMAGEBLOCKS:
            
            var yMax : int = int(_height / blockHeight);
            var yRemainder : int = _height % blockHeight; 
            
            if (yRemainder > 0) 
            {
                yMax += 1 ;
            }
            
            var xMax:int       = int( _width / blockWidth ) ;
            var xRemainder:int = _width % blockWidth ;
            
            if (xRemainder > 0)
            {
                xMax += 1 ;
            }
            
            var block:ByteArray ;
            var xLimit:int ;
            var yLimit:int ;
            var x:int ;
            var y:int ;
            var p:uint ;
            for ( var y1:int ; y1 < yMax ; y1++ ) 
            {
                for( var x1:int ; x1 < xMax ; x1++ ) 
                {
                    block  = new ByteArray() ;
                    yLimit = blockHeight ; 
                    if ( yRemainder > 0 && y1 + 1 == yMax ) 
                    {
                        yLimit = yRemainder;
                    }
                    for ( var y2:int ; y2 < yLimit ; y2++ ) 
                    {
                        xLimit = blockWidth;
                        if ( xRemainder > 0 && x1 + 1 == xMax )
                        {
                             xLimit = xRemainder ;
                        }
                        for ( var x2:int ; x2 < xLimit ; x2++ ) 
                        {
                            x = ( x1 * blockWidth ) + x2;
                            y = _height - ( ( y1 * blockHeight ) + y2) ; // (flv's save from bottom to top)
                            p = frame.getPixel( x , y ) ;
                            
                            block.writeByte( p & 0xFF ) ;  // blue 
                            block.writeByte( p >> 8 & 0xFF ) ; // green
                            block.writeByte( p >> 16) ; // red
                        }
                    }
                    block.compress();
                    writeUI16( stream , block.length ) ; // write block length (UI16)
                    stream.writeBytes( block ) ; // write block
                }
            }
            return stream ;
        }
        
        /**
         * @private
         */
        protected function videoTag( frame:BitmapData ):ByteArray 
        {
            var tag:ByteArray  = new ByteArray();
            var datas:ByteArray = videoData( frame );
            var timeStamp:uint = uint(1000 / _rate * iteration++) ;
            
            // header
            
            tag.writeByte(0x09) ; // tagType = video
            writeUI24(tag, datas.length) ; // data size
            writeUI24(tag, timeStamp) ; // timestamp in ms
            tag.writeByte(0) ; // timestamp extended, not using *** 
            writeUI24(tag, 0) ; // streamID always 0
            
            // videodata
            
            tag.writeBytes( datas );
            previousTagSize = tag.length;
            
            return tag;
        }
        
        /**
         * @private
         */
        private const blockWidth:int = 32 ;
        
        
        /**
         * @private
         */
        private const blockHeight:int = 32 ;
        
        /**
         * @private
         */
        private function writeUI24(stream:*, p:uint):void 
        {
            var byte1:int = p >> 16;
            var byte2:int = p >> 8 & 0xff;
            var byte3:int = p & 0xff;
            stream.writeByte(byte1);
            stream.writeByte(byte2);
            stream.writeByte(byte3);
        }
        
        /**
         * @private
         */
        private function writeUI16(stream:*, p:uint):void 
        {
            stream.writeByte(p >> 8);
            stream.writeByte(p & 0xff);
        }
        
        /**
         * Writes a 4-bit value followed by a 12-bit value in two sequential bytes.
         * @private
         */
        private function writeUI4_12(stream:*, p1:uint, p2:uint):void 
        {
            var byte1a:int = p1 << 4;
            var byte1b:int = p2 >> 8;
            var byte1:int  = byte1a + byte1b;
            var byte2:int  = p2 & 0xff;
            stream.writeByte(byte1);
            stream.writeByte(byte2);
        }
    }
}
