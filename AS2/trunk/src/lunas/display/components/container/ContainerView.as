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
 
import lunas.display.components.container.ContainerController;

import vegas.events.ModelChangedEvent;
import vegas.util.mvc.AbstractView;
import vegas.util.mvc.IController;
import vegas.util.mvc.IModel;

class lunas.display.components.container.ContainerView extends AbstractView 
{

	/**
	 * Creates a new ContainerView instance.
	 */
	public function ContainerView(oModel:IModel, oController:IController, mcContainer:MovieClip) 
	{ 
		super(oModel, oController, mcContainer) ;
	}

	/**
	 * Handles the event.
	 */
	public function handleEvent(ev:ModelChangedEvent):Void 
	{
		var eventName:String = ev.getType() ;
		//var target:ContainerModel = ev.getTarget() ;
		var c:ContainerController = ContainerController(getController()) ;
		switch (eventName) 
		{
		
			case ModelChangedEvent.ADD_ITEMS :
			{
				//
				break ;
			}
			case ModelChangedEvent.CLEAR_ITEMS :
			{
				c.removeItems(ev.removedItems) ;
				break ;
			}
			case ModelChangedEvent.REMOVE_ITEMS :
			{
				c.removeItems(ev.removedItems) ;
				break ;
			}
			case ModelChangedEvent.UPDATE_ITEMS :
			{ 
				//
				break ;
			}
			default :
			{
				//
			}
		}
		getViewContainer().update() ;
	}

}