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

/** AbstractModel

	AUTHOR

		Name : AbstractModel
		Package : vegas.util.mvc
		Version : 1.0.0.0
		Date :  2005-11-26
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- addView(listener:EventListener):Void
		
		- clone()
		
		- notifyChanged(ev:ModelChangedEvent):Void
		
		- removeView(listener:EventListener):Void

	IMPLEMENTS 
	
		ICloneable, IEventTarget, IEventDispatcher, IFormattable, IHashable, IModel

	INHERIT
	
		Object > CoreObject > AbstractModel

**/

import vegas.events.EventDispatcher;
import vegas.events.ModelChangedEvent;
import vegas.util.mvc.IModel;
import vegas.util.mvc.IView;

class vegas.util.mvc.AbstractModel extends EventDispatcher implements IModel {

	// ----o Constructeur
	
	private function AbstractModel() {
		//
	}
	
	// ----o Public Methods
	
	public function addView(view:IView):Void {
		addGlobalEventListener(view) ;
	}
	
	public function clone() {
		//
	}
	
	public function notifyChanged(ev:ModelChangedEvent):Void {
		dispatchEvent(ev) ;
	}
	
	public function removeView(view:IView):Void {
		removeGlobalEventListener(view) ;
	}


}