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

package vegas.net
{
    import core.dump;
    
    import system.Serializable;
    
    /**
     * Defines the information object in a onStatus callback method.
     */
    public dynamic class NetServerInfo implements Serializable
    {
        /**
         * Creates a new NetServerInfo object.
         * @param info a primitive object with the properties 'code', 'level', 'description' and 'application'.
         */
        public function NetServerInfo( info:* = null )
        {
            if ( info != null )
            {
                description  = info.description || null ;
                code         = info.code ;
                level        = info.level ;
                application  = info.application || null ;
            }
        }
        
        /**
         * This object exist if the server return an application error object. 
         * This property exist with FMS when the SSAS <code class="prettyprint">application.rejectConnection()</code> method is invoked. 
         */
        public var application:* ;
        
        /**
         * The code of this information object.
         */
        public var code:String ;
        
        /**
         * The description of this information object.
         */
        public var description:String ;
        
        /**
         * The level of this information object.
         */
        public var level:String ;
        
        /**
         * Returns an object representation of this instance.
         * @return an object representation of this instance.
         */
        public function toObject():Object 
        {
            return { description:description, code:code, level:level , application:application } ;
        }
        
        /**
         * Returns a Eden represensation of the object.
         * @return a string representing the source code of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new vegas.net.NetServerInfo(" + dump( toObject() ) + ")" ;
        }
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public function toString():String
        {
            var s:String = "[NetServerInfo" ;
            if (code != null)
            {
                s += ",code:'" + code + "'" ;
            }
            if (level != null)
            {
                s += ",level:'" + level + "'" ;
            }
            if (description != null)
            {
                s += ",description:'" + description + "'" ;
            }
            if (application != null)
            {
                s += ",application:" + dump(application)  ;
            }
            s += "]" ;
            return s ;
        }
    }
}