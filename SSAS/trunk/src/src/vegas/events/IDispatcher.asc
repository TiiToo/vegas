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
 * The IDispatcher class (interface).
 * @author eKameleon
 */
if (vegas.events.IDispatcher == undefined) 
{
	
	/**
	 * Creates a new IDispatcher class.
	 */
	vegas.events.IDispatcher = function () 
	{ 
		//
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	vegas.events.IDispatcher.extend(vegas.core.CoreObject) ;
	
	vegas.events.IDispatcher.prototype.addEventListener = function(eventName/*String*/, obj, func)/*Void*/ 
	{
		// override this method or mixin !
	}

	vegas.events.IDispatcher.prototype.dispatchEvent = function (ev) /*Void*/ 
	{
		// override this method or mixin !
	}

	vegas.events.IDispatcher.prototype.eventListenerExists = function (eventName /*String*/, obj , func) /*Boolean*/ 
	{
		// override this method or mixin !
	}

	vegas.events.IDispatcher.prototype.removeAllEventListener = function( eventName/*String*/ ) /*Void*/ 
	{
		// override this method or mixin !
	}

	vegas.events.IDispatcher.prototype.removeEventListener = function( eventName /*String*/, obj , func ) /*Void*/ 
	{
		// override this method or mixin !
	}

	vegas.events.IDispatcher.prototype.updateEvent = function ( eventName /*String*/, oInit) /*Void*/ 
	{
		// override this method or mixin !
	}

	vegas.events.IDispatcher.prototype.toString = function()/*String*/ 
	{
		// override this method or mixin !
	}

}