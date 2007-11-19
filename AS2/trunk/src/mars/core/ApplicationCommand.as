﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is MarS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.display.DisplayObjectCollector;

import mars.core.ApplicationList;
import mars.display.abstract.ILoaderDisplay;

/**
 * This class provides a static set of methods to launch global commands in the application.
 * @author eKameleon
 */
class mars.core.ApplicationCommand
{

	/**
	 * Change the loader's values (message and percent).
	 */
	public static function changeLoader( message , percent:Number ):Void
	{
		
		percent = (percent > 0 ) ? percent : 0 ;

		if ( DisplayObjectCollector.contains( ApplicationList.APPLICATION_LOADER ) ) 
		{
			
			var loader:ILoaderDisplay = ILoaderDisplay( DisplayObjectCollector.get(ApplicationList.APPLICATION_LOADER) ) ;
			
			if ( !loader.isVisible() )
			{
				showLoader() ;	
			}
			
			loader.setLoader( message , percent ) ;
			
		}
	}

	/**
	 * Hide the loader display of the application.
	 */
	public static function hideLoader():Void
	{
		if ( ! _lockLoader )
		{
			unprotectScreen() ;
			if ( DisplayObjectCollector.contains( ApplicationList.APPLICATION_LOADER ) ) 
			{
				DisplayObjectCollector.get(ApplicationList.APPLICATION_LOADER).hide();
			}
		}
	}
	
	/**
	 * Returns (@code true} if the loader is locked.
	 * @return (@code true} if the loader is locked.
	 */
	public static function isLockLoader():Boolean
	{
		return _lockLoader ;	
	}

	/**
	 * Locks the loader. The loader is alway visible.
	 */
	public static function lockLoader():Void
	{
		_lockLoader = true ;
		showLoader() ;	
	}
	
	/**
	 * Protect the application with the protect screen.
	 */
	public static function protectScreen():Void
	{
		DisplayObjectCollector.get(ApplicationList.PROTECT_SCREEN).show() ;
	}

	/**
	 * Show the loader display of the application.
	 */
	public static function showLoader():Void
	{
		protectScreen() ;
		if ( DisplayObjectCollector.contains( ApplicationList.APPLICATION_LOADER ) ) 
		{
			DisplayObjectCollector.get(ApplicationList.APPLICATION_LOADER).show() ;
		}
	}
	
	/**
	 * Unlocks the loader. The loader is visible or invisible when the user use the hideLoader or showLoader methods.
	 * @param b (optional) the boolean flag value to indicates if the loader must be visible or not after the unlock process of the loader.
	 */
	public static function unlockLoader( b:Boolean ):Void
	{
		_lockLoader = false ;
		if ( b != null )
		{	
			if ( b == true )
			{
				showLoader() ;
			}
			else
			{
				hideLoader() ;	
			}
		}
	}
	
	/**
	 * Unprotect the application with the protect screen.
	 */
	public static function unprotectScreen():Void
	{
		DisplayObjectCollector.get(ApplicationList.PROTECT_SCREEN).hide() ;
	}
	
	/**
	 * This internal value lock the loader. The loader is always visible.
	 */
	private static var _lockLoader:Boolean ;

}