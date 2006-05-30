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

/** DisplayFactory

	AUTHOR
	
		Name : DisplayFactory
		Package : vegas.util.factory
		Version : 1.0.0.0
		Date :  2005-10-15
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY

		- static attachChild( fConstructor:Function, sID:String, sName:String, nDepth:Number, mcTarget:MovieClip, init )

		- static createChild(oChild , p_name:String , p_depth:Number, p_target, p_init)

**/

import vegas.util.ConstructorUtil;
import vegas.util.TypeUtil;

class vegas.util.factory.DisplayFactory {
	
	// ----o Constructor
	
	private function DisplayFactory() {
		//
	}
	
	// ----o Static Methods
	
	static public function attachChild( fConstructor:Function, sID:String, sName:String, nDepth:Number, mcTarget:MovieClip, init ) {
		var oChild = mcTarget.attachMovie(sID, sName, nDepth) ;
		return ConstructorUtil.createVisualInstance( fConstructor, oChild, init) ;
	}
	
	static public function createChild ( oChild , p_name:String , p_depth:Number, p_target, p_init) {
		var child ;
		
		if (oChild == null) {

			child = p_target.createEmptyMovieClip(p_name, p_depth) ;
			for (var each in p_init) child[each] = p_init[each] ;
			return child ;
			
		} else if (oChild instanceof Function) {
			
			var p_class:Function = oChild ;

			if (ConstructorUtil.isSubConstructorOf(p_class, MovieClip))  {
				
				child = p_target.createEmptyMovieClip (p_name, p_depth) ;
				
			} else if (ConstructorUtil.isSubConstructorOf(p_class, TextField)) {
				
				p_target.createTextField (p_name, p_depth, 0, 0, 0, 0) ;
				child = p_target[p_name] ;
				
			}

			return ConstructorUtil.createVisualInstance(p_class, child, p_init) ;
			
		} else if (TypeUtil.typesMatch(oChild, String)) {
			
			return p_target.attachMovie(oChild, p_name, p_depth, p_init) ;
			
		}
	}
	
}