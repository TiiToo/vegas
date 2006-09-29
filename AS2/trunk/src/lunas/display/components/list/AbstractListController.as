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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** ListController

	AUTHOR

		Name : ListController
		Package : lunas.display.components.list
		Version : 1.0.0.0
		Date :  2006-02-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- getModel():IModel
		
		- getView():IView
		
		- setModel(oModel:IModel):Void
		
		- setView(oView:IView):Void
		
		- toString():String
		
		- viewClear():Void
		
		- viewCreateAt(index:Number):MovieClip
		
		- viewRemove(first:Number, last:Number):Void
		
		- viewRollOut 
			Override this method - Out of a cell.
			
		- viewRollOver():Void
			override this method - Over of a cell.
		
		- viewSelect(ev:IEvent):Void
			Invoqué quand une cellule est sélectionnée dans la liste, notifie un événement UIEventType.CHANGE
		
		-  viewUpdateItemAt(index:Number)
			Permet de rafraichir l'affichage d'une cellule dans la liste.
			
	INHERIT 
	
		CoreObject → AbstractController → ListController

	IMPLEMENTS 
	
		IController, IFormattable, IHashable

**/

import lunas.events.CellEvent;

import vegas.events.Event;
import vegas.util.mvc.AbstractController;
import lunas.display.components.ICell;

class lunas.display.components.list.AbstractListController extends AbstractController 
{

	// ----o Constructor

	public function ListController() 
	{ 
		//
	}

	// ----o Public Methods

	public function unSelect():Void
	{
		if (_oldCell != null)
		{
			var view_mc:MovieClip = getView().getViewContainer() ;
			MovieClip(_oldCell).enabled = view_mc.enabled ;	
			_oldCell = null ;
		}
	}

	public function viewClear():Void 
	{
		var view_mc:MovieClip = getView().getViewContainer() ;
		view_mc.unSelect() ;
		var container:MovieClip = view_mc.getContainer() ;
		container.clear() ;
	}
	
	public function viewCreateAt(index:Number):MovieClip 
	{
		return null ;
	}

	public function viewRemove(first:Number, last:Number):Void 
	{
		var view_mc:MovieClip = getView().getViewContainer() ;
		var container:MovieClip = view_mc.getContainer() ;
		container.removeRange(first, last) ;
		view_mc.unSelect() ;
	}
	
	public function viewRollOver(ev:CellEvent):Void 
	{
		var view_mc:MovieClip = getView().getViewContainer() ;
		// todo envoyer le numéro de la cellule courante
		ev.setTarget(view_mc) ;
		view_mc.dispatchEvent(ev) ;
	}
	
	public function viewRollOut(ev:CellEvent):Void 
	{
		var view_mc:MovieClip = getView().getViewContainer() ;
		// todo envoyer le numéro de la cellule courante
		ev.setTarget(view_mc) ;
		view_mc.dispatchEvent(ev) ;
	}

	public function viewSelect(ev:CellEvent):Void 
	{
		var cellIndex:Object = ev.getCellIndex() ;
		var cell:ICell = ev.getCell() ;
		var view_mc:MovieClip = getView().getViewContainer() ;
		
		view_mc.setSelectedIndex(cellIndex.itemIndex || cell["index"], true) ;
		
		
		//////////////////// Protected Selected !! 
		
		if (view_mc.protectSelected)
		{
		
			if (_oldCell != null)
			{
				MovieClip(_oldCell).enabled = true ;
			}
			MovieClip(cell).enabled = false ;
			
			_oldCell = cell ;
		
		}
		////////////////////
		
		view_mc.notifyChanged() ;
		
	}

	public function viewSort(ev:Event):Void 
	{
		// override this method
	}
	
	public function viewUpdateItemAt(index:Number):Void 
	{
		// override this method
	}
	
	// ----o Private Properties
	
	private var _oldCell:ICell ;

}