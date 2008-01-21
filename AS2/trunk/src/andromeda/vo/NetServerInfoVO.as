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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import andromeda.vo.SimpleValueObject;

import vegas.util.ConstructorUtil;

/**
 * This value object contains information sending by a server.
 * @author eKameleon
 */
class andromeda.vo.NetServerInfoVO extends SimpleValueObject 
{
    
    /**
     * Creates a new NetServerInfoVO instance.
     * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored
     */
    public function NetServerInfoVO( init ) 
    {
        super( init );
    }

	/**
	 * This object exist if the server return an application error object. 
	 * This property exist with FMS when the SSAS {@code application.rejectConnection()} method is invoked. 
	 */
	public var application ;

    /**
     * The code of the error.
     */
    public var code:String = null ;
    
    /**
     * The default description of the error.
     */
    public var description:String = null  ;

    /**
     * The level of this information object.
     */
    public var level:String = null ;  
    
    /**
     *  The line number of the error.
     */
    public var line:Number = null ;
    
    /**
     * The name of the method called.
     */
    public var methodName:String = null  ;
    
    /**
     * The name of the service used.
     */
    public var serviceName:String  = null ;

    /**
     * Register the class to AMF communication.
     */
    public static function register( id:String ):Boolean
    {
        return Object.registerClass( id || "NetServerInfoVO" , NetServerInfoVO ) ;
    }

	/**
	 * Returns the {@code Object} representation of this instance.
	 * @return the {@code Object} representation of this instance.
	 */
	public function toObject():Object 
	{
		return { description:description, code:code, level:level , application:application } ;
	}
    
    /**
     * Returns the {@code String} representation of this object.
     * @return the {@code String} representation of this object.
     */
    public function toString():String
    {
        var str:String = "[" + ConstructorUtil.getName(this) ;
        if (code != null && code.length > 0)
        {
            str += " code:" + code ;
        }
        if (level != null && level.length > 0)
        {
            str += " level:" + level;
        }
        if (description != null && description.length > 0)
        {
            str += " description:" + description;
        }
        if ( !isNaN(line) && line.toString().length > 0)
        {
            str += " line:" + line;
        }
		if (application != null)
		{
			str += " application:" + application  ;	
		}
        str += "]" ;
        return str ;
    }
    

}