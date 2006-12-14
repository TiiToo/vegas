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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.core.HashCode;
import vegas.core.IFormattable;
import vegas.core.IHashable;
import vegas.errors.ErrorElement;
import vegas.errors.ErrorFormat;
import vegas.logging.ILogger;
import vegas.logging.Log;
import vegas.util.ConstructorUtil;

/**
 * This class provides a Abstract implementation to creates Error classes with an internal logging model. 
 * @author eKameleon
 */
class vegas.errors.AbstractError extends Error implements IFormattable, IHashable 
{
    
	/**
	 * Creates a new AbstractError only if you inherit this class.
	 */
	private function AbstractError(message:String, e:ErrorElement) 
	{
		super(message) ;
		errorElement = e ;
		name = ConstructorUtil.getName(this) ;
		_logger = Log.getLogger( ConstructorUtil.getPath(this) ) ;
	}

	/**
	 * Launch HashCode 'initialize' method.
	 */	
	static private var _initHashCode:Boolean = HashCode.initialize(AbstractError.prototype) ;

	/**
	 * The internal ErrorElement reference.
	 */
	public var errorElement:ErrorElement ;
	
	/**
	 * Returns the internal logger's category.
	 */
	public function getCategory():String 
	{
		return _logger["category"] ;
	}
	
	/**
	 * Returns the internal logger.
	 */
	public function getLogger():ILogger 
	{
		return _logger ;
	}
	
	/**
	 * Returns a hashcode value for the object.
	 */
	public function hashCode():Number 
	{
		return null ;
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance
	 */
	public function toString():String 
	{
		return (new ErrorFormat()).formatToString(this) ;
	}
	
	/**
	 * The internal logger of this instance.
	 */	
	private var _logger:ILogger ;
	
}
