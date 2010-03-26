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

package vegas.ioc 
{
    /**
     * This object defines an argument definition in an object definition.
     */
    public class ObjectArgument
    {
        /**
         * Creates a new ObjectArgument instance.
         * @param value The value of the argument.
         * @param policy The policy of the property ( ObjectAttribute.REFERENCE or by default ObjectAttribute.VALUE )
         * @param evaluators The Array representation of all evaluators who evaluate the value of the argument.
         */
        public function ObjectArgument( value:* , policy:String="value" , evaluators:Array = null )
        {
            this.policy     = policy ;
            this.value      = value ;
            this.evaluators = evaluators ;
        }
        
        /**
         * The Array representation of all evaluators to transform the value of this object.
         */
        public var evaluators:Array ;
        
        /**
         * The policy of the property
         */
        public function get policy():String
        {
            return _policy ;
        }
        
        /**
         * @private
         */
        public function set policy( str:String ):void
        {
            switch (str)
            {
                case ObjectAttribute.REFERENCE :
                case ObjectAttribute.CONFIG    :
                case ObjectAttribute.LOCALE    :
                {
                    _policy = str ;
                    break ;
                }
                default :
                {
                  _policy = ObjectAttribute.VALUE ;
                }
            }
        }
        
        /**
         * The value of the property.
         */
        public var value:* ;
        
        /**
         * Creates the Array definition of all arguments defines in the passed-in array.
         * @return the Array definition of all arguments defines in the passed-in array.
         */
        public static function create( a:Array = null ):Array
        {
            if ( a == null || a.length == 0 )
            {
                return null ;
            }
            else
            {
                var o:Object ;
                var i:int ;
                var evaluators:Array ;
                var conf:String ;
                var i18n:String ;
                var ref:String  ;
                var value:* ;
                var args:Array  = [] ;
                var l:int = a.length ;
                for ( i ; i<l ; i++ )
                {
                    o = a[i] ;
                    if ( o != null )
                    {
                        conf       = ( ObjectAttribute.CONFIG in o )     ? o[ ObjectAttribute.CONFIG ] as String    : null ;
                        i18n       = ( ObjectAttribute.LOCALE in o )     ? o[ ObjectAttribute.LOCALE ] as String    : null ;
                        ref        = ( ObjectAttribute.REFERENCE in o )  ? o[ ObjectAttribute.REFERENCE ] as String : null ;
                        value      = ( ObjectAttribute.VALUE in o )      ? o[ ObjectAttribute.VALUE ]               : null ;
                        evaluators = ( ObjectAttribute.EVALUATORS in o ) ? o[ObjectAttribute.EVALUATORS] as Array   : null ;
                        
                        if ( ref != null && ref.length > 0 ) 
                        {
                            args.push( new ObjectArgument( ref , ObjectAttribute.REFERENCE , evaluators ) ) ; // ref argument
                        }
                        else if ( conf != null && conf.length > 0 )
                        {
                            args.push( new ObjectArgument( conf , ObjectAttribute.CONFIG , evaluators ) ) ; // config argument
                        }
                        else if ( i18n != null && i18n.length > 0 )
                        {
                               args.push( new ObjectArgument( i18n , ObjectAttribute.LOCALE , evaluators ) ) ; // locale argument
                        }
                        else
                        {
                            args.push( new ObjectArgument( value , ObjectAttribute.VALUE , evaluators ) ) ; // value argument
                        }
                    }
                }
                return args.length > 0 ? args : null ;
            }
        }
        
        /**
         * @private
         */
        private var _policy:String ;
    }
}
