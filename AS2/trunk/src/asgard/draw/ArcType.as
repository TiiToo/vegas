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

/** FillType

	AUTHOR

		Name : FillType
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2006-03-28
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- CHORD:String
		
		- PIEL:String

	METHOD SUMMARY
	
		- static validate(type:String):Boolean

------------*/

class asgard.draw.ArcType {

	// ----o Constructor

    private function ArcType() {
        //
    }

	// ----o Public Properties

	static public var CHORD:String = "CHORD" ;
	
	static public var PIE:String = "PIE" ;

	static private var __ASPF__ = _global.ASSetPropFlags(ArcType, null, 7, 7) ;

	// ----o Public Methods
	
	static public function validate(type:String):Boolean {
		return (type == ArcType.CHORD || type == ArcType.PIE) ;
	}
	
}