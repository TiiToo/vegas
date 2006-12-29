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

/**

	AUTHOR

		Name : AbstractLabel
		Package : lunas.display.components.text
		Version : 1.0.0.0
		Date :  2006-02-19
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	PROPERTY SUMMARY

		- autoSize:Boolean [R/W]

		- html:Boolean [R/W]
		
		- label:String [R/W]

		- multiline:Boolean [R/W]

		- text:String [R/W] 

			Par défaut utilise 'label'

	METHOD SUMMARY
	

		- getAutoSize():Boolean

		- getHTML():Boolean
		
		- getLabel():String

		- getMultiline():Boolean)

		- getText():String

			Par défaut utilise 'getLabel'

		- setHTML(b:Boolean):Void

		- setAutoSize(b:Boolean):Void
		
		- setLabel(str:String):Void

		- setMultiline(b:Boolean):Void

		- setText(str:String):Void

			Par défaut utilise 'setLabel'

		- viewLabelChanged():Void

			override this method !

	IMPLEMENTS 
	
		ILabel, IEventTarget

	EVENT SUMMARY

		UIEvent

	EVENT TYPE SUMMARY

		UIEventType.LABEL_CHANGE

	INHERIT 
	
		MovieClip → AbstractComponent → AbstractLabel

	IMPLEMENTS
	
		ILabel

	SEE ALSO
	
		IBuilder, IStyle

*/

import lunas.display.components.AbstractComponent;
import lunas.display.components.ILabel;

import pegas.events.UIEvent;
import pegas.events.UIEventType;

class lunas.display.components.text.AbstractLabel extends AbstractComponent implements ILabel 
{

	// ----o Constructor

	private function AbstractLabel() 
	{ 
		super() ;		
	}

	// ----o Public Properties

	public function get autoSize():Boolean 
	{
		return getAutoSize() ;	
	}

	public function set autoSize(b:Boolean) 
	{
		setAutoSize(b) ;	
	}

	public function get html():Boolean 
	{
		return getHTML() ;	
	}

	public function set html(b:Boolean) 
	{
		setHTML(b) ;	
	}

	public function get label():String 
	{
		return getLabel() ;	
	}

	public function set label(s:String) 
	{
		setLabel(s) ;	
	}
		
	public function get multiline():Boolean 
	{ 
		return getMultiline() ; 
	}
	
	public function set multiline(b:Boolean) 
	{ 
		setMultiline(b); 
	}
	
	public function get text():String 
	{
		return getText() ;	
	}

	public function set text(s:String) 
	{
		setText(s) ;	
	}

	// ----o Public Methods

	public function getAutoSize():Boolean 
	{
		return _autoSize ;
	}

	public function getHTML():Boolean 
	{
		return _html ;
	}
	
	public function getLabel():String 
	{
		return _label || "" ;
	}

	public function getMultiline():Boolean 
	{ 
		return _multiline ; 
	}
	
	public function getText():String 
	{
		return getLabel() ;
	}

	public function setAutoSize(b:Boolean):Void 
	{
		_autoSize = b ;
		update() ;
	}

	public function setHTML(b:Boolean):Void 
	{
		_html = b ;
		update() ;
	}

	public function setLabel(str:String):Void 
	{
		_label = str.toString() ; 
		viewLabelChanged() ;
		update() ;
		dispatchEvent(new UIEvent( UIEventType.LABEL_CHANGE ) ) ;
	}
	
	public function setMultiline(b:Boolean):Void 
	{ 
		_multiline = b ;
		update() ;
	}
	
	public function setText(str:String):Void 
	{
		setLabel(str) ;
	}

	public function viewLabelChanged():Void 
	{
		// override this method when label property change
	}

	// ----o Private Properties
	
	private var _autoSize:Boolean ;
	private var _html:Boolean ;
	private var _label:String ;
	private var _multiline:Boolean ;
	
}

