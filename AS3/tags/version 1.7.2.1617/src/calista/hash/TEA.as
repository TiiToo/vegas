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
    import calista.utils.Base64;
    
    /**
     * Wheeler & Needham’s Tiny Encryption Algorithm is a simple but powerful encryption algorithm (based on a ‘Feistel cipher’).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import calista.hash.TEA ;
     * 
     * var source:String = "hello world is secret" ;
     * var password:String = "calista" ;
     * 
     * var encrypt:String = TEA.encrypt( source , password ) ;
     * trace("encrypt : " + encrypt) ;
     * 
     * var decrypt:String = TEA.decrypt(encrypt , password) ;
     * trace("decrypt : " + decrypt) ;
     * </pre>
     * <p><b>Original implementation :</b></p>
     * <p>Chris Veness, Movable Type Ltd: www.movable-type.co.uk</p>
     * <p>Algorithm: David Wheeler & Roger Needham, Cambridge University Computer Lab</p>
     * See <a href="http://www.movable-type.co.uk/scripts/tea-block.html">Tiny Encryption Algorithm</a>
     * @see calista.utils.Base64
     * @since FlashPlayer 10 & > (use the Vector class)
     */
    public class TEA 
    {
        /**
         * Uses corrected Block TEA to encrypt a string value using key.
         * @param source The source to encrypt.
         * @param key The password key to encrypt the source (1st 16 chars).
         * @return The encrypted text as string.
         */
        public static function encrypt( source:String , key:String ):String
        {
            if( !source || source.length == 0 ) 
            {
                return "" ;
            }
            var v:Array = stringToLongs( source ) ;
            if (v.length <= 1) 
            {
                v[1] = 0 ;  // algorithm doesn't work for n<2 so fudge by adding a null
            }
            
            var k:Array = stringToLongs( key.slice( 0 , 16 ) ) ;
            var n:int   = v.length;
            
            ////////// TEA
            
            var mx:int ;
            var e:int ;
            var p:int ;
            
            var z:int     = v[n-1] ;
            var y:int     = v[0] ;
            var q:int     = Math.floor(6 + 52/n) ; // 6 + 52/n operations gives between 6 & 32 mixes on each word
            var delta:int = 0x9E3779B9 ;
            var sum:int   = 0;
            
            while (q-- > 0) 
            {  
                sum += delta;
                e = sum>>>2 & 3;
                for ( p = 0 ; p < n ; p++ ) 
                {
                    y = v[ (p+1)%n ];
                    mx = ( z >>> 5 ^ y << 2 ) + ( y >>> 3 ^ z << 4) ^ ( sum ^ y) + ( k[ p & 3 ^ e ] ^ z ) ;
                    z = v[p] += mx;
                }
            }
            
            //////////
            
            return Base64.encode( longsToString( v ) ) ;
        }
        
        /**
         * Use Corrected Block TEA to decrypt ciphertext using key.
         * @param cipher String to be decrypted.
         * @param key The password to be used for decryption (1st 16 chars).
         * @return The decrypted text
         */
        public static function decrypt( cipher:String , key:String ):String
        {
            if ( !cipher || cipher.length == 0) 
            {
                return "" ;
            }
            
            var v:Array = stringToLongs( Base64.decode( cipher ) ) ;
            var k:Array = stringToLongs( key.slice(0,16) ); 
            var n:int   = v.length ;
            
            ////////// TEA
            
            var mx:int ;
            var p:int ;
            var e:int ;
            
            var z:int     = v[n-1] ;
            var y:int     = v[0] ;
            var delta:int = 0x9E3779B9 ;
            var q:int     = Math.floor(6 + 52/n) ;
            var sum:int   = q*delta;
            
            while (sum != 0) 
            {
                e = sum >>> 2 & 3 ;
                for ( p = n-1 ; p >= 0 ; p--) 
                {
                    z = v[ ( p > 0 ) ? p - 1 : n - 1 ] ;
                    mx = (z>>>5 ^ y<<2) + (y>>>3 ^ z<<4) ^ (sum^y) + (k[p&3 ^ e] ^ z);
                    y = v[p] -= mx ;
                }
                sum -= delta;
            }
            
            //////////
            
            var source:String = longsToString( v ) ;
            source = source.replace( /\0+$/ , "" ) ; // strip trailing null chars resulting from filling 4-char blocks
            return source ;
        }
        
        /**
         * Convert the specified Array of longs to a String.
         */
        private static function longsToString( longs:Array ):String
        {
            var i:int ;
            var l:int   = longs.length ; 
            var a:Array = new Array( l );
            for ( i = 0; i < l ; i++) 
            {
                a[i] = String.fromCharCode( longs[i] & 0xFF , longs[i]>>>8 & 0xFF , longs[i] >>> 16 & 0xFF, longs[i] >>> 24 & 0xFF ) ;
            }
            return a.join('') ;
        }
        
        /**
         * Convert the specified String to an Array of longs, each containing 4 chars.
         * Note: chars must be within ISO-8859-1 (with Unicode code-point < 256) to fit 4/long.
         */
        private static function stringToLongs( s:String ):Array 
        {  
            var i:int ;
            var l:int = Math.ceil( s.length / 4 ) ;
            var longs:Array = new Array( l ) ;
            for ( i = 0 ; i < l ; i++ ) 
            {
                longs[i] = s.charCodeAt(i*4) + (s.charCodeAt(i*4+1)<<8) + (s.charCodeAt(i*4+2)<<16) + (s.charCodeAt(i*4+3)<<24);
            }
            return longs ;
        }
    }
}
