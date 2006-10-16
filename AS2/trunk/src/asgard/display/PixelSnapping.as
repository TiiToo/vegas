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

/** PixelSnapping
	
	AUTHOR
	
		Name : PixelSnapping
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2006-08-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
		
		- static ALWAYS:String = "always"
		
		- static AUTO:String = "auto"
		
		- static NEVER:String = "never" 

*/

/**
 * @author eKameleon
 */
class asgard.display.PixelSnapping 
{
	
	// ----o Constructor
	
	private function PixelSnapping()
	{
		//	
	}
	
	// ----o Constants
	
	/**
	 * [static] A constant value used in the pixelSnapping property of a Bitmap object to specify that the bitmap image is always snapped to the nearest pixel, independent of any transformation.
	 */
	static public var ALWAYS:String = "always" ;
	
	/**
	 * [static] A constant value used in the pixelSnapping property of a Bitmap object to specify that the bitmap image is snapped to the nearest pixel if it is drawn with no rotation or skew and it is drawn at a scale factor of 99.9% to 100.1%.
	 */
	static public var AUTO:String = "auto" ;
		
	/**
	 * [static] A constant value used in the pixelSnapping property of a Bitmap object to specify that no pixel snapping occurs.
	 */
	static public var NEVER:String = "never" ;
	
	
	static private var __ASPF__ = _global.ASSetPropFlags(PixelSnapping, null , 7, 7) ;
	
}