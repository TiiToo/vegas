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
{
    /**
     * SHA-1 is one of the most secure hash algorithms. 
     * A hash is not ‘encryption’ – it cannot be decrypted back to the original text (it is a ‘one-way’ cryptographic function, and is a fixed size for any size of source text).
     * This makes it suitable when it is appropriate to compare ‘hashed’ versions of texts, as opposed to decrypting the text to obtain the original version. Such applications include stored passwords, challenge handshake authentication, and digital signatures.
     * Read the good definition of this algorithm in Wikipedia : http://en.wikipedia.org/wiki/SHA-1
     * This implementation is a ActionScript version of the SHA-1 Cryptographic Hash Algorithm find in the web site : http://www.movable-type.co.uk/
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import calista.hash.SHA1 ;
     * 
     * var hash:String = SHA1.encrypt("hello world") ;
     * var equal:Boolean = hash == '2aae6c35c94fcfb415dbe95f408b9ce91ee846ed' ;
     * 
     * trace("'hello world' SHA1 result : " + hash + " : " + equal ) ;
     * 
     * // 'hello world' SHA1 result : 2aae6c35c94fcfb415dbe95f408b9ce91ee846ed : true
     * 
     * </pre>
     * <p>Original Javascript implementation :</p>
     * <p>Chris Veness, Movable Type Ltd: www.movable-type.co.uk</p>
     * <p>Algorithm: David Wheeler & Roger Needham, Cambridge University Computer Lab</p>
     * <p>See <a href="http://www.movable-type.co.uk/scripts/sha1.html">SHA-1 cryptographic hash function</a></p>
     */
    public class SHA1 
    {
        /**
         * Encrypt the specified text with the SHA-1 algorithm.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.hash.SHA1 ;
         * 
         * var hash:String = SHA1.encrypt("hello world") ;
         * var equal:Boolean = hash == '2aae6c35c94fcfb415dbe95f408b9ce91ee846ed' ;
         * 
         * trace("'hello world' SHA1 result : " + hash + " : " + equal ) ;
         * </pre>
         */
        public static function encrypt( source:String ):String
        {
        
            var i:int ;
            var j:int ;
            var t:int ;
            
            var K:Array = [ 0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6 ];
            
            // PREPROCESSING 
             
            source += String.fromCharCode(0x80) ; 
            
            var length:int = source.length ;
            
            // convert string message into 512-bit/16-integer blocks arrays of ints.
            
            var l:int    = Math.ceil(length/4) + 2;  // long enough to contain message plus 2-word length
            var N:int    = Math.ceil(l/16);          // in N 16-int blocks
            var M:Array  = new Array(N) ;
            for (i=0; i<N; i++) 
            {
                M[i] = new Array(16) ;
                for (j=0; j<16; j++) // encode 4 chars per integer, big-endian encoding 
                {  
                    M[i][j] = (source.charCodeAt(i*64+j*4)<<24) | (source.charCodeAt(i*64+j*4+1)<<16) | (source.charCodeAt(i*64+j*4+2)<<8) | (source.charCodeAt(i*64+j*4+3));
                }
            }
            
            // add length (in bits) into final pair of 32-bit integers (big-endian)
            // note: most significant word would be ((len-1)*8 >>> 32, but since JS converts
            // bitwise-op args to 32 bits, we need to simulate this by arithmetic operators
            
            M[N-1][14] = ((length-1)*8) / Math.pow(2, 32); M[N-1][14] = Math.floor(M[N-1][14]) ;
            M[N-1][15] = ((length-1)*8) & 0xffffffff;
            
            // set initial hash value
            
            var H0:int = 0x67452301;
            var H1:int = 0xefcdab89;
            var H2:int = 0x98badcfe;
            var H3:int = 0x10325476;
            var H4:int = 0xc3d2e1f0;
            
            // hash computation
            
            var W:Array = new Array(80) ; 
            
            var a:int ;
            var b:int ;
            var c:int ;
            var d:int ;
            var e:int ;
            
            for ( i=0 ; i<N ; i++ ) 
            {
                // 1 - prepare message schedule 'W'
                
                for (t=0;  t<16; t++) 
                {
                    W[t] = M[i][t];
                }
                
                for (t=16; t<80; t++) 
                {
                    W[t] = ROTL(W[t-3] ^ W[t-8] ^ W[t-14] ^ W[t-16], 1);
                }
                
                // 2 - initialise five working variables a, b, c, d, e with previous hash value
                
                a = H0 ; 
                b = H1 ; 
                c = H2 ; 
                d = H3 ; 
                e = H4 ;
                
                // 3 - main loop
                
                var s:Number ;
                var T:Number ;
                
                for ( t=0 ; t<80 ; t++ ) 
                {
                    s = Math.floor( t/20 ) ; // seq for blocks of 'f' functions and 'K' constants
                    T = (ROTL(a,5) + f( s , b , c , d ) + e + K[s] + W[t]) & 0xFFFFFFFF ;
                    e = d ;
                    d = c ;
                    c = ROTL(b, 30) ;
                    b = a ;
                    a = T ;
                }
                
                // 4 - compute the new intermediate hash value
                
                H0 = (H0+a) & 0xFFFFFFFF ;  // note 'addition modulo 2^32'
                H1 = (H1+b) & 0xFFFFFFFF ; 
                H2 = (H2+c) & 0xFFFFFFFF ; 
                H3 = (H3+d) & 0xFFFFFFFF ; 
                H4 = (H4+e) & 0xFFFFFFFF ;
            }
            return toHexStr(H0) + toHexStr(H1) + toHexStr(H2) + toHexStr(H3) + toHexStr(H4) ;
        }
        
        /**
         * Returns a specific value if s is 0, 1, 2 or 3.
         * @return a specific value if s is 0, 1, 2 or 3.
         */
        private static function f( s:Number, x:Number, y:Number, z:Number ):Number 
        {
            switch (s) 
            {
                case 0  : return (x & y) ^ (~x & z);           // Ch()
                case 1  : return x ^ y ^ z;                    // Parity()
                case 2  : return (x & y) ^ (x & z) ^ (y & z);  // Maj()
                case 3  : return x ^ y ^ z;                    // Parity()
            }
            return NaN ;
        }
        
        /**
         * Rotate left (circular left shift) value x by n positions.
         */
        private static function ROTL( x:Number , n:Number ):Number
        {
            return ( x<<n ) | ( x >>> (32-n) );
        }
        
        /**
         * Returns the tailored hex-string string representation of the passed-in number value.
         * @return the tailored hex-string string representation of the passed-in number value.
         */
        private static function toHexStr( n:Number ):String
        {
            var s:String = "" ;
            var v:int ;
            for ( var i:int=7 ; i>=0 ; i-- ) 
            { 
                v = ( n >>> (i*4) ) & 0xF ;
                s += v.toString(16); 
            }
            return s;
        }
    }
}
