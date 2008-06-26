﻿/*

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
package andromeda.ioc.io 
{
    import andromeda.process.ActionURLLoader;
    import andromeda.vo.SimpleValueObject;
    
    import system.Reflection;    

    /**
     * Convenience base class for resource implementations in the IoC factory loader.
     */
    public class ObjectResource extends SimpleValueObject 
    {
    	
        /**
         * Creates a new ObjectResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function ObjectResource( init:Object=null )
        {
            super(init) ;
        }
    	        
        /**
         * The description of this resource.
         */
        public var description:String ;
    	
    	/**
    	 * The resource value.
    	 */
    	public var resource:String ;
    	
        /**
         * The title of this resource.
         */
        public var title:String ;         	
    	
        /**
         * The type of this resource.
         */
        public function get type():String
        {
            return id as String ;
        }
    
        /**
         * @private
         */
        public function set type( value:String ):void
        {
            id = value ;
        }
        
        /**
         * Creates a new ActionURLLoader object with the resource.
         * Overrides this method.
         */
        public function create():ActionURLLoader
        {
        	return null ;
        }
                
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " id:" + this.id ;
            }
            if ( this.resource != null )
            {
                str += " resource:" + this.resource ;
            }                         
            str += "]" ;
            return str ;
        }    	
    	
    }
}
