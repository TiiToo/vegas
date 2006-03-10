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

/* -------- ILogger

	AUTHOR

		Name : ILogger
		Package : vegas.logging
		Version : 1.0.0.0
		Date :  2005-10-12
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- debug(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.DEBUG level.
		
		- error(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.ERROR level.
		
		- fatal(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.FATAL level.
		
		- info(context, ...rest):Void
		
			Logs the specified data using the LogEvent.INFO level.
		
		- log(context, message:String, ...rest):Void
		
			Logs the specified data at the given level.
		
		- warn(context, ...rest):Void
		
			Logs the specified data using the LogEventLevel.WARN level.

	INHERIT
	
		 IFormattable > IEventDispatcher > ILogger

------------*/

import vegas.events.IEventDispatcher;

interface vegas.logging.ILogger extends IEventDispatcher {

	function debug(context):Void ;
	
	function error(context):Void ;
	
	function fatal(context):Void ;
	
	function info(context):Void ;
	
	function log(level:Number, context):Void ;
	
	function warn(context):Void ;

}