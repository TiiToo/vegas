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
package lunas
{
    import system.data.maps.HashMap;
    
    /**
     * This collector use a Map to register all Displays in the application.
     * @deprecated Use now the IoC factory !!
     */
    public class StyleCollector
    {
        /**
         * Removes all elements in the StyleCollector.
         */
        public static function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the StyleCollector contains the specified id.
         * @return <code class="prettyprint">true</code> if the StyleCollector contains the specified id.
         */    
        public static function contains( id:* ):Boolean 
        {
            return _map.containsKey( id ) ;
        }
        
        /**
         * Returns the IStyle object register in the collector with the id passed-in argument.
         * @return the IStyle object register in the collector with the id passed-in argument.
         */
        public static function get( id:* ):Style 
        {
            if ( !contains( id ) ) 
            {
                throw new ArgumentError("[StyleCollector].get('" + id + "'). Can't find IStyle instance." ) ;
            } ;
            return _map.get( id ) as Style ;    
        }
        
        /**
         * Insert a IStyle with an unique id into the StyleCollector.
         * @param id the Id of the IStyle to register
         * @param style The IStyle object to insert in the collector.
         * @throws ArgumentError if the specified 'id' is already register in the collector. 
         */
        public static function insert( id:*, style:Style ):Boolean 
        {
            if ( contains(id) )
            { 
                throw new ArgumentError("[StyleCollector] insert method failed. An IStyle instance is already registered with '" + id + "' id." ) ;
            }
            return _map.put(id, style) == null  ;
        }
        
        /**
         * Returns 'true' if the StyleCollector is 'empty'.
         * @return 'true' if the StyleCollector is 'empty'.
         */
        public static function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Removes the specified IStyle object with the passed-in id value into the StyleCollector.
         */
        public static function remove( id:* ):void
        {
            _map.remove( id ) ;
        }
        
        /**
         * Returns the size of the StyleCollector.
         * @return the size of the StyleCollector.
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