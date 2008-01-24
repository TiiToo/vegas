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
package andromeda.util.mvc
{
	import andromeda.events.ModelChangedEvent;
	
	import vegas.core.ICloneable;	

	/**
	 * Defines the representation of a model in a specific type of the MVC implementation.
	 * @author eKameleon
	 */
	public interface IModel extends ICloneable
	{

		/**
		 * Adds a view in the model.
		 */
		function addView(view:IView):void ;
		
		/**
		 * Notify a ModelChangedEvent to the views.
		 */
		function notifyChanged( event:ModelChangedEvent ):void ;
		
		/**
		 * Removes a view in the model.
		 */
		function removeView(view:IView):void ;
		
	}
}