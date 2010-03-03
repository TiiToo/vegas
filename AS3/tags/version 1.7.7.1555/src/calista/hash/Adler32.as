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

package calista.hash 
{    import flash.utils.ByteArray;
    
    /**
     * Adler-32 is a modification of the Fletcher checksum.      * <p>The <a href="http://en.wikipedia.org/wiki/Adler-32">Adler-32</a> checksum is part of the widely-used zlib compression library, as both were developed by Mark Adler.</p>  
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import calista.hash.Adler32;
     *     
     *     import flash.display.Sprite;
     *     import flash.utils.ByteArray;
     *     
     *     public class Adler32Example extends Sprite 
     *     {
     *         public function Adler32Example()
     *         {
     *             var bytes:ByteArray = new ByteArray() ;
     *             bytes.writeUTFBytes("Wikipedia") ;
     *             
     *             var sum:uint = Adler32.checkSum(bytes) ;
     *             
     *             trace("Adler32 : " + sum + " 0x" + sum.toString( 16 ).toUpperCase() ) ; // Adler32 : 300286872 0x11E60398
     *         }
     *     }
     * }
     * </pre>     */    public final class Adler32 
    {
        /**
         * Generates the checksum of the specified ByteArray with the Adler32 algorithm.
         * 
         * @param buffer the buffer ByteArray object which contains the datas.
         * @param index The index to begin the buffering (default 0).
         * @param length The length value to limit the buffering (if this value is 0, the length of the ByteArray is used).
         */
        public static function checkSum( buffer:ByteArray , index:uint = 0 , length:uint = 0 ):uint 
        {
            if (index >= buffer.length ) 
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
            var l:int ;
            var i:int = index ;
            var a:int = 1 ;
            var b:int = 0 ;
            while ( length ) 
            {
                l    = ( length  > NMAX ) ? NMAX : length ;
                length -= l;
                do 
                {
                    a += buffer[i++] ;
                    b += a ;
                } 
                while ( --l ) ;
                a = (a & 0xFFFF) + (a >> 16) * 15 ;
                b = (b & 0xFFFF) + (b >> 16) * 15 ;
            }
            if (a >= BASE) 
            { 
                a -= BASE ; 
            }
            b = (b & 0xFFFF) + (b >> 16) * 15;
            if (b >= BASE) 
            { 
                b -= BASE ; 
            }
            return (b << 16) | a;
        }
        
        /**
         * The largest prime smaller than 65536.
         */
        private static const BASE:int = 65521 ; 
        
        /**
         * NMAX is the largest n such that 255n(n+1)/2 + (n+1)(BASE-1) <= 2^32-1
         */
        private static const NMAX:int = 5552 ;
    }}