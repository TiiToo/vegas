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
    
    import flash.text.TextField;    

    /**
     * Provides a logger target that uses a TextField to output log messages.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.logging.ILogger ;
     * import vegas.logging.ITarget ;
     * import vegas.logging.Log ;
     * import vegas.logging.LogEvent ;
     * import vegas.logging.LogEventLevel ;
     * import vegas.logging.targets.TextFieldTarget ;
     * 
     * import flash.text.TextField ;
     * import flash.text.TextFormat ;
     * 
     * var field:TextField = new TextField() ;
     * 
     * field.x      = 10 ;
     * field.y      = 10 ;
     * field.width  = 650 ;
     * field.height = 400 ;
     * field.defaultTextFormat = new TextFormat("Courier New", 11) ;
     * field.background = true ;
     * field.backgroundColor = 0xFFFFFF ;
     * field.border = true ;
     * field.borderColor = 0x999999 ;
     * field.multiline = true ;
     * field.wordWrap  = true ;
     * 
     * addChild(field) ;
     * 
     * // setup writer
     * var target:TextFieldTarget = new TextFieldTarget(field) ;
     * 
     * target.filters = ["vegas.*"] ;
     * target.includeDate  = true ;
     * target.includeTime  = true ;
     * target.includeLevel = true ;
     * 
     * target.includeCategory = true ;
     * target.includeLines = true ;
     * target.level = LogEventLevel.ALL ; // LogEventLevel.DEBUG (only the debug logs).
     * 
     * var logger:ILogger = Log.getLogger("vegas.test") ;
     * logger.log(LogEventLevel.DEBUG, "here is some myDebug info : {0} and {1}", 2.25 , true) ;
     * logger.fatal("Here is some fatal error...") ;
     * 
     * target.includeDate = false ;
     * target.includeTime = false ;
     * target.includeCategory = false ;
     * logger.info("[{0}, {1}, {2}]", 2, 4, 6) ;
     * </pre>
     */
    public class TextFieldTarget extends LineFormattedTarget 
    {

        /**
         * Creates a new TextFieldTarget instance.
         * @param field the TextField target.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function TextFieldTarget( field:TextField , bGlobal:Boolean = false, sChannel:String = null)
        {
            super( bGlobal, sChannel );
            this.field = field ;
        }
        
    
        /**
         * The TextField reference of this target.
         */
        public var field:TextField ;        
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, category, etc. 
         *        based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
         */
        public override function internalLog( message:* , level:LogEventLevel ):void
        {
            var txt:String = field.text || "" ;
            txt += message + "\r" ;
            field.text     = txt ;
            field.scrollV  = field.maxScrollV ;
        }        
        
    }
}
