 /*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.system.Application;

import flash.external.ExternalInterface;

import vegas.errors.Warning;
import vegas.util.StringUtil;

/**
 * Track application/site internal navigation throw Google Analytic system.
 * <p>More informations on http://www.google.com/analytics/</p>
 * <p>Link passed to tracker is check before processing :<br />
 * At the end, link must start with a {@code /} char with no space chars at the end.
 * </p>
 * <p>Analytics tracking code must be placed in your HTML code above any of these calls.<br />
 * <b>Example</b>
 * {@code
 *    
 *    //<![CDATA[
 *    <script type="text/javascript" src="http://www.google-analytics.com/urchin.js"></script>
 *    _uacct = "YOUR_GOOGLE_TRACK_ID";
 *    urchinTracker();	
 *    //]]>
 *    
 * }
 * </p>
 * <p>Check if {@code ExternalInterface.available}.<br />
 * if {@code true}, use {@code ExternalInterface.call}, otherwise use {@code getURL( "javascript:"" )}.
 * </p>
 * Thanks Romain Ecarnot with this Fever version of this class who inspire me this version.
 * @see asgard.system.Application
 * @see vegas.util.StringUtil
 * @author eKameleon
 */
class asgard.net.GoogleAnalytics 
{

	/** 
	 * Default logical directory structure for downloads links.
	 */
	public static var DOWNLOAD_TRACK:String = "downloads";
	
	/** 
	 * Default logical directory structure for outbound links.
	 */
	public static var OUTGOING_TRACK:String = "outgoing";
		
	/**
	 * The name of the application.
	 */
	public static var NAME:String = "" ;

	/**
	 * Track the passed-in {@code link}.
	 */
	public static function track( link : String ) : Void
	{
		_track( _getCorrectLink( link ) );	
	}
	
	/**
	 * Track the passed-in {@code link} as an outbound link.
	 * <p>Logical link structure can me modify with {@link #OUTGOING_TRACK} property.</p>
	 * @param link the link to be track
	 */
	public static function trackOutBound( link : String ):Void
	{
		_track( _getCorrectLink( link, OUTGOING_TRACK ) );
	}
	
	/**
	 * Track passed-in {@code link} as a download link.
	 * <p>Logical link structure can me modify with {@link #DOWNLOAD_TRACK} property.</p>
	 * @param link the link to be track
	 */
	public static function trackDownload( link : String ):Void
	{
		_track( _getCorrectLink( link, DOWNLOAD_TRACK ) );		
	}

	/**
	 * Creates a correct Google Analytic track link.
	 */
	private static function _getCorrectLink( link : String, baseLink : String ) : String
	{
		if( link )
		{
			link = "/" + StringUtil.trim( link , String(EMPTY_CHARS + "/").split("") );
			link = StringUtil.replace( link, ' ', '_' );
			link = StringUtil.replace( link, 'http://', '' );
			link = StringUtil.replace( link, 'https://', '' );
			if( baseLink ) 
			{
				link = '/' + baseLink + link;
			}
		}
		else 
		{
			link = '';
		}
		
		var appName:String = (NAME.length > 0) ? NAME : '' ;
		appName = ( appName ) ? ( '/' + StringUtil.trim( appName, String(EMPTY_CHARS + "/").split("") ) ) : '' ;	
		
		var result : String = appName.toLowerCase() + link; 
		return result;
	}

	/**
	 * Call {@code urchinTracker()} javascript method with correct link.
	 * <p>Check if {@code ExternalInterface.available}.<br />
	 * if {@code true}, use {@code ExternalInterface.call}, otherwise use {@code getURL( "javascript:"" )}.
	 * </p>
	 * @param link Correct link built with {@link #_buildCorrectLink()}
	 * @throws Warning if the application isn't online.
	 */
	private static function _track( link : String ) : Void
	{
		if( Application.isOnline() && ( link.length > 2 ) )
		{
			if( ExternalInterface.available ) 
			{
				ExternalInterface.call( 'urchinTracker', link);
			}
			else 
			{
				getURL("javascript:urchinTracker('"+ link +"');");
			}
		}
		else
		{
			throw new Warning( "GoogleAnalytic track failed, your application isn't online : " + link ) ;	
		}
	}

	private static var EMPTY_CHARS:String = "\n\t\r " + chr(13) + chr(10);

}