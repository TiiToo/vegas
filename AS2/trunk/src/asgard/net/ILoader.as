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


/**	ILoader

	AUTHOR

		Name : ILoader
		Package : asgard.media
		Version : 1.0.0.0
		Date :  2006-06-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net
	
	METHOD SUMMARY

	 	- getContent() ;
	
		- getBytesLoaded():Number ;

		- getBytesTotal():Number ;

		- getData() ;

		- getName():String ;

		- getPercent():Number ;

		- getTimeOut():Number ;

		- getUrl():String ;
	
		- initEvent():Void ;

		- load():Void ;

		- notifyError(sError:String, nCode:Number) : Void ;
	
		- notifyEvent(eventType:String):Void ;

		- onLoadInit():Void ;
	
		- release():Void ;

		- run():Void

		- setContent(o):Void ;

		- setData( o ):Void ;

		- setName(sName:String):Void ;

		- setTimeOut( n : Number ):Void ;

		- setUrl(sURL:String):Void ;
		
**/
 
import vegas.core.IRunnable;

/**
 * @author eKameleon
 * @version 1.0.0.0
 */
interface asgard.net.ILoader extends IRunnable {
	
	function getContent() ;
	
	function getBytesLoaded():Number ;

	function getBytesTotal():Number ;

	function getData() ;

	function getName():String ;

	function getPercent():Number ;

	function getTimeOut():Number ;

	function getUrl():String ;
	
	function initEvent():Void ;

	function load():Void ;

	function notifyError(sError:String, nCode:Number) : Void ;
	
	function notifyEvent(eventType:String):Void ;

	function onLoadInit():Void ;
	
	function release():Void ;

	function setContent(o):Void ;

	function setData( o ):Void ;

	function setName(sName:String):Void ;

	function setTimeOut( n : Number ):Void ;

	function setUrl(sURL:String):Void ;
	
}