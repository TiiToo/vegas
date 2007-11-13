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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import vegas.logging.targets.LineFormattedTarget;

/**
 * Provides a logger target that uses a TextField to output log messages.
 * <p><b>Example :</b></p>
 * <p>
 * {@code
 * import vegas.logging.ILogger ;
 * import vegas.logging.ITarget ;
 * import vegas.logging.Log ;
 * import vegas.logging.LogEvent ;
 * import vegas.logging.LogEventLevel ;
 * import vegas.logging.targets.TextFieldTarget ;
 * 
 * var field:TextField = createTextField("field", 1000, 10, 10, 650, 400 ) ;
 * field.setNewTextFormat( new TextFormat("Courier New", 11) ) ;
 * field.background = true ;
 * field.backgroundColor = 0xFFFFFF ;
 * field.border = true ;
 * field.borderColor = 0x999999 ;
 * 
 * // setup writer 
 * var fieldTarget:TextFieldTarget = new TextFieldTarget() ;
 * 
 * fieldTarget.filters = ["vegas.logging.*"] ;
 * fieldTarget.includeDate = true ;
 * fieldTarget.includeTime = true ;
 * fieldTarget.includeLevel = true ;
 * fieldTarget.includeCategory = true ;
 * fieldTarget.includeLines = true ;
 * fieldTarget.level = LogEventLevel.ALL ; // LogEventLevel.DEBUG (only the debug logs).
 * 
 * // get a logger for the 'myDebug' category 
 * // and send some data to it.
 * 
 * var logger:ILogger = Log.getLogger("vegas.logging.targets") ;
 * logger.log(LogEventLevel.DEBUG, "here is some myDebug info : {0} and {1}", 2.25 , true) ; 
 * logger.fatal("Here is some fatal error...") ; 
 * 
 * fieldTarget.includeDate = false ;
 * fieldTarget.includeTime = false ;
 * fieldTarget.includeCategory = false ;
 * logger.info("[{0}, {1}, {2}]", 2, 4, 6) ; 
 * }
 * </p>
 * @author eKameleon
 */
class vegas.logging.targets.TextFieldTarget extends LineFormattedTarget 
{
	
	/**
	 * Creates a new TextFieldTarget instance.
	 */
	public function TextFieldTarget( field:TextField ) 
	{
		this.field = field ;
	}
	
	/**
	 * The TextField reference of this target.
	 */
	public var field:TextField ;
	
	/**
     * Descendants of this class should override this method to direct the specified message to the desired output.
     *
     * @param message String containing preprocessed log message which may include time, date, category, etc. 
     *        based on property settings, such as <code>includeDate</code>, <code>includeCategory</code>, etc.
	 */
	public /*override*/ function internalLog( message , level:Number ):Void
	{
		var txt:String = field.text || "" ;
		txt += message + "\r" ;
		field.text   = txt ;
		field.scroll = field.maxscroll ;
	}
	
}