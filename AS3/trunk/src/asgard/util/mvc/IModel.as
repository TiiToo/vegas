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

/* IModel [Interface]

	AUTHOR

		Name : IModel
		Package : asgard.util.mvc
		Version : 1.0.0.0
		Date :  2006-08-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- addView(listener:EventListener):Void
		
		- clone():*
		
		- notifyChanged(ev:ModelChangedEvent):Void
		
		- removeView(listener:EventListener):Void
	
	INHERIT
	
		IModel
	
*/

package asgard.util.mvc
{
	
	import asgard.events.ModelChangedEvent;
	import asgard.util.mvc.IView;
		
	import vegas.core.ICloneable;

	public interface IModel extends ICloneable
	{
		
		function addView(view:IView):void ;
		
		function notifyChanged( event:ModelChangedEvent ):void ;
		
		function removeView(view:IView):void ;
		
	}
}