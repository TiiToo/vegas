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
     * XOR Encryption is a popular encryption algorithm that is used in many browsers and it is blatantly simpleand fairly secure. 
     * The XOR Encryption algorithm is an example of a Symmetric Encryption algorithm. 
     * This means that the same key is used for both encryption and decryption. 
     * In the case of XOR Encryption, this is true because XOR is a two-way function which means that the function can easily be undone. 
     * In the following paper the standard XOR Encryption algorithm will be introduced along with a modification. The modification comes in the form of creating random permutations of the key.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import calista.hash.RXOR ;
     * 
     * var rxor:RXOR = new RXOR() ;
     * 
     * var cipher:String ;
     * var source:String ;
     * 
     * cipher = rxor.encrypt( "hello world" , 0x1234 ) ;
     * trace( cipher ) ; // ቜ⌤㑾䅏ቛ⍡㑥䅌ቆ⌭㑶
     * 
     * source = rxor.encrypt( cipher , 0x1234 ) ;
     * trace( source ) ; // hello world
     * </pre>
     * <p>See more information about XOR encryption : <a href="http://www.acm.org/crossroads/xrds11-3/xorencrypt.html" target="_blank">http://www.acm.org/crossroads/xrds11-3/xorencrypt.html</a></p>
     */
    public class RXOR
    {
        /**
         * Creates a new RXOR instance.
         */
        public function RXOR()
        {
            //
        }
        
        /**
         * Encrypt the specified text with the passed-in key.
         * Note : we force the key to be 16bit (0xffff) so the hex can be converted to unicode
         * @param source The source to encrypt.
         * @param key The key used to encrypt.
         */
        public function encrypt( source:String, key:uint = 0x1234 ):String
        {
            key = key & 0xFFFF ;
            var i:uint;
            var c:Array = source.split( "" ) ;
            var l:int   = c.length ;
            for( i=0; i<l ; i++ )
            {
                c[i]  = c[i].charCodeAt( 0 ) ; // we replace each letter index by their charcode
                c[i] ^= key ; // we XOR with the key each index
                c[i]  = String.fromCharCode( c[i] ) ; // we get a new letter from the new charcode
                key     = rotbit( key ) ; // we rotate the bits of the key for the next round
            }
             return c.join( "" ) ;
        }
        
        /**
         * Encrypt the specified text with the passed-in key.
         * Note : we force the key to be 16bit (0xffff) so the hex can be converted to unicode
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.hash.RXOR ;
         * 
         * var cipher:String ;
         * var source:String ;
         * 
         * cipher = RXOR.encrypt( "hello world" , 0x1234 ) ;
         * trace( cipher ) ; // ቜ⌤㑾䅏ቛ⍡㑥䅌ቆ⌭㑶
         * 
         * source = RXOR.encrypt( cipher , 0x1234 ) ;
         * trace( source ) ; // hello world
         * </pre> 
         * @param source The source to encrypt.
         * @param key The key used to encrypt.
         */
        public static function encrypt( source:String, key:uint = 0x1234 ):String
        {
            return singleton.encrypt( source , key ) ;
        }
        
        /**
         * @private
         */
        internal static const singleton:RXOR = new RXOR() ;
        
        /**
         * Rotates the bits of the key by block of 4bits (eg. 0xF). 
         * for ex: if your input is 0x1234 it returns 0x2341
         * @return the rotated bits
         */
        internal function rotbit( key:uint ):uint
        {
            var b:uint;
            var l:uint = key.toString( 16 ).length ;
            /* note:
               we define a positive and a negative mask
               
               if key lengh is 4 (0x1234)
               
               positive mask is 0xf000
               negative mask is 0x0fff
            */
            var pos:uint = 0xf << (4*(l-1));
            var neg:uint = ~pos;
            /* note: 
               here we do a left bit rotation
               we take the leftmost bit and
               put it in front of the rightmost bit
            */
            b = (key & pos) >>> (4*(l-1)) ; //save the bit on the left
            key = ((key & neg) << 4) | b ; //and move it on the right
            return key;
        }
    }
}

