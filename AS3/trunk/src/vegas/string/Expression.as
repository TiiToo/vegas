/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package vegas.string 
{
    import flash.utils.Dictionary;                

    /**
     * This dictionary register formattable expression and format a String with all expression in the dictionnary. 
     * @author eKameleon
     */
    public dynamic class Expression extends Dictionary
    {
        
        /**
         * Creates a new Expression instance.
         * @param weakKeys Instructs the Dictionary object to use "weak" references on object keys. If the only reference to an object is in the specified Dictionary object, the key is eligible for garbage collection and is removed from the table when the object is collected. 
         */
        public function Expression( weakKeys:Boolean = false )
        {
            super( weakKeys );
        }
        
        /**
         * The max recursion value.
         */
        public static var MAX_RECURSION:uint = 200 ;
        
        /**
         * Formats the specified value.
         * @return the string representation of the formatted value. 
         */        
        public function format( value:* = null ):String
        {
        	return _format( value.toString() ) ;
        }        
        
        /**
         * @private
         */
        private var _r:RegExp = new RegExp("\\{\\w+((.\\w)+|(.\\w+))\\}","g") ; // regexp = /{.*}/g ;
        
        /**
         * @private
         */        
        private function _format( str:String , depth:uint=0 ):String
        {
        	if ( depth >= MAX_RECURSION )
        	{
        		return str ;
        	} 
            var m:Array  = str.match( _r ) ;
            var l:uint   = m.length ;
            if ( l > 0 )
            {
                var key   :String ;
                var value :String ;
                for ( var i:uint = 0 ; i<l ; i++ )
                {
                    key   = m[i] ;
                    key   = ( key.substr(1) ).substr( 0 , key.length-2 ) ;
                    if ( this[key] != null )
                    {
                        value     = _format( this[key] , depth + 1 ) ;
                        this[key] = value ;
                    }
                    else
                    {
                        value = m[i] ;
                    }
                    str = str.replace( m[i] , value ) ;
                }
            }
            return str ;
        }          
        
    }
}
