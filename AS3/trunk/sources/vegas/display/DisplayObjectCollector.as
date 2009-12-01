﻿/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.display
{
    import system.data.maps.HashMap;

    import flash.display.DisplayObject;

    /**
     * This collector use a Map to register all Displays in the application.
     */
    public class DisplayObjectCollector
    {
    
        /**
         * Clear the DisplayObjectCollector.
         */
        public static function clear():void 
        {
            _map.clear() ;    
        }
    
        /**
         * Returns 'true' if the DisplayObjectCollector contains the display's id.
         * @return 'true' if the DisplayObjectCollector contains the display's id.
         */    
        public static function contains( id:* ):Boolean 
        {
            return _map.containsKey( id ) ;    
        }

        /**
         * Returns the DisplayObject register in the collector with the id passed-in argument.
         * @return the DisplayObject register in the collector with the id passed-in argument.
         */    
        public static function get( id:* ):DisplayObject 
        {
            if ( !contains( id ) ) 
            {
                throw new ArgumentError("[DisplayObjectCollector].get('" + id + "'). Can't find DisplayObject instance." ) ;
            } ;
            return _map.get( id ) as DisplayObject ;    
        }
    
        /**
         * Insert a DisplayObject with an unique id into the DisplayObjectCollector.
         * @param id the index of the display to register
         * @param display The DisplayObject to insert in the collector.
         */
        public static function insert( id:*, display:DisplayObject ):Boolean 
        {
            if ( contains(id) ) 
            {
                throw new ArgumentError ("[DisplayObjectCollector] insert method failed. A DisplayObject instance is already registered with '" + id + "' name." ) ;
            } ;
            return _map.put(id, display) == null  ;    
        }
    
        /**
         * Returns 'true' if the DisplayObjectCollector is 'empty'.
         * @return 'true' if the DisplayObjectCollector is 'empty'.
         */
        public static function isEmpty():Boolean 
        {
            return _map.isEmpty() ;    
        }
    
        /**
         * Removes the specified DisplayObject into the DisplayObjectCollector.
         */
        public static function remove( id:* ):void     
        {
            _map.remove(id) ;
        }

        /**
         * Returns the size of the DisplayObjectCollector.
         * @return the size of the DisplayObjectCollector.
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