﻿/*

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

package vegas.core
{
	import system.ISerializable;
	import system.Reflection;
	
	import vegas.logging.ILogable;
	import vegas.logging.ILogger;
	import vegas.logging.Log;	

	/**
	 * CoreObject offers a default implementation of the IFormattable, IHashable and ISerializable interfaces.
	 * <p>
	 * <pre class="prettyprint">
	 * import vegas.core.CoreObject ;
	 *  
	 * var core:CoreObject = new CoreObject() ;
	 * trace("> core : " + core) ;
	 * trace("> hashcode : " + core.hashCode()) ;
	 * trace("> toSource : " + core.toSource()) ;
	 * </pre>
	 * </p>
	 * @author eKameleon
	 * @version 1.0.0.0
	 */
	public class CoreObject extends Object implements IFormattable, IHashable, ILogable, ISerializable
	{
		
		/**
		 * Creates a new CoreObject instance.
		 */
		function CoreObject() 
		{
		    _logger = Log.getLogger( Reflection.getClassPath(this) ) ;
		}

		/**
		 * Returns the internal <code>ILogger</code> reference of this <code>ILogable</code> object.
		 * @return the internal <code>ILogger</code> reference of this <code>ILogable</code> object.
		 */
		public function getLogger():ILogger
		{
			return _logger ; 	
		}
		
		/**
		 * Returns a hashcode value for the object.
		 * @return a hashcode value for the object.
		 */
		public function hashCode():uint 
		{
			if ( isNaN( __hashcode__ ) ) 
			{
				__hashcode__ = HashCode.next() ;
			}
			return __hashcode__ ;
		}
	
		/**
		 * Sets the internal <code>ILogger</code> reference of this <code>ILogable</code> object.
		 */
		public function setLogger( log:ILogger=null ):void 
		{
			_logger = (log == null ) ? Log.getLogger( Reflection.getClassPath(this) ) : log ;
		}

		/**
		 * Returns a Eden representation of the object.
		 * @return a string representation the source code of the object.
		 */
		public function toSource( indent:int = 0 ):String 
		{
			return "new " + Reflection.getClassPath(this) + "()" ;
		}

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance.
		 */
		public function toString():String 
		{
			return "[" + Reflection.getClassName(this) + "]" ;
		}
		
		/**
		 * @private
		 */
		private var __hashcode__:Number ;
		
		/**
		 * The internal ILogger reference of this object.
		 */
		private var _logger:ILogger ;

	}
	
}