/*

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

package vegas
{
    import system.Reflection;
    import system.Serializable;
    import system.logging.Log;
    import system.logging.Loggable;
    import system.logging.Logger;
    
    /**
     * CoreObject offers a default implementation of the Loggable and Serializable interfaces.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.core.CoreObject ;
     * var core:CoreObject = new CoreObject() ;
     * trace("core     : " + core) ;
     * trace("toSource : " + core.toSource()) ;
     * </pre>
     */
    public class CoreObject extends Object implements Loggable, Serializable
    {
        /**
         * Creates a new CoreObject instance.
         */
        public function CoreObject() 
        {
            _logger = Log.getLogger( Reflection.getClassPath(this) ) ;
        }
        
        /**
         * Determinates the internal <code class="prettyprint">Logger</code> reference of this <code class="prettyprint">Loggable</code> object.
         */
        public function get logger():Logger
        {
            return _logger ;
        }
        
        /**
         * @private
         */
        public function set logger( log:Logger ):void 
        {
            _logger = (log == null ) ? Log.getLogger( Reflection.getClassPath(this) ) : log ;
        }
        
        /**
         * Returns the string representation the source code of the object.
         * @return the string representation the source code of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "()" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            return "[" + Reflection.getClassName(this) + "]" ;
        }
        
        /**
         * @private
         */
        private var _logger:Logger ;
    }
}