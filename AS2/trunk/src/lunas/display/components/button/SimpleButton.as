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

/** SimpleButton

	AUTHOR

		Name : SimpleButton
		Package : lunas.display.components.button
		Version : 1.0.0.0
		Date :  2006-05-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		SimpleButton s'utilise directement dans les paramètres de liaision d'un clip dans la bibliothèque des symboles.
		Il faut que le clip possède en interne 4 images clés ayant pour nom d'étiquette :
			- disabled : état visuel lorsque le bouton est désactivé.
			- down     : état visuel lorsque l'utilisateur clique sur le bouton.
		    - over     : état visuel lorsque l'utilisateur passe la souris sur le bouton.
			- up       : état visuel de base du bouton (souvant la première image clé.
 
 		Remarque : la méthode 'stop()' est invoqué lorsque le bouton apparait sur la scène.

	PROPERTY SUMMARY

		- index:Number
		
		- data:Object
		
		- label:String [R/W]
		
		- selected:Boolean [R/W]
		
		- toggle:Boolean [R/W]
	
	METHOD SUMMARY
		
		- getLabel():String
		
		- getSelected():Boolean
		
		- getToggle():Boolean
		
		- setLabel(str:String):Void
		
		- setSelected(b:Boolean, noEvent:Boolean):Void
		
		- setToggle(b:Boolean):Void
		
		- final viewEnabled():Void
		
		- viewLabelChanged():Void
		
			override this method !

	EVENT SUMMARY
	
		ButtonEvent
	
	EVENT TYPE SUMMARY
	
		- ButtonEvent.CLICK:String
		
		- ButtonEvent.DISABLED:String
		
		- ButtonEvent.DOUBLE_CLICK:String
		
		- ButtonEvent.DOWN:String
		
		- ButtonEvent.ICON_CHANGE:String
		
		- ButtonEvent.LABEL_CHANGE:String
		
		- ButtonEvent.MOUSE_UP:String
		
		- ButtonEvent.MOUSE_DOWN:String
		
		- ButtonEvent.OUT:String
		
		- ButtonEvent.OUT_SELECTED:String
		
		- ButtonEvent.OVER:String
		
		- ButtonEvent.OVER_SELECTED:String
		
		- ButtonEvent.ROLLOUT:String
		
		- ButtonEvent.ROLLOVER:String
		
		- ButtonEvent.SELECT:String
		
		- ButtonEvent.UNSELECT:String
		
		- ButtonEvent.UP:String

	IMPLEMENTS 
	
		IButton, IEventTarget

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractButton → SimpleButton  

	SEE ALSO
	
		IBuilder, IButton, IStyle

**/

import lunas.display.components.button.AbstractButton;

import pegas.events.ButtonEvent;
import pegas.events.ButtonEventType;

import vegas.events.Delegate;
import vegas.events.EventListener;

class lunas.display.components.button.SimpleButton extends AbstractButton {

	// ----o Constructor

	public function SimpleButton () {
		
		super() ;
		
		_listenerDisabled = new Delegate(this, disabled) ;
		_listenerDown = new Delegate(this, down) ;
		_listenerOver = new Delegate(this, over) ;
		_listenerUp = new Delegate(this, up) ;
		
		addEventListener (ButtonEventType.DISABLED, _listenerDisabled) ;
		addEventListener (ButtonEventType.DOWN, _listenerDown) ;
		addEventListener (ButtonEventType.OVER, _listenerOver) ;
		addEventListener (ButtonEventType.UP, _listenerUp) ;
	
		getView().stop() ;
			
	}

	// ----o Public Methods

	public function disabled( e:ButtonEvent ): Void {
		getView().gotoAndStop(ButtonEventType.DISABLED) ;
	}	
	public function down( e:ButtonEvent ): Void {
		getView().gotoAndStop(ButtonEventType.DOWN) ;
	}

	/**
	 * Cette méthode permet de déléguer les changements visuels du bouton vers une autre 'vue',
	 * pour cela il suffit d'écraser cette méthode.
	 */
	public function getView():MovieClip {
		return this ;
	}

	public function over( e:ButtonEvent ):Void {
		getView().gotoAndStop(ButtonEventType.OVER) ;
	}

	public function up( e:ButtonEvent ):Void {
		getView().gotoAndStop(ButtonEventType.UP) ;
	}

	// ----o Private Properties
	
	private var _listenerDisabled:EventListener ;
	private var _listenerDown:EventListener ;
	private var _listenerOver:EventListener ;
	private var _listenerUp:EventListener ;	

}
