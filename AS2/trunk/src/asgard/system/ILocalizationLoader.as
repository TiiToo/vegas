/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.system.Lang;
import asgard.system.Locale;

/**
 * This interface defines all methods of the loaders in the localization pattern.
 * @author eKameleon
 */
interface asgard.system.ILocalizationLoader 
{

	/**
	 * Returns the default Lang reference of the loader.
	 * @return the default Lang reference of the loader.
	 */
	function getDefault():Lang ;

	/**
	 * Returns the Locale object defines by the current passed-in Lang object.
	 * @return the Locale object defines by the current passed-in Lang object.
	 */
	function getLocalization(lang:Lang):Locale ; 

	/**
	 * Returns the path of the localization files.
	 * @return the path of the localization files.
	 */
	function getPath():String ;
	
	/**
	 * Returns the prefix value of the localization files.
	 * @return the prefix value of the localization files.
	 */
	function getPrefix():String ; 

	/**
	 * Returns the suffix value of the localization files.
	 * @return the suffix value of the localization files.
	 */
	function getSuffix():String ; 
	
	/**
	 * Initialize the internal event of this loader.
	 */
	function initEvent():Void ; 

	/**
	 * Load the localize file data with the specified Lang argument.
	 */
	function load( lang:Lang ):Void ; 

	/**
	 * Sets the default lang reference of this loader.
	 */
	function setDefault( lang:String ):Void ; 
	
	/**
	 * Sets the path of the localization files.
	 */
	function setPath( sPath:String ):Void ; 

	/**
	 * Sets the prefix value of the localization files.
	 */
	function setPrefix( sPrefix:String ):Void ; 

	/**
	 * Sets the suffix value of the localization files.
	 */
	function setSuffix( sSuffix:String ):Void ; 

}