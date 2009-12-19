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

package vegas.media
{
    import system.data.maps.HashMap;
    
    /**
     * This collector use a Map to register all Displays in the application.
     */
    public class SoundCollector
    {
        /**
         * Insert a CoreSound object with an unique id into the SoundCollector.
         * @param id the Id of the display to register
         * @param sound The CoreSound object to insert in the collector.
         */
        public static function add( id:*, sound:CoreSound ):Boolean 
        {
            if ( contains(id) ) 
            {
                throw new ArgumentError("[SoundCollector] insert method failed. A CoreSound instance is already registered with '" + id + "' name." ) ;
            }
            return _map.put(id, sound) == null  ;
        }
        
        /**
         * Clear the SoundCollector.
         */
        public static function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns 'true' if the SoundCollector contains the display's id.
         * @return 'true' if the SoundCollector contains the display's id.
         */    
        public static function contains( id:* ):Boolean 
        {
            return _map.containsKey( id ) ;
        }
        
        /**
         * Returns the CoreSound object register in the collector with the id passed-in argument.
         * @return the CoreSound object register in the collector with the id passed-in argument.
         */    
        public static function get( id:* ):CoreSound 
        {
            if ( !contains( id ) ) 
            {
                throw new ArgumentError("[SoundCollector].get('" + id + "'). Can't find CoreSound instance." ) ;
            }
            return _map.get( id ) as CoreSound ;
        }
        
        
        /**
         * Returns 'true' if the SoundCollector is 'empty'.
         * @return 'true' if the SoundCollector is 'empty'.
         */
        public static function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Removes the specified CoreSound object into the SoundCollector.
         */
        public static function remove( id:* ):void
        {
            _map.remove(id) ;
        }
        
        /**
         * Returns the size of the SoundCollector.
         * @return the size of the SoundCollector.
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