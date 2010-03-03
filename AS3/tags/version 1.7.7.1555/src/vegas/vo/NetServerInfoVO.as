/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.vo 
{
    import system.Reflection;
    import system.Serializable;
    import system.eden;
    
    import flash.net.registerClassAlias;
    
    /**
     * This value object contains information sending by a server.
     * @example
     * <pre class="prettyprint">
     * import vegas.vo.NetServerInfoVO ;
     * 
     * var info:NetServerInfoVO = new NetServerInfoVO() ;
     * info.application = "local" ;
     * info.level       = "error" ;
     * info.code        = "application_error" ;
     * info.description = "An error is invoked in the application" ;
     * info.line        = 3 ;
     * info.methodName  = "noMethod" ;
     * info.serviceName = "noService" ;
     * 
     * trace("toString  : " + info) ;
     * trace("toSource  : " + info.toSource()) ;
     * </pre>
     */
    public class NetServerInfoVO extends SimpleValueObject implements Serializable
    {
        /**
         * Creates a new NetServerInfoVO instance. 
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored
         */
        public function NetServerInfoVO( init:Object = null )
        {
            super(init) ;
        }
        
        /**
         * This object exist if the server return an application error object. 
         * This property exist with FMS when the SSAS <code class="prettyprint">application.rejectConnection()</code> method is invoked. 
           */
        public var application:* ;
        
        /**
         * The code of the error.
          */
        public var code:String ;
        
        /**
         * The default description of the error.
         */
        public var description:String ;
        
        /**
         * The level of this information object.
         */
        public var level:String ;
        
        /**
         * The line number of the error.
         */
        public var line:Number ;
        
        /**
         * The name of the method called.
         */
        public var methodName:String ;
        
        /**
         * The name of the service used.
         */
        public var serviceName:String ;
        
        /**
         * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
         */
        public static function register( aliasName:String="NetServerInfoVO" ):void
        {
            registerClassAlias( aliasName , NetServerInfoVO ) ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object
        {
            return { code:code , description:description , level:level, line:line, methodName:methodName, serviceName:serviceName , application:application } ;
        }    
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "(" + eden.serialize(toObject()) + ")" ;
        }
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if (code != null && code.length > 0)
            {
                str += " code:" + code ;
            }
            if (level != null && level.length > 0)
            {
                str += " level:" + level;
            }
            if (description != null && description.length > 0)
            {
                str += " description:" + description;
            }
            if ( !isNaN(line) && line.toString().length > 0)
            {
                str += " line:" + line;
            }
            if (application != null)
            {
                str += " application:" + application  ;
            }
            str += "]" ;
            return str ;
        }
    }
}
