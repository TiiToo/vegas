/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is CalistA Framework.
  
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

package calista.hash 
{    import flash.utils.ByteArray;
    
    /**
     * A <a href="http://en.wikipedia.org/wiki/Cyclic_redundancy_check">cyclic redundancy check (CRC)</a> is a non-secure hash function designed to detect accidental changes to raw computer data, and is commonly used in digital networks and storage devices such as hard disk drives.       * This algorithm is used in the GZIP file format specification version 4.3 defines in the RFC 1952.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import calista.hash.CRC32;
     *     
     *     import flash.display.Sprite;
     *     import flash.utils.ByteArray;
     *     
     *     public class CRC32Example extends Sprite 
     *     {
     *         public function CRC32Example()
     *         {
     *             var bytes:ByteArray = new ByteArray() ;
     *             bytes.writeUTFBytes("hello world") ;
     *             
     *             var sum:uint = CRC32.checkSum(bytes) ;
     *             
     *             trace("CRC32 : " + sum + " 0x" + sum.toString( 16 ).toUpperCase() ) ; // CRC32 : 222957957 0xD4A1185
     *         }
     *     }
     * }
     * </pre>
     */    public final class CRC32 
    {
        /**
         * Generates the checksum of the specified ByteArray with the CRC32 algorithm.
         * @param buffer the buffer ByteArray object which contains the datas.
         * @param index The index to begin the buffering (default 0).
         * @param length The length value to limit the buffering (if this value is 0, the length of the ByteArray is used).
         */
        public static function checkSum( buffer:ByteArray , index:uint = 0 , length:uint = 0 ):uint 
        {
            var c:uint = ~0 ;
            if ( index >= buffer.length ) 
            { 
                index = buffer.length ; 
            }
            if( length == 0 ) 
            { 
                length = buffer.length - index ; 
            }
            if( ( length + index ) > buffer.length ) 
            { 
                length = buffer.length - index; 
            }
            for ( var off:int = index ; off < length ; off++ )
            {
                c = _crcTable[ ( c ^ buffer[off] ) & 0xFF ] ^ (c >>> 8) ;
            }
            return ~c ;
        }
        
        /**
         * @private
         */
        private static var _crcTable:Array = new Array(256) ;
        
        /////////// init the CRC table
        
        /**
         * @private
         */
        private static function __initCRCTable__():void
        {
            var c:uint ;
            var i:int  ;
            var j:int  ;
            for ( i = 0 ; i<256 ; i++ )
            {
                c = i ;
                for ( j = 0 ; j < 8 ; j++ )
                {
                    c = ( ( c & 1 ) != 0) ? ( 0xEDB88320 ^ ( c >>> 1 ) ) : ( c >>> 1 ) ;
                }
                _crcTable[i] = c ;
            }
        }
        
        __initCRCTable__() ;
        
        //////////
    }}