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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{
    import buRRRn.eden;                    

    /**
     * This object defines a listener definition in an object definition.
     * <pre class="prettyprint">
     * import andromeda.ioc.core.ObjectListener ;
     * 
     * var init:Array = 
     * [
     *     { dispatcher:"dispatcher1" , type:"change" , method:"handleEvent" } ,
     *     { dispatcher:"dispatcher2" , type:"change" , method:"handleEvent" } 
     * ] ;
     * 
     * var listeners:Array = ObjectListener.create( init ) ;
     * 
     * trace( listeners ) ; 
     * </pre>
     * @author eKameleon
     */
    public class ObjectListener
    {

        /**
         * Creates a new ObjectListener instance.
         * @param dispatcher The dispatcher expression reference of the listener.
         * @param type type name of the event dispatched by the dispatcher of this listener.
         * @param method The name of the method to invoke when the event is handle.
         */
        public function ObjectListener( dispatcher:String , type:String , method:String=null )
        {
            this.dispatcher = dispatcher ;
            this.method     = method ;
            this.type       = type ;            
        }
        
        /**
         * The dispatcher expression reference of the listener.
         */
        public var dispatcher:String ;
        
        /**
         * The name of the method to invoke when the event is handle.
         */
        public var method:String ;
        
        /**
         * The type name of the event dispatched by the dispatcher of this listener.
         */
        public var type:String ;     
        
        /**
         * Creates the Map definition of all properties defines in the passed-in array.
         * @return the Map definition of all properties defines in the passed-in array.
         */
        public static function create( a:Array = null ):Array
        {
            
            if ( a == null || a.length == 0 )
            {
                return null ;
            }
                        
            var def:Object ;
            var listeners:Array = [] ;

            var len:uint = a.length ;
            
            var dispatcher:String ;
            var type:String ;
            var method:String ;
            
            for (var i:uint = 0 ; i<len ; i++)
            {
                    
                def  = a[i] as Object ;
                
                if ( def != null && ( ObjectAttribute.DISPATCHER in def ) && ( ObjectAttribute.TYPE in def ) )
                { 
                
                	dispatcher  = def[ ObjectAttribute.DISPATCHER ] as String ;
                                    
	                if ( dispatcher == null || dispatcher.length == 0 )
    	            {
                    	continue ;
                	}
                	
                    type  = def[ ObjectAttribute.TYPE ] as String ;          	
                    
                    if ( type == null || type.length == 0 )
                    {
                        continue ;
                    }                	
                    
                    method = def[ ObjectAttribute.METHOD ] as String ;
                                        
                	listeners.push( new ObjectListener( dispatcher, type , method ) ) ;
                }
                else
                {
                	trace( "ObjectListener.create failed, a property definition is invalid at {" + i + "} with the value : " + eden.serialize(def) ) ; // FIXME logs ?	
                }			    
            }
            return ( listeners.length > 0 ) ? listeners : null ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
        	var s:String = "[ObjectListener" ;
        	if ( dispatcher )
        	{
        	   s += " dispatcher:\"" + dispatcher + "\"" ;	
        	}
        	if ( type )
            {
               s += " type:\"" + type + "\"" ;   
            }
            if ( method )
            {
               s += " method:\"" + method + "\"" ;  
            }
        	s += "]" ;
        	return s ;
        	 
        }  
                
    }
}
