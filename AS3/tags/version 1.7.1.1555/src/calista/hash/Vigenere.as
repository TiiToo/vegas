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
     * The Vigenère cipher is a method of encrypting alphabetic text by using a series of different Caesar ciphers based on the letters of a keyword.
     * It is a simple form of polyalphabetic substitution.
     * <p>See the wikipedia article about it : <a href="http://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher">Vigenère cipher</a></p>
     * <pre class="prettyprint">
     * import calista.hash.Vigenere ;
     * trace( Vigenere.encrypt( "hello world" , calista" ) ; // jewtg potlo
     * trace( Vigenere.decrypt( "jewtg potlo" , calista" ) ; // hello world
     * </pre>
     */
    public class Vigenere 
    {
        /**
         * Creates a new Vigenere instance.
         */
        public function Vigenere()
        {
            //
        }
        
        /**
         * Use Vigenère algorithm to decrypt the specified cipher text.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.hash.Vigenere ;
         * var vigenere:Vigenere = new Vigenere() ;
         * trace( vigenere.decrypt( "jewtg potlo" , calista" ) ; // hello world
         * </pre>
         * @param cipher String to be decrypted.
         * @param key The key used to decrypt.
         * @return The decrypted text.
         */
        public function decrypt( cipher:String , key:String ):String
        {
            return vigenere( cipher , key , false ) ;
        }
        
        /**
         * Use Vigenère algorithm to decrypt the specified cipher text.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.hash.Vigenere ;
         * trace( Vigenere.decrypt( "jewtg potlo" , calista" ) ; // hello world
         * </pre>
         * @param cipher String to be decrypted.
         * @param key The key used to decrypt.
         * @return The decrypted text.
         */
        public static function decrypt( cipher:String , key:String ):String
        {
            return singleton.vigenere( cipher , key , false ) ;
        }
        
        /**
         * Use Vigenère algorithm to encrypt the specified source text.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.hash.Vigenere ;
         * var vigenere:Vigenere = new Vigenere() ;
         * trace( vigenere.encrypt( "hello world" , calista" ) ; // jewtg potlo
         * </pre>
         * @param source String to be encrypted.
         * @param key The key used to encrypt.
         * @return The encrypted text.
         */
        public function encrypt( source:String , key:String ):String
        {
            return vigenere( source , key , true ) ;
        }
        
        /**
         * Use Vigenère algorithm to encrypt the specified source text.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import calista.hash.Vigenere ;
         * trace( Vigenere.encrypt( "hello world" , calista" ) ; // jewtg potlo
         * </pre>
         * @param source String to be encrypted.
         * @param key The key used to encrypt.
         * @return The encrypted text.
         */
        public static function encrypt( source:String , key:String ):String
        {
            return singleton.vigenere( source , key , true ) ;
        }
        
        /**
         * @private
         */
        internal var alphabet:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" ;
        
        /**
         * The Vigenere singleton reference.
         */
        internal static const singleton:Vigenere = new Vigenere() ;
        
        /**
         * @private
         */
        internal function vigenere( input:String , key:String , forward:Boolean ):String
        {
            if (key == null)
            {
                key = "" ;
            }
            key = key.toUpperCase() ;
            var len:int = key.length ;
            var i:int ;
            var k:int ;
            var adjustedKey:String = "";
            for (i = 0 ; i < len; i ++)
            {
                k = alphabet.indexOf( key.charAt(i) ) ;
                if ( k < 0 )
                {
                    continue ;
                }
                adjustedKey += alphabet.charAt( k ) ;
            }
            key = adjustedKey;
            len = key . length;
            if (len == 0) // the key not must be null or empty
            {
                key = "a" ;
                len = 1   ;
            }
            var output:String = "";
            var inputLen:int = input.length ;
            var keyIndex:int  = 0;
            var inTag:Boolean ;
            for (i = 0; i < inputLen; i ++)
            {
                var input_char:String = input.charAt(i);
                if (input_char == "<")
                {
                    inTag = true;
                }
                else if (input_char == ">")
                {
                    inTag = false;
                }
                if (inTag)
                {
                    output += input_char;
                    continue;
                }
                var input_char_value:int = alphabet.indexOf( input_char ) ;
                if (input_char_value < 0)
                {
                    output += input_char;
                    continue;
                }
                var lowercase:Boolean = input_char_value >= 26 ;
                if (forward)
                {
                    input_char_value += alphabet . indexOf (key . charAt (keyIndex));
                }
                else
                {
                    input_char_value -= alphabet . indexOf (key . charAt (keyIndex));
                }
                input_char_value += 26;
                if (lowercase)
                {
                    input_char_value = input_char_value % 26 + 26 ;
                }
                else
                {
                    input_char_value %= 26 ;
                }
                output += alphabet . charAt (input_char_value);
                keyIndex = (keyIndex + 1) % len;
            }
            return output;
        }
    }
}
