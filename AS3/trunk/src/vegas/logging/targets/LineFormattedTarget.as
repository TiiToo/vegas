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

/** TraceTarget

	AUTHOR
	
		Name : TraceTarget
		Package : vegas.logging.targets
		Version : 1.0.0.0
		Date :  2006-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

package vegas.logging.targets
{

    import vegas.logging.AbstractTarget;
    import vegas.logging.LogEvent ;
    import vegas.logging.LogEventLevel;

    import vegas.util.* ;

    public class LineFormattedTarget extends AbstractTarget
    {
        
        // ----o Constructor
        
        public function LineFormattedTarget()
        {
            super();
        }
        
        // ----o Public Properties
        
        public var separator:String = " " ;
        
       	// ----o Public Properties

    	/**
         * Indicates if the category for this target should added to the trace.
         */
	    public var includeCategory:Boolean = false ;
	    
    	/**
         * Indicates if the date should be added to the trace.
         */
    	public var includeDate:Boolean = false;
    	
    	/**
         * Indicates if the level for the event should added to the trace.
         */
	    public var includeLevel:Boolean = false ;
	    
    	/**
         * Indicates if the line for the event should added to the trace.
         */
    	public var includeLines:Boolean = false ; 
    	
    	/**
         * Indicates if the time should be added to the trace.
         */
	    public var includeTime:Boolean = false ;
	    
	    // ----o Public Methods
	    
	   	/**
    	 * Descendants of this class should override this method to direct the specified message to the desired output.
    	 *
    	 * @param message String containing preprocessed log message which may include time, date, category, etc. 
    	 *        based on property settings, such as <code>includeDate</code>, <code>includeCategory</code>, etc.
	     */
	    public function internalLog( message:* , level:LogEventLevel ):void
	    {
	        
	        // override this method.
	        
	    }
	    
        /**
         *  This method handles a <code>LogEvent</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate
         *  format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the target's level.
         */		
		override public function logEvent(event:LogEvent):void
        {
           
            var message:* = event.message ;
            var level:String = LogEvent.getLevelString(event.level) ;
            var category:String = event.currentTarget.category ;
            
            message = formatMessage(message, level, category, new Date()) ;
            internalLog ( message , event.level ) ;
        
        }
	    
	    // ---o Protected Methods
	    
	    protected function formatDate( d:Date ):String 
	    {
		    var date:String = "" ;
        	date += getDigit(d.getDate()) ;
		    date += "/" + getDigit(d.getMonth() + 1) ;
		    date += "/" + d.getFullYear();
		    return date ;
	    }
	    
	    protected function formatLevel(level:String):String 
	    {
		    return '[' + level + ']' ;
	    }	
	    
	    protected function formatLines():String 
	    {
		    return "[" + __lineNumber++ + "]" ; 
	    }	
	
    	protected function formatMessage(message:*, level:String, category:String, date:Date):String {
	    	
	    	var msg:String = "" ;
       		
       		var d:Date = date || new Date ;
    		
    		if (includeLines) 
    		{
    		    msg += formatLines() + separator ; // lines
    		}
    		
    		if (includeDate) 
    		{
    		    msg += formatDate(d) + separator ; // date
    	    }
    		
    		if (includeTime) 
    		{
    		    msg += formatTime(d) + separator ; // time
    		}
    		
    		if (includeLevel)
    		{
    		    msg += formatLevel(level || "" ) + separator ; // level  
    		} 
    		
    		if (includeCategory) 
    		{
        		msg += (category || "") + separator ; // category
    		}
    		
    		msg += message.toString() ;
	    	
	    	return msg ;
	    	
    	}
	    
    	protected function formatTime(d:Date):String {
		    var time:String = "" ;
    		time += getDigit(d.getHours()) ;
    		time += ":" + getDigit(d.getMinutes()) ;
    		time += ":" + getDigit(d.getSeconds()) ;
    		return time ;
    	}
	    
	    protected function getDigit(n:Number):String 
	    {
		    if (isNaN(n)) return "00" ;
    		return ((n < 10) ? "0" : "") + n ;
    	}
        
       	// ----o Private Properties
	
	    private var __lineNumber:Number = 1 ;
        
    }
}