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

/**
 * @author eKameleon
 * @version 1.0.0.0
 * @date 2006-03-24
 */
 
import asgard.events.LoaderEvent;

interface asgard.net.LoaderListener {

	function onLoadComplete(e:LoaderEvent):Void ;
	
	function onLoadError(e:LoaderEvent):Void ;

	function onLoadInit(e:LoaderEvent):Void ;

	function onLoadProgress(e:LoaderEvent):Void ;

	function onLoadStart(e:LoaderEvent):Void ;

	function onLoadTimeOut(e:LoaderEvent):Void ;

}