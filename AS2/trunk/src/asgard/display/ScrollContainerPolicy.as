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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Values for the horizontalScrollPolicy and verticalScrollPolicy properties of the Container and ScrollControlBase classes.
 * @author eKameleon
 */
class asgard.display.ScrollContainerPolicy extends Number 
{

	/**
	 * Creates a new ScrollContainerPolicy instance.
	 */
    function ScrollContainerPolicy(n:Number, sName:String) 
    {
		super(n) ;
		_sName = sName ;
	}
	
	/**
	 * Show the scrollbar if the children exceed the owner's dimension.
	 */
	public static var AUTO:ScrollContainerPolicy = new ScrollContainerPolicy(1, "auto") ;

	/**
	 * Specifies no scroll activity.
	 */
	public static var NONE:ScrollContainerPolicy = new ScrollContainerPolicy(0, "none") ;
	
	/**
	 * Never show the scrollbar.
	 */
	public static var OFF:ScrollContainerPolicy = new ScrollContainerPolicy( 20, "on") ;
	
	/**
	 * Always show the scrollbar.
	 */
	public static var ON:ScrollContainerPolicy = new ScrollContainerPolicy( 10, "on") ;
	
	/**
	 * Scroll the container when an item is selected in the container.
	 */
	public static var SCROLL_ON_CLICK:ScrollContainerPolicy = new ScrollContainerPolicy(2, "scroll_on_click") ;
	
	/**
	 * The scroll is active with SCROLL_ON_CLICK and AUTO mode.
	 */
	public static var FULL:ScrollContainerPolicy = new ScrollContainerPolicy(AUTO | SCROLL_ON_CLICK, "full") ;

	private static var __ASPF__ = _global["ASSetPropFlags"](ScrollContainerPolicy, null , 7, 7) ;

	/**
	 * Returns {@code true} if the object passed in argument is a ScrollContainerPolicy defined in static in this class.
	 */
	public static function validate(o):Boolean 
	{
		switch(o) 
		{
			case NONE :
			case AUTO : 
			case SCROLL_ON_CLICK :
			case FULL : 
			{
				return true ;
			}
			default :
			{
				return false ;
			}
		}
	}

	private var _sName:String ;

}