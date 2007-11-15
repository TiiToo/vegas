/*

The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at 
  
http://www.mozilla.org/MPL/ 
  
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the License. 
  
The Original Code is LunAS Library.
  
The Initial Developer of the Original Code is
ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
Portions created by the Initial Developer are Copyright (C) 2004-2008
the Initial Developer. All Rights Reserved.
  
Contributor(s) :
  
*/

import andromeda.util.mvc.AbstractView;
import andromeda.util.mvc.IController;
import andromeda.util.mvc.IModel;

import lunas.display.components.list.AbstractListController;

import vegas.events.ModelChangedEvent;

/**
 * The view of the List component.
 * @author eKameleon
 */
class lunas.display.components.list.ListView extends AbstractView 
{

	/**
	 * Creates a new ListView instance.
	 */
	public function ListView(oModel:IModel, oController:IController, mcContainer:MovieClip) 
	{ 
		super( oModel, oController, mcContainer ) ;
	}

	public function handleEvent(ev:ModelChangedEvent):Void 
	{

		var eventName:String = ev.getType( ) ;
		//var target:ContainerModel = ev.getTarget() ;
		
		//var logger:ILogger = Log.getLogger() ;
		//logger.info( this + ".modelChanged -> eventName : " + eventName + "]" ) ;

		switch (eventName) 
		{
		
			case ModelChangedEvent.ADD_ITEMS : 
			{
				// ici ajouter une ou des cellules dans le container
				AbstractListController( getController( ) ).viewCreateAt( ev.index ) ;
				break ;
			}
			case ModelChangedEvent.CLEAR_ITEMS :
			{
				AbstractListController( getController( ) ).viewClear( ) ;
				break ;
			}
			case ModelChangedEvent.REMOVE_ITEMS :
			{
				var first:Number = ev.firstItem ;
				var last:Number = ev.lastItem ;
				AbstractListController( getController( ) ).viewRemove( first, last + 1 ) ;
				break ;
			}	
			case ModelChangedEvent.UPDATE_ALL : 
			{	
				break ; 
			}				
			case ModelChangedEvent.UPDATE_ITEMS : 
			{
				break ;
			}
			case ModelChangedEvent.UPDATE_FIELD : 
			{
				break ;
			}
			default :
			{
				//
			}
		}
		getViewContainer( ).update( ) ;
	}
}