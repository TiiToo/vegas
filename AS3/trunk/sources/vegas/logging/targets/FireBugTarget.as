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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.logging.targets 
{
    import vegas.logging.LogEventLevel;
    import vegas.logging.targets.LineFormattedTarget;
    
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;    

    /**
     * Provides a logger target that uses the FireBug console extension in Firefox to output log messages. 
     * You can download the FireBug and test this target : <a href="https://addons.mozilla.org/fr/firefox/addon/1843">https://addons.mozilla.org/fr/firefox/addon/1843</a>.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.logging.ILogger ;
     * import vegas.logging.ITarget ;
     * import vegas.logging.Log ;
     * import vegas.logging.LogEvent ;
     * import vegas.logging.LogEventLevel ;
     * import vegas.logging.targets.FireBugTarget ;
     * 
     * // setup writer
     * var target:FireBugTarget = new FireBugTarget() ;
     * 
     * target.filters = ["vegas.logging.*"] ;
     * 
     * target.includeDate     = true ;
     * target.includeTime     = true ;
     * target.includeLevel    = true ;
     * target.includeCategory = true ;
     * target.includeLines    = true ;
     * target.level           = LogEventLevel.ALL ; // LogEventLevel.DEBUG (only the debug logs).
     * 
     * // start writing log data
     * Log.addTarget(target);
     * 
     * var logger:ILogger = Log.getLogger("vegas.logging.targets") ;
     * 
     * logger.log(LogEventLevel.DEBUG, "here is some myDebug info : {0} and {1}", 2.25 , true) ;
     * logger.warn("Here is some warn message...") ;
     * logger.fatal("Here is some fatal error...") ;
     * 
     * target.includeDate = false ;
     * target.includeTime = false ;
     * target.includeCategory = false ;
     * logger.info("[{0}, {1}, {2}]", 2, 4, 6) ; 
     * </pre>
     * You must launch this example in FireFox with the FireBug console enabled. 
     */
    public class FireBugTarget extends LineFormattedTarget 
    {

        /**
         * Creates a new FireBugTarget instance.
         */
        public function FireBugTarget(bGlobal:Boolean = false, sChannel:String = null)
        {
            super( bGlobal, sChannel );
        }
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, category, etc. 
         *        based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
         */
        public override function internalLog( message:* , level:LogEventLevel ):void
        {
            var methodName:String ;
                    
            switch (level)
            {
                
                case LogEventLevel.ERROR :
                {
                    methodName = "console.error" ;
                    break ; 
                }
                case LogEventLevel.FATAL :
                {
                    methodName = "console.error" ;
                    break ; 
                }
                case LogEventLevel.INFO :
                {
                    methodName = "console.info" ;
                    break ; 
                }
                case LogEventLevel.WARN :
                {
                    methodName = "console.warn" ;
                    break ; 
                }
                default :
                {
                    methodName = "console.debug" ;
                    break ; 
                }       
                   
            }
            
            if ( ExternalInterface.available )
            {
                ExternalInterface.call( methodName, [message] ) ;
            }
            else
            {
                navigateToURL( new URLRequest("javascript:" + methodName + "('"+ message +"');") );  
            }
        }        
        
    }
}
