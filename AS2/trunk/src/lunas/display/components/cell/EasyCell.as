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

/** EasyCell

	AUTHOR

		Name : EasyCell
		Package : lunas.display.components.cell
		Version : 1.0.0.0
		Date :  2006-02-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY

		- cellIndex:CellIndex [Read Only]
		
		- data:Object
		
		- index:Number
		
		- label:String [R/W]
		
		- listOwner:MovieClip [R/W]
		
		- selected:Boolean [R/W]
		
		- toggle:Boolean [R/W]
	
	METHOD SUMMARY

		- getCellIndex():Object
		
			Renvoi un objet avec deux champs, columnIndex et rowIndex, indiquant la position de la cellule. 
		
		- getIcon():String
		
		- getIconDepth():String
		
		- getIconTarget():MovieClip
		
		- getLabel():String
		
		- getListOwner()	
		
			Référence à la liste contenant la cellule
		
		- getPreferredHeight():Number
			
			Renvoi la hauteur que devrait avoir une cellule dans la liste.
		
		- getPreferredWidth()
		
			Renvoi la largeur que devrait avoir une cellule dans la liste.
		
		- getSelected():Boolean
		
		- getSize(w:Number, h:Number):Object
		
		- getToggle():Boolean
		
		- resetIconColor():Void
		
		- setCellIndex( itemIndex:Number , columnIndex:Number ):Void
		
			Défini un objet ayant les 2 propriétés itemIndex et columnIndex
		
		- setIcon(str:String):Void
		
		- setIconColor(hex:Number):Void
		
		- setLabel(str:String):Void

		- setListOwner(owner:MovieClip):Void
		
			Permet de définir la référence vers la liste contenant la cellule.
		
		- setSelected(b:Boolean, noEvent:Boolean):Void

		- setSize()
			
			Définit la largeur et la hauteur d'une cellule. (tous les composants ont cette méthode)
		
		- setToggle(b:Boolean):Void
		
		- setValue()
		
			Définit le contenu à afficher dans la cellule.
		
		- viewIconChanged():Void
		
		- viewLabelChanged():Void

	EVENT SUMMARY
	
		ButtonEvent
		
		- CLICK:MouseEventType
		
		- UP:ButtonEventType
		
		- DISABLED:ButtonEventType
		
		- DOUBLE_CLICK:MouseEventType
		
		- DOWN:ButtonEventType
		
		- ICON_CHANGE:ButtonEventType
		
		- LABEL_CHANGE:ButtonEventType
		
		- MOUSE_UP:MouseEventType
		
		- MOUSE_DOWN:MouseEventType
		
		- OUT:ButtonEventType
		
		- OUT_SELECTED:ButtonEventType
		
		- OVER:ButtonEventType
		
		- OVER_SELECTED:ButtonEventType
		
		- ROLLOUT:MouseEventType
		
		- ROLLOVER:MouseEventType
		
		- SELECT:ButtonEventType
		
		- UNSELECT:ButtonEventType
		
		- UP:ButtonEventType

	IMPLEMENTS 
	
		IButton, ICell, IEventTarget

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractButton → AbstractIconButton → EasyButton → EasyCell

	SEE ALSO
	
		IBuilder, IStyle
	
**/

import lunas.display.components.button.EasyButton;
import lunas.display.components.cell.CellDecorator;
import lunas.display.components.cell.CellIndex;
import lunas.display.components.ICell;
import lunas.events.CellEvent;

class lunas.display.components.cell.EasyCell extends EasyButton implements ICell {

	// ----o Constructor

	public function EasyCell () { 
		super() ;
		_cellDecorator = new CellDecorator() ;
	}

	// ----o Public Properties
	
	//public var cellIndex ; // [Read Only]
	//public var listOwner:MovieClip ; // [R/W]

	// ----o Public Methods
	
	public function getCellIndex():CellIndex {
		return _cellDecorator.getCellIndex() ;
	}
	
	public function getListOwner():MovieClip {
		return _cellDecorator.getListOwner() ;
	}

	public function getPreferredHeight():Number {
		return _cellDecorator.getPreferredHeight() ;	
	}

	public function getPreferredWidth():Number {
		return _cellDecorator.getPreferredWidth() ;
	}
	
	public function initButtonEvent():Void {
		_eButton = new CellEvent(null, this) ;	
	}
	
	public function setCellIndex( itemIndex:Number , columnIndex:Number ):Void {
		_cellDecorator.setCellIndex(itemIndex, columnIndex) ;
	}

	public function setListOwner(owner:MovieClip):Void {
		_cellDecorator.setListOwner(owner) ;
	}
	
	/*override*/ public function setSize(w:Number, h:Number):Void {
		var s:Object = _cellDecorator.getSize(w, h) ;
		super.setSize(s.w, s.h) ;
	}
	
	public function setValue ():Void {
		// override
	}

	// ----o Virtual Properties
	
	public function get cellIndex():CellIndex {
		return getCellIndex() ;	
	}
	
	public function get listOwner():MovieClip {
		return getListOwner() ;
	}

	public function set listOwner(mcList:MovieClip):Void {
		setListOwner(mcList) ;
	}

	// ----o Private Properties
	
	private var _cellDecorator:CellDecorator ;
	private var _eButton:CellEvent ;
	
}
