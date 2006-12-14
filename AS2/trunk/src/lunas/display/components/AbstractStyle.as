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

/** AbstractStyle

	AUTHOR
	
		Name : AbstractStyle
		Package : lunas.display.components
		Version : 1.0.0.0
		Date :  2006-02-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY
	
		- labelStyleName:String [R/W]
	
		- styleSheet:TextField.StyleSheet [R/W]
			
			Feuille de style des textes contenus dans le widget ou composant.

	METHOD SUMMARY
	
		- addEventListener( eventName:String, listener:EventListener, useCapture:Boolean, priority:Number, autoRemove:Boolean):Void
		
		- getFieldText( sLabel:String [, styleName:String]):String
		
			Renvoi une chaine de caractère formatée en fonction de la propriété labelStyleName.
			
			PARAMS
			
				- sLabel:String : la chaine de caractère à formatter.
				
				- styleName:String : une chaine de caractère facultative pour remplacer le labelStyleName par défaut de la feuille de style.
		
		- getLabelStyleName():String
		
			Renvoi le nom de la feuille de style du label principal de la feuille de style.
		
		- getStyle (prop:String) 
			renvoie la valeur d'une propriété de style si elle existe.
		
		- getStyleFormatter():StringFormatter
		
			Renvoi le StringFormatter utilisé dans getFieldText.
		
		- getStyleSheet () 
			Renvoi la feuille de style du composant
		
		- removeEventListener(eventName:String, listener, useCapture:Boolean):EventListener
		
		- setLabelStyleName(s:String):Void
		
			Permet de définir le labelStyleName par défaut de la feuille de style.
		
		- setStyle (props:Object) ou ( prop:String , value ) 
			
			Définir une ou plusieurs propriétés du style
		
		- setStyleSheet (ss)
			
			Permet de définir une feuille de style pour le composant
		
		- update():Void

	
	PROTECTED METHOD SUMMARY
	
		- initialize() 
			
			Méthode interne invoquée à la création de l'instance de style, peut être surchargée en cas de besoin pour initialiser les propriétés par défaut
			de la feuille de style.

		- styleChanged()
			
			Méthode interne pouvant être surchargée si nécessaire dans certaines feuilles de style.

		- styleSheetChanged()
			
			Méthore interne pouvant être surchargée si nécessaire dans certaines feuilles de style.
	
	EVENT SUMMARY
	
		- StyleEvent
		
			- StyleEventType.STYLE_CHANGED
			- StyleEventType.STYLE_SHEET_CHANGED

	INHERIT
	
		CoreObject → AbstractCoreEventDispatcher → AbstractStyle

	IMPLEMENTS
		
		EventTarget, IEventDispatcher, IFormattable, IHashable, IStyle

**/

import lunas.display.components.IStyle;
import lunas.events.StyleEvent;
import lunas.events.StyleEventType;

import vegas.events.AbstractCoreEventDispatcher;
import vegas.events.Event;
import vegas.string.StringFormatter;
import vegas.util.TypeUtil;

/**
 * @author eKameleon
 */
class lunas.display.components.AbstractStyle extends AbstractCoreEventDispatcher implements IStyle 
{

	private function AbstractStyle ( init:Object ) 
	{
		super() ;		
		for (var prop:String in init) 
		{
			this[prop] = init[prop] ;
		}
		_styleFormatter = new StringFormatter("<span class='{0}'>{1}</span>") ;
		initialize() ;
		update() ;
	}
	
	public function get labelStyleName():String 
	{
		return getLabelStyleName() ; 	
	}

	public function set labelStyleName(s:String):Void 
	{
		setLabelStyleName(s) ; 	
	}
	
	public function get styleSheet():TextField.StyleSheet 
	{
		return getStyleSheet() ; 	
	}

	public function set styleSheet(ss:TextField.StyleSheet):Void 
	{
		setStyleSheet(ss) ; 	
	}
	
	public function initialize():Void 
	{
		// override
	}
	
	public function getFieldText( sLabel:String , styleName:String ):String 
	{
		var txt:String = "" ;
		if (sLabel.length > 0) 
		{
			txt = _styleFormatter.format( styleName || getLabelStyleName(), sLabel) ;
		}
		return txt ;
	}

	public function getLabelStyleName():String 
	{
		return _labelStyleName || "" ;	
	}

	public function getStyle(prop:String) 
	{ 
		return this[prop] || null ;
	}
	
	public function getStyleFormatter():StringFormatter 
	{
		return _styleFormatter ;	
	}

	public function getStyleSheet():TextField.StyleSheet 
	{ 
		return _oS ;
	}

	public function setLabelStyleName(s:String):Void 
	{
		_labelStyleName = s || null ;	
	}

	public function setStyle(  ):Void 
	{

		if (arguments.length == 0 || arguments[0] == null) return ; 
		
		if (TypeUtil.typesMatch(arguments[0], String) && arguments.length > 1) 
		{
			this[arguments[0]] = arguments[1] ;
		}
		else if (arguments[0] instanceof Object) 
		{
			var prop = arguments[0] ;
			for (var i:String in prop) this[i] = prop[i] ;
		}
		_fireEvent( new StyleEvent(StyleEventType.STYLE_CHANGED, this)) ;
		
	}
	
	public function setStyleSheet(ss:TextField.StyleSheet):Void 
	{
		_oS = ss ;
		styleSheetChanged() ;
		_fireEvent(new StyleEvent(StyleEventType.STYLE_SHEET_CHANGED, this)) ;
	}

	public function styleChanged():Void 
	{
		// override
	}

	public function styleSheetChanged():Void 
	{
		// override
	}

	public function update():Void 
	{
		// override with super !
		styleChanged() ;
	}

	private var _labelStyleName:String = null ;

	private var _oS:TextField.StyleSheet ;

	private var _styleFormatter:StringFormatter ;
	
	private function _fireEvent(event, isQueue:Boolean, target, context):Event 
	{
		return dispatchEvent(event, isQueue, target, context) ;
	}
	
}