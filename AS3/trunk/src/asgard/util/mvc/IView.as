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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/* IView [Interface]

	AUTHOR

		Name : IView
		Package : asgard.util.mvc
		Version : 1.0.0.0
		Date :  2006-08-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- getController():IController
	
		- getDisplay():DisplayObject
		
		- handleEvent(e:Event):*
		
		- setController(oController:IController):void
		
		- setModel(oModel:IModel):void
		
		- setDisplay( display:DisplayObject=null ):void
	
*/

package asgard.util.mvc
{

	import asgard.util.mvc.IController;
	import asgard.util.mvc.IModel;	
	
	import flash.display.DisplayObject ;
	
	import vegas.events.EventListener;
	
	public interface IView extends EventListener
	{
		
		function getController():IController;
		
		function getDisplay():DisplayObject ;
		
		function setController(oController:IController):void ;
			
		function setModel(oModel:IModel):void ;
			
		function setDisplay(display:DisplayObject):void ;
		
	}
}