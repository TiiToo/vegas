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

/** AbstractView

	AUTHOR

		Name : AbstractView
		Package : vegas.util.mvc
		Version : 1.0.0.0
		Date :  2006-02-08
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
	
		CoreObject → AbstractView

	IMPLEMENTS 
	
		IView, IFormattable
		
	IMPLEMENTS 
	
		EventListener, IFormattable, IHashable, IView

**/

import vegas.core.CoreObject;
import vegas.events.Event;
import vegas.util.mvc.AbstractModel;
import vegas.util.mvc.IController;
import vegas.util.mvc.IModel;
import vegas.util.mvc.IView;

class vegas.util.mvc.AbstractView extends CoreObject implements IView {

	// ----o Constructeur
	
	private function AbstractView(oModel:IModel, oController:IController, mcContainer:MovieClip) {
		setModel(oModel) ;
		setController(oController) ;
		setViewContainer(mcContainer) ;
	}
	
	// ----o Public Methods
	
	public function getController():IController {
		return _oController ;
	}
	
	public function getViewContainer():MovieClip {
		return _mcContainer ;
	}
	
	public function handleEvent(e:Event) {
		//
	}
	
	public function registerWithModel( oModel:IModel ):Void {
		AbstractModel( oModel ).addView(this);
	}
	
	public function setController(oController:IController):Void {
		_oController = oController;
	}
	
	public function setModel(oModel:IModel):Void {
		registerWithModel( oModel ) ;
	}
	
	public function setViewContainer(mcContainer:MovieClip):Void {
		_mcContainer = mcContainer ? mcContainer : _root ;
	}

	// ----o Private Properties
	
	private var _mcContainer:MovieClip ;
	private var _oController:IController ;
	private var _oModel:IModel ;
	
	
}