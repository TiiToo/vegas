﻿/*

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

/** AbstractController

	AUTHOR

		Name : AbstractController
		Package : vegas.util.mvc
		Version : 1.0.0.0
		Date :  2006-02-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY

		- getModel():IModel
		
		- getView():IView
		
		- setModel(oModel:IModel):Void
		
		- setView(oView:IView):Void
		
	INHERIT
	
		CoreObject → AbstractController

	IMPLEMENTS 
	
		IController, IFormattable, IHashable

**/

import vegas.core.CoreObject;
import vegas.util.mvc.IController;
import vegas.util.mvc.IModel;
import vegas.util.mvc.IView;

class vegas.util.mvc.AbstractController extends CoreObject implements IController {

	// ----o Constructeur
	
	private function AbstractController() {
		
	}
	
	// ----o Public Methods
	
	public function getModel():IModel {
		return _oModel ;
	}
	
	public function getView():IView {
		return _oView ;
	}
	
	public function setModel(oModel:IModel):Void {
		_oModel = oModel ;
	}
	
	public function setView(oView:IView):Void {
		_oView = oView ;
	}

	// ----o Private Properties
	
	private var _oView:IView ;
	private var _oModel:IModel ;
	
	
}