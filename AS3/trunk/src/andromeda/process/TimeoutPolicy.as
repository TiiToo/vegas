﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process
{
    import system.Reflection;
    
    import vegas.core.CoreObject;    

    /**
     * Defines the policy of the timeout states in the application.
     * @author eKameleon
     */
	public class TimeoutPolicy extends CoreObject
	{
		
    	/**
    	 * Creates a new TimeoutPolicy instance.
	     * @param the value of this policy object.
	     */ 
		public function TimeoutPolicy( value:uint )
		{
			_value = value ;
		}

    	/**
	     * This constant defines the 'infinity' timeout policy value(0).
	     */
		public static const INFINITY:TimeoutPolicy = new TimeoutPolicy(0) ;

	    /**
    	 * This constant defines the 'limit' timeout policy value(1).
    	 */
		public static const LIMIT:TimeoutPolicy = new TimeoutPolicy(1) ;

	    /**
    	 * Returns the eden string representation of this object.
    	 * @return the eden string representation of this object.
    	 */		
		public override function toSource( indent:int = 0 ):String 
		{
			return "new " + Reflection.getClassPath(this) + "( " + _value + ")" ;
		}

    	/**
    	 * Returns the string representation of this object.
    	 * @return the string representation of this object.
    	 */	
		public override function toString():String
		{
			return String(_value) ;	
		}

    	/**
    	 * Returns the primitive value of this object.
    	 * @return the primitive value of this object.
    	 */
		public function valueOf():*
		{
			return _value ;
		}
		
		/**
		 * @private
		 */
		private var _value:uint ;
		
	}
}