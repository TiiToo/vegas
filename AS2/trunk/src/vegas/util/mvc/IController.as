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

/** IController [Interface]

	AUTHOR

		Name : IController
		Package : vegas.util.mvc
		Version : 1.0.0.0
		Date :  2006-02-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- getModel():IModel
		
		- getView():IView
		
		- setModel(oModel:IModel):Void
		
		- setView(oView:IView):Void
	
**/

import vegas.util.mvc.IModel;
import vegas.util.mvc.IView;

interface vegas.util.mvc.IController {
	
	function getModel():IModel ;
	
	function getView():IView ;
	
	function setModel(oModel:IModel):Void ;
	
	function setView(oView:IView):Void ;
	
}