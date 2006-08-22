/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Luna Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** GridFitType

	AUTHOR

		Name : GridFitType
		Package : asgard.text
		Version : 1.0.0.0
		Date :  2006-08-22
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		The GridFitType class defines values for grid fitting in the TextField class.

	CONSTRUCTOR
	
		Private
	
	CONSTANT SUMMARY
	
 		- static NONE:String = "none"
			Doesn't set grid fitting. GridFitType 
		
		- static PIXEL:String = "pixel"
			Fits strong horizontal and vertical lines to the pixel grid. GridFitType 
		
		- static SUBPIXEL:String = "subpixel"
			Fits strong horizontal and vertical lines to the sub-pixel grid on LCD monitors. 

*/

/**
 * GridFitType
 * @author eKameleon
 * @version 1.0.0.0
 **/
 
class asgard.text.GridFitType 
{
	
	// ----o Constructor
	
	private function GridFitType()
	{
		//
	}
	
	// ----o Constant
	
	static public var NONE:String = "none" ;
	
	static public var PIXEL:String = "pixel" ;
	
	static public var SUBPIXEL:String = "subpixel" ;

	static private var __ASPF__ = _global.ASSetPropFlags(GridFitType, null , 7, 7) ;

}