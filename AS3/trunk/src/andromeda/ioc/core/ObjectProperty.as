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
    import system.Reflection;
    
    import vegas.core.CoreObject;    

    /**
     * This object defines a property definition and this value in an object definition.
     * @author eKameleon
     */
    public class ObjectProperty extends CoreObject 
    {

		/**
		 * Creates a new ObjectProperty instance.
		 * @param name The name of the property.
		 * @param value The value of the property.
		 * @param type The type of the property ( ObjectAttribute.REFERENCE or by default ObjectAttribute.VALUE )
		 */
        public function ObjectProperty( name:String , value:* , type:String="value" , evaluators:Array = null )
        {
            this.name       = name ;
            this.type       = type == ObjectAttribute.REFERENCE ? ObjectAttribute.REFERENCE : ObjectAttribute.VALUE ;
            this.value      = value ;
            this.evaluators = evaluators ;
        }
        
		/**
		 * The name of the property.
		 */
		public var name:String ;
		
		/**
		 * The Array representation of all evaluators to transform the value of this object.
		 */
		public var evaluators:Array ;
		
		/**
		 * The type of the property
		 */
		public var type:String ;
		
		/**
		 * The value of the property.
		 */
		public var value:* ;     
        
		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public override function toString():String 
		{
			var s:String = "[" + Reflection.getClassName(this) ;
			if ( name != null )
			{
				s += " name:" + name ;	
			} 
			s += "]" ;
			return s ;
		}        
        
    }
}
