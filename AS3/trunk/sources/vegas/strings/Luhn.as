﻿/*

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

package vegas.strings
{
    /**
     * It is a simple checksum formula used to validate a variety of account numbers, such as credit card numbers, etc.
     * <p>The Luhn algorithm or Luhn formula, also known as the "modulus 10" or "mod 10" algorithm, was developed in the 1960s as a method of validating identification numbers.</p>
     * <p><b>example</b></p>
     * <p>See <a href='http://fr.wikipedia.org/wiki/Formule_de_Luhn'>Luhn Formula</a></p> 
     * <pre class="prettyprint">
     * import vegas.strings.Luhn ;
     * 
     * var code:String = "456565654" ;
     * trace (code + " isValid : " + Luhn.isValid(code)) ;
     * </pre>
     */
    public class Luhn
    {
        /**
         * Returns <code class="prettyprint">true</code> if the expression in argument is a valid Luhn value.
         * @return <code class="prettyprint">true</code> if the expression in argument is a valid Luhn value.
         */
        public static function isValid(str:String):Boolean 
        {    
            var n:Number ;
            var sum:uint = 0 ;
            var l:int = str.length ;
            for ( var i:int ; i<l ; i++ )
            {
                n = Number(str.charAt(i)) * ( i%2 == 1 ? 2 : 1) ;
                sum += n - ((n > 9) ? 9 : 0) ;
            }
            return sum%10 == 0 ;
        }
    }
}