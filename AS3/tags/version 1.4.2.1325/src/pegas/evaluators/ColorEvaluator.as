/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com>  
*/

package pegas.evaluators 
{
    import system.evaluators.Evaluable;
    import system.hack;

    /**
     * Evaluates a rgb color string expression.
     * <p>All characters from 'A' to 'F' and from '0' to '9' are reserved, although not all of these characters are interpreted right now.</p> 
     * <pre class="prettyprint">
     * import pegas.evaluators.ColorEvaluator ;
     * 
     * var evaluator:ColorEvaluator = new ColorEvaluator() ;
     * 
     * trace( evaluator.eval( "#FF0000" ) ) // good pattern for red color: 16711680
     * 
     * trace( evaluator.eval( "0xFFFFFF" ) ) ; // good pattern for white color: 16777215
     * 
     * trace( evaluator.eval( "AAAAAG" ) ) ; // bad pattern, {G} char not good: 0
     * 
     * trace( evaluator.eval( "AAAAAAA" ) ) ; // bad pattern, it must had 6 chars: 0
     * </pre>
     */
    public class ColorEvaluator implements Evaluable 
    {
        use namespace hack ;
        
        /**
         * Creates a ColorEvaluator instance.
         */
        public function ColorEvaluator():void
        {
            //
        }
        
        /**
         * Evaluates the specified object.
         * @param value The object to evaluate.
         * @return the Number value of the color expression. 
         */
        public function eval( o:* ):*
        {
            if( o != null && o is String )
            {
                var s:String = ( o as String ).replace( filter , "" ) ;
                var l:int    = s.length ;
                if( l > 0 && l < 7 )
                {
                    var c:String ;
                    for( var i:int ; i < l ; i++ )
                    {
                        c = s.charAt( i ) ;
                        if( !( (("0" <= c) && (c <= "9")) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f")) ) )
                        {
                            return 0 ;
                        }
                    }
                    return parseInt ( o.substr ( -6 , 6 ) , 16 ) ;
                }
            }
            return 0 ;
        }
        
        /**
         * Defines the regex for the eval method.
         * <p>Example:</p>
         * <pre class="prettyprint">
         * // The complete regex to test the color string valid, but it is slowly than the eval method.
         * /^#|0x([0-9A-F]{1,2}){1,3}$/i
         * </pre>
         */
        hack const filter:RegExp = /#|0x/g ;
    }
}
