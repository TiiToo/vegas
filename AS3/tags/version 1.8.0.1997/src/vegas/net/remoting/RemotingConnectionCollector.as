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

package vegas.net.remoting
{
    import vegas.net.remoting.RemotingConnection;
    
    import system.data.maps.HashMap;
    
    /**
     * This collector use a Map to register all RemotingConnection in the application.
     */
    public class RemotingConnectionCollector
    {
        /**
         * Removes all RemotingConnection reference in the collector.
         */
        public static function clear():void
        {
            _map.clear() ;
        }
        
        /**
          * Returns <code class="prettyprint">true</code> if the collector contains the RemotingConnection register with the name passed in argument.
          * @return <code class="prettyprint">true</code> if the collector contains the RemotingConnection register with the name passed in argument.
          */
        public static function contains( sName:String ):Boolean 
        {
            return _map.containsKey( sName ) ;
        }

        /**
         * Returns the RemotingConnection reference with the name passed in argument.
         * @return the RemotingConnection reference with the name passed in argument.
         */
        public static function get( name:String ):RemotingConnection 
        {
            if (!contains(name) ) 
            {
                throw new Error("[RemotingConnectionCollector].get(\"" + name + "\"). Can't find RemotingConnection instance." ) ;
            }
            return RemotingConnection(_map.get(name)) ;
        }
        
        /**
         * Insert a RemotingConnection in the collector and indexed it with the string name in the first parameter.
         * @param name the name of the RemotingConnection object to register it.
         * @param rc the RemotingConnection reference. 
         */
        public static function insert( name:String, rc:RemotingConnection ):Boolean 
        {
            if ( contains(name) ) 
            {
                throw new Error("[RemotingConnectionCollector].insert(). A RemotingConnection instance is already registered with '" + name + "' name." ) ;
            }
            return Boolean( _map.put(name, rc) ) ;
        }
        
        /**
          * Returns <code class="prettyprint">true</code> if the collector is empty.
         * @return <code class="prettyprint">true</code> if the collector is empty.
         */
        public static function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Removes the RemotingConnection in the collector specified by the argument <code class="prettyprint">sName</code>.
          */
        public static function remove(sName:String):void
        {
            _map.remove(sName) ;
        }
        
        /**
         * Returns the number of elements in the collector.
         * @return the number of elements in the collector.
         */
        public static function size():uint
        {
            return _map.size() ;
        }
        
        /**
         * @private
         */
        private static var _map:HashMap = new HashMap() ;
    }
}