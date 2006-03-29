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

/** KeysValidator

	AUTHOR

		Name : KeysValidator
		Package : asgard.ui
		Version : 1.0.0.0
		Date :  2005-10-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Permet de définir une collection de touche à valider pour lancer une action.
		
	USAGE
	
		new KeysValidator( [keys] ) ;
		
	PARAMS
	
		keys : 
			un tableau facultatif contenant une collection de touche définissant 
			la validation nécessaire pour lancer une action.

	CONSTANT SUMMARY
	
		- CODE:Number  (0)
		
		- ASCII:Number (1)

	PROPERTY SUMMARY
	
		- codePolicy[R/W] [Number] : vaut CODE(0) ou ASCII(1) (par défaut vaut CODE)
	
			Permet de notifier une validation en fonction de la méthode Key.getCode() ou Key.getASCII
	
	METHOD SUMMARY
	
		- addEventListener( eventName:String, listener, autoRemove:Boolean, priority:Number ):Void
	
		- clear()
		
		- countKeys()
		
			renvoi le nombre de touches nécessaires pour valider l'action
		
		- insert(keyCode:Number)
		
			insère une nouvelle touche dans la liste des touches à presser
		
		- remove(keyCode:Number)
		
			supprimer une touche dans la liste des touches.
		
		- removeEventListener(eventName:String, listener):EventListener 
		
		- setCodePolicy(code:Number)
		
			code vaut CODE(0) ou ASCII(1)
		
		- supports(value)
		
			renvoi true si la valeur existe dans la liste des touches
		
		- toString():String
		
		- validate(value)
		
			Permet de valider une valeur.
	
	EVENT SUMMARY
	
		ValidatorEvent
		
			- ValidatorEventType.INVALID
			
			- ValidatorEventType.VALID
	
	IMPLEMENTS
	
		Validator
		
	SEE ALSO
	
		asgard.ui.Keyboard (gestion des touches F1..F12, etc. et des codes en fonction d'un caractère)
		
----------------*/

import vegas.core.CoreObject;
import vegas.core.IValidator;
import vegas.data.iterator.Iterator;
import vegas.data.set.HashSet;
import vegas.events.EventDispatcher;
import vegas.events.EventListener;
import vegas.events.ValidatorEvent;
import vegas.events.ValidatorEventType;

class asgard.ui.KeysValidator extends CoreObject implements IValidator {
	
	// ----o Constructor
	
	public function KeysValidator( keys:Array ) {
		Key.addListener(this) ;
		_dispatcher = new EventDispatcher() ;
		_set = new HashSet(keys) ;
		_reset() ;
	}

	// ----o Constants
	
	static public var CODE:Number = 0 ;
	static public var ASCII:Number = 1 ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(KeysValidator, null, 7, 7) ;
	
	// ----o Public Methods

	public function addEventListener( eventName:String, listener, autoRemove:Boolean, priority:Number ):Void {
		_dispatcher.addEventListener(eventName, listener, autoRemove, priority) ;
	}

	public function clear():Void {
		_set.clear() ;
	}
	
	public function countKeys():Number {
		return _set.size() ;
	}

	public function insert(keyCode:Number):Boolean {
		var b:Boolean = _set.insert(keyCode) ;
		if (b) _reset() ;
		return b ;
	}
	
	public function remove(keyCode:Number):Boolean {
		var b:Boolean = _set.remove(keyCode) ;
		if (b) _reset() ;
		return b ;
	}
	
	public function removeEventListener(eventName:String, listener):EventListener {
		return _dispatcher.removeEventListener(eventName, listener) ;
	}
	
	public function setCodePolicy(code:Number):Void {
		_cp = code ;
	}
	
	public function supports(value):Boolean {
		return _it.next() == value ;
	}
	
	public function validate(value):Void {
		if ( supports(value) ) {
			if (!_it.hasNext()) {
				_reset() ;
				_dispatcher.dispatchEvent(new ValidatorEvent(ValidatorEventType.VALID, this)) ;
			}
		} else {
			_reset() ;
			_dispatcher.dispatchEvent(new ValidatorEvent(ValidatorEventType.INVALID, this)) ;
		}
	}
	
	// ----o Virtual Properties
	
	public function get codePolicy():Number {
		return _cp ;
	}
	
	public function set codePolicy(n:Number):Void {
		setCodePolicy(n) ;
	}
	
	// ----o Private Properties
	
	private var _cp:Number = KeysValidator.CODE ; // codePolicy property
	private var _dispatcher:EventDispatcher ;
	private var _set:HashSet ;
	private var _it:Iterator ;
	
	// ----o Private Methods
	
	private function _reset():Void {
		_it = _set.iterator() ;
	}
	
	private function onKeyDown():Void {
		var code:Number ;
		if (_cp == KeysValidator.ASCII) {
			code = Key.getAscii() ;
			if (code == 0 || code == undefined ) code = Key.getCode() ;
		} else {
			code = Key.getCode() ;
		}
		validate(code) ;
	}
	
	private function onKeyUp():Void {
		_reset() ;
	}

}