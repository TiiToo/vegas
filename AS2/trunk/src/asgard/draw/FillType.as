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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** FillType

	AUTHOR

		Name : FillType
		Package : asgard.draw
		Version : 1.0.0.0
		Date :  2005-12-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- LINEAR:FillType
		
		- RADIAL:FillType

------------*/

class asgard.draw.FillType {

	// ----o Constructor

    private function FillType() {
        //
    }

	// ----o Static Public Properties

	static public var LINEAR:String = "linear" ;
	
	static public var RADIAL:String = "radial" ;
	
	static private var __ASPF__ = _global.ASSetPropFlags(FillType, null, 7, 7) ;
	
}