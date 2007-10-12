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

import asgard.system.Version;

/**
 * This singleton can be used to defined the copyright of your applications or frameworks.
 * @author eKameleon
 */
class asgard.system.Framework 
{
	
	/**
	 * This Object contains all the copyrights and properties of the application or the framework. 
	 */
	public static var COPYRIGHT = {} ;
	
	/**
	 * Returns the author of this project.
	 * @return the author of this project.
	 */
	public static function getAuthor():String 
	{
		return COPYRIGHT.author ;
	}
	
	/**
	 * Returns the licence of this application or framework.
	 * @return the licence of this application or framework.
	 */
	public static function getLicence():String 
	{
		return COPYRIGHT.licence ;
	}
	
	/**
	 * Returns the link of the project.
	 * @return the link of the project.
	 */
	public static function getLink():String 
	{
		return COPYRIGHT.link ;
	}
	
	/**
	 * Returns the mail of this project.
	 * @return the mail of this project.
	 */
	public static function getMail():String 
	{
		return COPYRIGHT.mail ;
	}
	
	/**
	 * Returns the name of the author (if it's different).
	 * @return the name of the author (if it's different).
	 */
	public static function getName():String 
	{
		return COPYRIGHT.name ;
	}
	
	/**
	 * Returns the version of this project.
	 * @return the version of this project.
	 */
	public static function getVersion():Version 
	{
		return COPYRIGHT.version ;
	}

	/**
	 * Sets the author of this project.
	 */
	public static function setAuthor(s:String):Void 
	{
		COPYRIGHT.author = s ;
	}

	/**
	 * Sets the licence of this application or framework.
	 */
	public static function setLicence(s:String):Void 
	{
		COPYRIGHT.licence = s ;
	}

	/**
	 * Sets the link of the project.
	 */
	public static function setLink(s:String):Void 
	{
		COPYRIGHT.link = s ;
	}
	
	/**
	 * Sets the mail of this project.
	 */
	public static function setMail (s:String):Void 
	{
		COPYRIGHT.mail = s ;
	}

	/**
	 * Sets the name of the author (if it's different).
	 */
	public static function setName(s:String):Void 
	{
		COPYRIGHT.name = s ;
	}

	/**
	 * Sets the version of this project.
	 */
	public static function setVersion(v:Version):Void 
	{
		COPYRIGHT.version = v ;
	}
	
	/**
	 * Returns the string representation of this singleton.
	 * @return the string representation of this singleton.
	 */
	public static function toString():String 
	{
		var txt:String = "<" ;
		for (var prop in COPYRIGHT) 
		{
			txt += "\r\t" + prop + " : " + (COPYRIGHT[prop].toString() || "empty") ;
		}
		txt += "\r>" ;
		return txt ;
	}

}