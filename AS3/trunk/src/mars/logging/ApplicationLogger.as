/*

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
package mars.logging 
{
	import vegas.logging.Log;
	import vegas.logging.LogEventLevel;
	import vegas.logging.targets.LuminicTarget;
	import vegas.logging.targets.SOSTarget;
	import vegas.logging.targets.TraceTarget;	

	/**
	 * This static class initialize the logging tools in the application.
	 * @author eKameleon
	 */
	public class ApplicationLogger
	{
		
		/**
		 * The application global logger id.
		 */
		public static var APPLICATION_CHANNEL:String = "application" ;		
				
		/**
		 * Indicates if the Luminic FlashInspector console is used.
		 */
		public static var USE_LUMINIC:Boolean = false ;

		/**
		 * Indicates if the SOS console is used.
		 */
		public static var USE_SOS:Boolean = false ;
		
		/**
		 * Indicates if the trace target is used.
		 */
		public static var USE_TRACE:Boolean = false ;
		
		/**
	 	 * The vegas errors logger id.
		 */
		public static var VEGAS_ERRORS_CHANNEL:String = "vegas.errors.*" ;		
		
		/**
		 * Initialize the global Logger singleton.
		 */
		public static function initialize( applicationChannel:String=null ):void
		{
		
			if ( applicationChannel == null )
			{
				applicationChannel = APPLICATION_CHANNEL ;
			}
			
			var filters:Array = [ applicationChannel , VEGAS_ERRORS_CHANNEL ] ;
			
			if ( USE_LUMINIC )
			{
				var luminicTarget:LuminicTarget = new LuminicTarget() ;
				luminicTarget.filters = filters ;
				luminicTarget.isCollapse = false ;
				luminicTarget.includeTime = true ;
				luminicTarget.level = LogEventLevel.ALL ;
				Log.addTarget(luminicTarget) ;
			}
			
			if ( USE_SOS )
			{
				var sosTarget:SOSTarget = new SOSTarget( applicationChannel ) ;
				sosTarget.filters      = ["*"] ;
				sosTarget.includeLines = true ;
				sosTarget.includeTime  = true ;
				sosTarget.level        = LogEventLevel.ALL ;
				Log.addTarget(sosTarget) ;
			}			
			
			if ( USE_TRACE )
			{
				var traceTarget:TraceTarget = new TraceTarget() ;
				traceTarget.filters         = ["*"] ;
				traceTarget.includeLines    = true ;
				traceTarget.includeTime     = true ;
				traceTarget.level           = LogEventLevel.ALL ;
				Log.addTarget(traceTarget) ;
			}
			
			LOGGER = Log.getLogger( applicationChannel ) ;
			
		}
		
	}

}
