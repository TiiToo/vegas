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

/** ContainerController

	AUTHOR

		Name : ContainerController
		Package : lunas.display.components.container
		Version : 1.0.0.0
		Date :  2006-02-06
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- getModel():IModel
		
		- getView():IView
		
		- removeItems(items:Array):Void
		
			Méthode interne, permet de supprimer les childs dans le Container.
			Cette méthode ne change pas le modèle.
		
		- setModel(oModel:IModel):Void
		
		- setView(oView:IView):Void

	IMPLEMENTS 
	
		IController, IFormattable

	INHERIT 
	
		CoreObject → AbstractController → ContainerController

	TODO : AbstractContainerController ???

**/

import vegas.util.mvc.AbstractController;

class lunas.display.components.container.ContainerController extends AbstractController {

	// ----o Constructor

	public function ContainerController() { 
		//
	}

	// ----o Public Methods

	public function removeItems(items:Array):Void {
		var l:Number = items.length ;
		while(--l > -1) {
			var child = items[l] ;
			if (child instanceof MovieClip) {
				child.removeMovieClip() ;
			} else if (child instanceof TextField)	{
				child.removeTextField() ;
			}
		}
	}

}