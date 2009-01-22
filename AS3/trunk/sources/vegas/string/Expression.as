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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package vegas.string 
{
    import system.Strings;
    import system.formatters.Formattable;
    
    import flash.utils.Dictionary;        

    /**
     * This dictionary register formattable expression and format a String with all expression in the dictionnary. 
     * <pre class="prettyprint">
     * import vegas.string.Expression ;
     * 
     * var source:String ;
     * 
     * var exp:Expression      = new Expression() ;
     * 
     * exp["root"]              = "c:" ;
     * exp["system"]            = "{root}/project/system" ;
     * exp["data.maps"]         = "{system}/data/maps" ;
     * exp["data.maps.HashMap"] = "{data.maps}/HashMap.as" ;
     * 
     * source = "the root : {root} - the class : {data.maps.HashMap}" ;
     * 
     * trace( exp.format( source ) ) ;
     * 
     * trace( "----" ) ;
     * 
     * exp["system"]            = "%root%/project/system" ;
     * exp["data.maps"]         = "%system%/data/map" ;
     * exp["data.maps.HashMap"] = "%data.map%/HashMap.as" ;
     * 
     * exp.beginSeparator = "%" ;
     * exp.endSeparator   = "%" ;
     * 
     * source = "the root : %root% - the class : %data.maps.HashMap%" ;
     * 
     * trace( exp.format( source ) ) ;
     * </pre>
     */
    public dynamic class Expression extends Dictionary implements Formattable
    {
        
        /**
         * Creates a new Expression instance.
         * @param weakKeys Instructs the Dictionary object to use "weak" references on object keys. If the only reference to an object is in the specified Dictionary object, the key is eligible for garbage collection and is removed from the table when the object is collected. 
         */
        public function Expression( weakKeys:Boolean = false )
        {
            super( weakKeys );
            _reset() ;
        }
                
        /**
         * The max recursion value.
         */
        public static var MAX_RECURSION:uint = 200 ;
        
        /**
         * The begin separator of the expression to format (default "{").
         */
        public function get beginSeparator():String
        {
        	return _beginSeparator ;
        }
        
        /**
         * @private
         */
        public function set beginSeparator( str:String ):void
        {
            _beginSeparator = str || "{" ;
            _reset() ;            
        }        

        /**
         * The end separator of the expression to format (default "}").
         */
        public function get endSeparator():String
        {
            return _endSeparator ;	
        }        
        
        /**
         * @private
         */
        public function set endSeparator( str:String ):void
        {
            _endSeparator = str || "{" ;
            _reset() ;
        }        
        
        /**
         * Formats the specified value.
         * @param value The object to format.
         * @return the string representation of the formatted value. 
         */      
        public function format( value:* = null ):String
        {
        	return _format( value.toString() ) ;
        }        

        /**
         * @private
         */
        private var _beginSeparator:String = "{" ;

        /**
         * @private
         */
        private var _endSeparator:String = "}" ;   
        
        /**
         * @private
         */
        private var _pattern:String = "{0}((\\w+\)|(\\w+)((.\\w)+|(.\\w+))){1}" ;        
        
        /**
         * @private
         */
        private var _reg:RegExp ;
        
        /**
         * @private
         */        
        private function _format( str:String , depth:uint=0 ):String
        {
        	if ( depth >= MAX_RECURSION )
        	{
        		return str ;
        	} 
            var m:Array = str.match( _reg ) ;
            var l:int   = m.length ;
            if ( l > 0 )
            {
                var key:String ;
                for ( var i:int ; i<l ; i++ )
                {
                    key = m[i].substr(1) ;
                    key = key.substr( 0 , key.length-1 ) ;
                    if ( this[key] != null && (this[key] is String) )
                    {
                        this[key] = _format( this[key] as String , depth + 1 ) ;
                        str       = str.replace( m[i]  , this[key] ) ;
                    }
                }
            }
            return str ;
        }          
        
        /**
         * @private
         */
        private function _reset():void
        {
            _reg = new RegExp( Strings.format( _pattern , beginSeparator , endSeparator ), "g" ) ;	
        }
        
    }
}
