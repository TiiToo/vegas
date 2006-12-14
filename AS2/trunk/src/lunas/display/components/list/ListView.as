/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** ListView

	AUTHOR

		Name : ListView
		Package : lunas.display.components.list
		Version : 1.0.0.0
		Date :  2006-02-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- getController():IController

		- getViewContainer():MovieClip
		
		- handleEvent(e:Event)
		
		- registerWithModel( oModel:IModel ):Void
		
		- setController(oController:IController):Void
		
		- setModel(oModel:IModel):Void
		
		- setViewContainer(mcContainer:MovieClip):Void
		
	INHERIT
	
		CoreObject → AbstractView → ListView

	IMPLEMENTS 
	
		IView, IFormattable
		
	IMPLEMENTS 
	
		EventListener, IFormattable, IHashable, IView

*/

import lunas.display.components.container.ContainerModel;
import lunas.display.components.list.AbstractListController;

import vegas.events.ModelChangedEvent;
import vegas.events.ModelChangedEventType;
import vegas.util.mvc.AbstractView;
import vegas.util.mvc.IController;
import vegas.util.mvc.IModel;

class lunas.display.components.list.ListView extends AbstractView {

	// ----o Constructor

	public function ListView(oModel:IModel, oController:IController, mcContainer:MovieClip) 
	{ 
		super(oModel, oController, mcContainer) ;
	}

	// ----o Public Methods

	public function handleEvent(ev:ModelChangedEvent):Void 
	{

		var eventName:String = ev.getType() ;
		var target:ContainerModel = ev.getTarget() ;
		
		//var logger:ILogger = Log.getLogger() ;
		//logger.info( this + ".modelChanged -> eventName : " + eventName + "]" ) ;
		
		switch (eventName) {
		
			case ModelChangedEventType.ADD_ITEMS : // ici ajouter une ou des cellules dans le container
				AbstractListController(getController()).viewCreateAt(ev.index) ;
				break ;
			
			case ModelChangedEventType.CLEAR_ITEMS :
				AbstractListController(getController()).viewClear() ;
				break ;
			
			case ModelChangedEventType.REMOVE_ITEMS :
			
				var first:Number = ev.firstItem ;
				var last:Number = ev.lastItem ;
				AbstractListController(getController()).viewRemove(first, last+1) ;
				break ;
				
			case ModelChangedEventType.UPDATE_ALL : 
				
				// TODO :: effacer et rafraichir complètement le composant
				
				break ; 
				
			case ModelChangedEventType.UPDATE_ITEMS : 
			
				// rafraichir une série d'item d'un seul coup (optimisation)
				
				break ;
			
			case ModelChangedEventType.UPDATE_FIELD : 
			
				// ici changer l'affichage d'une cellule en fonction d'un nouveau item
				
				break ;
			
			default :
			
				//
		
		}
		getViewContainer().update() ;
	}

}