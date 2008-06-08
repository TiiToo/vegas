/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{

    /**
     * This object defines an argument definition in an object definition.
     * @author eKameleon
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
            this.policy     = ( policy == ObjectAttribute.REFERENCE ) ? ObjectAttribute.REFERENCE : ObjectAttribute.VALUE ;
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
        public var policy:String ;
        
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
            	var i:uint ;
                
                var evaluators:Array ;
                var ref:String  ;
                var value:* ;
                                
                var args:Array  = [] ;
                var l:uint   = a.length ;
                for ( i=0 ; i<l ; i++ )
                {
                	o = a[i] ;
                	if ( o != null )
                	{
                        ref        = ( ObjectAttribute.REFERENCE in o ) ? o[ ObjectAttribute.REFERENCE ] as String : null ;
                        value      = ( ObjectAttribute.VALUE in o )     ? o[ ObjectAttribute.VALUE ]               : null ;
                        evaluators = ( ObjectAttribute.EVALUATORS in o ) ? o[ObjectAttribute.EVALUATORS] as Array  : null ;
                        
                        if ( ref != null ) 
                        {
                            args.push( new ObjectArgument( ref , ObjectAttribute.REFERENCE , evaluators ) ) ; // ref argument    
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
        
    }
}
