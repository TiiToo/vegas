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
{
    /**
     * A cryptographic hash (sometimes called ‘digest’) is a kind of ‘signature’ for a text or a data file. 
     * SHA-256 generates an almost-unique 256-bit (32-byte) signature for a text.
     * <p>Original Javascript implementation :</p>
     * <p>Chris Veness, Movable Type Ltd: www.movable-type.co.uk</p>
     * <p>See <a href="http://www.movable-type.co.uk/scripts/sha256.html">http://www.movable-type.co.uk/scripts/sha256.html</a></p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import calista.hash.SHA256 ;
     * 
     * var hash:String = SHA256.encrypt("calista") ;
     * var equal:Boolean = hash == 'c37a4150a942afb4b36dd5c85ac744a16de0891c99d418ae7b5ef528dfcf2e9d' ;
     * 
     * trace("'hello world' SHA1 result : " + hash + " : " + equal ) ;
     * </pre>
     */
    public class SHA256 
    {
        /**
         * Encrypt the specified text with the SHA-256 algorithm.
         */
        public static function encrypt( source:String ):String 
        {
            // PREPROCESSING
            
            source += String.fromCharCode(0x80);  // add trailing '1' bit (+ 0's padding) to string [§5.1.1]
            
            // convert string msg into 512-bit/16-integer blocks arrays of ints [§5.2.1]
            
            var l:int   = source.length / 4 + 2;  // length (in 32-bit integers) of msg + ‘1’ + appended length
            var N:int   = Math.ceil(l / 16);   // number of 16-integer-blocks required to hold 'l' ints
            var M:Array = new Array(N);
            
            var i:int ;
            var j:int ;
            var t:int ;
            
            for (i = 0;i < N;i++) 
            {
                M[i] = new Array(16) ;
                for ( j = 0 ; j < 16 ; j++ ) 
                {  
                    // encode 4 chars per integer, big-endian encoding
                    M[i][j] = ( source.charCodeAt(i * 64 + j * 4) << 24) | ( source.charCodeAt(i * 64 + j * 4 + 1) << 16) | ( source.charCodeAt(i * 64 + j * 4 + 2) << 8) | ( source.charCodeAt(i * 64 + j * 4 + 3));
                } // note running off the end of msg is ok 'cos bitwise ops on NaN return 0
            }
            // add length (in bits) into final pair of 32-bit integers (big-endian) [§5.1.1]
            // note: most significant word would be (len-1)*8 >>> 32, but since JS converts
            // bitwise-op args to 32 bits, we need to simulate this by arithmetic operators
            M[N - 1][14] = ((source.length - 1) * 8) / Math.pow(2, 32) ; 
            M[N - 1][14] = Math.floor(M[N - 1][14]) ;
            M[N - 1][15] = ((source.length - 1) * 8) & 0xffffffff ;
            
            // HASH COMPUTATION [§6.1.2]
            
            var W:Array = new Array(64); 
            var a:int, b:int, c:int, d:int, e:int, f:int, g:int, h:int;
            
            for (i = 0;i < N;i++) 
            {
                // 1 - prepare message schedule 'W'
                
                for ( t = 0 ; t < 16 ; t++ ) 
                {
                    W[t] = M[i][t];
                }
                for ( t = 16 ;t < 64 ;t++ ) 
                {
                    W[t] = ( sigma1(W[t - 2]) + W[t - 7] + sigma0(W[t - 15]) + W[t - 16] ) & 0xffffffff ;
                }
                
                // 2 - initialise five working variables a, b, c, d, e with previous hash value
                
                a = H[0]; 
                b = H[1]; 
                c = H[2]; 
                d = H[3]; 
                e = H[4]; 
                f = H[5]; 
                g = H[6]; 
                h = H[7];
                
                // 3 - main loop (note 'addition modulo 2^32')
                
                var T1:int ;
                var T2:int ;
                
                for (t = 0;t < 64;t++) 
                {
                    T1 = h + Sigma1(e) + Ch(e, f, g) + K[t] + W[t];
                    T2 = Sigma0(a) + Maj(a, b, c);
                    h = g;
                    g = f;
                    f = e;
                    e = (d + T1) & 0xffffffff;
                    d = c;
                    c = b;
                    b = a;
                    a = (T1 + T2) & 0xffffffff;
                }
                
                // 4 - computes the new intermediate hash value (note 'addition modulo 2^32')
                
                H[0] = (H[0] + a) & 0xffffffff ;
                H[1] = (H[1] + b) & 0xffffffff ; 
                H[2] = (H[2] + c) & 0xffffffff ; 
                H[3] = (H[3] + d) & 0xffffffff ; 
                H[4] = (H[4] + e) & 0xffffffff ;
                H[5] = (H[5] + f) & 0xffffffff ;
                H[6] = (H[6] + g) & 0xffffffff ; 
                H[7] = (H[7] + h) & 0xffffffff ; 
            }
            return toHexStr(H[0]) + toHexStr(H[1]) + toHexStr(H[2]) + toHexStr(H[3]) + toHexStr(H[4]) + toHexStr(H[5]) + toHexStr(H[6]) + toHexStr(H[7]) ;
        }
        
        /**
         * Initial hash value [§5.3.1]
         */
        private static var H:Array = [0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19];
        
        /**
         * constants [§4.2.2]
         */
        private static var K:Array = 
        [
            0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
            0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
            0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
            0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
            0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
            0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
            0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
            0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
        ] ;
        
        private static function Ch(x:int, y:int, z:int):int 
        { 
            return (x & y) ^ (~x & z) ; 
        }
        
        private static function Maj(x:int, y:int, z:int):int
        { 
            return (x & y) ^ (x & z) ^ (y & z); 
        }
        
        /**
         * Rotate right (circular right shift) value x by n positions.
         */
        private static function ROTR(n:Number, x:Number):Number
        {
            return (x >>> n) | (x << (32 - n)); 
        }
        
        /**
         * @private
         */
        private static function Sigma0(x:int):int
        { 
            return ROTR(2, x) ^ ROTR(13, x) ^ ROTR(22, x); 
        }
        
        /**
         * @private
         */
        private static function Sigma1(x:int):int
        { 
            return ROTR(6, x) ^ ROTR(11, x) ^ ROTR(25, x) ; 
        }
        
        /**
         * @private
         */
        private static function sigma0(x:int):int
        { 
            return ROTR(7, x) ^ ROTR(18, x) ^ (x >>> 3) ;  
        }
        
        /**
         * @private
         */
        private static function sigma1(x:int):int
        { 
            return ROTR(17, x) ^ ROTR(19, x) ^ (x >>> 10) ; 
        }
        
        /**
         * Returns the tailored hex-string string representation of the passed-in number value.
         * @return the tailored hex-string string representation of the passed-in number value.
         */
        private static function toHexStr( n:Number ):String
        {
            var s:String = "" ;
            var v:int ;
            for ( var i:int = 7 ; i >= 0 ; i-- ) 
            { 
                v = ( n >>> (i * 4) ) & 0xF ;
                s += v.toString(16); 
            }
            return s;
        }
    }
}
