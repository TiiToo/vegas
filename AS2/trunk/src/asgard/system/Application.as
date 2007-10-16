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

import asgard.system.ApplicationType;

/**
 * Static tool class to localize the application status.
 * <p><b>Thanks : Zwetan</b> NG > Burrrn.com [FMX] flash dans plusieurs environnements.</p>
 * @author eKameleon
 */
class asgard.system.Application
{

	/**
	 * Returns the full path of the application.
	 * @return the full path of the application.
	 */
	public static function getFullPath():String 
	{
		return _level0._url ;
	}
	
	/**
	 * Returns the string representation of the protocol of this application.
	 * @return the string representation of the protocol of this application.
	 */
	public static function getProtocol():String 
	{
		return Application.getFullPath().split("://")[0] ;
	}
	
	/**
	 * Return {@code true} if the application is in the Flash IDE.
	 * @return {@code true} if the application is in the Flash IDE.
	 */
	public static function isFlashIDE():Boolean 
	{
		return( _level0.$appPath != null );
	}
	
	/**
	 * Returns {@code true} if the application is a web application with the protocol HTTP ou HTTPS.
	 * @return {@code true} if the application is a web application with the protocol HTTP ou HTTPS.
	 */
	public static function isWeb():Boolean 
	{
		var protocol:String = Application.getProtocol();
		return( (protocol == ApplicationType.HTTP) || (protocol == ApplicationType.HTTPS) ) ;
	}

	/**
	 * Returns {@code true} if the application is a online web application.
	 * @return {@code true} if the application is a online web application.
	 */
	public static function isOnline():Boolean 
	{
		var protocol:String = Application.getProtocol() ;
		return ( (protocol == ApplicationType.FTP) || Application.isWeb() );
	}
	
	/**
	 * Returns {@code true} if the application is a local application.
	 * @return {@code true} if the application is a local application.
	 */
	public static function isLocal():Boolean 
	{
		var protocol:String = Application.getProtocol();
		return( protocol == ApplicationType.FILE );
	}
	
	/**
	 * Returns {@code true} if the application is a local web application.
	 * @return {@code true} if the application is a local web application.
	 */
	public static function isLocalWeb():Boolean 
	{
		var activeX = System.capabilities.hasAccessibility ;
		return( Application.isLocal() && (activeX == true) ) ;
	}

	/**
	 * Returns {@code true} if the application is a projector.
	 * @return {@code true} if the application is a projector.
	 */
	public static function isProjector():Boolean 
	{
		return
		( 
			Application.isLocal() &&
           !Application.isFlashIDE() &&
           !Application.isLocalWeb() 
		) ;
	}
	
	/**
	 * Returns the path of the IDE if the application is in the IDE of Flash.
	 * @return the path of the IDE if the application is in the IDE of Flash.
	 */
	public static function getIDEPath():String 
	{
		return (Application.isFlashIDE()) ? _level0.$appPath : "" ;
	}

}







