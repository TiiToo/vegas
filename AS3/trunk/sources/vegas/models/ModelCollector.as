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

package vegas.models
{
    import system.data.maps.HashMap;
    
    /**
     * This collector use a Map to register all Model in the application.
     */
    public class ModelCollector
    {
        /**
         * Removes all Model references in the collector.
         */
        public static function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the collector contains the Model register with the id passed in argument.
         * @param id the id of the model register in the model.
         * @return <code class="prettyprint">true</code> if the collector contains the Model register with the id passed in argument.
         */
        public static function contains( id:* ):Boolean 
        {
            return _map.containsKey( id ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the collector contains the Model passed in argument.
         * @param model the Model to search in the model.
         * @return <code class="prettyprint">true</code> if the collector contains the Model passed in argument.
         */
        public static function containsModel( model:Model ):Boolean
        {
            return _map.containsValue( model ) ;
        }
        
        /**
         * Returns the Model reference with the name passed in argument.
         * @return the Model reference with the name passed in argument.
         * @throws ArgumentError if the the specified name isn't register in the collector.
         */
        public static function get( id:* ):Model 
        {
            if (!contains( id ) ) 
            {
                throw new ArgumentError("[ModelCollector] get(" + id + ") failed. The specified id isn't register in the collector." ) ;
            } ;
            return _map.get( id ) as Model ;
        }
        
        /**
         * Insert a Model in the collector and indexed it with the string name in the first parameter.
         * @param id the index of the model to register.
         * @param model the Model reference.
         * @return <code class="prettyprint">true</code> if the  specified model is inserted in the model.
         * @throws ArgumentError if the specified name is already registered in the collector.
         */
        public static function insert( id:* , model:Model):Boolean 
        {
            if ( contains(id) ) 
            {
                throw new ArgumentError( "[ModelCollector] insert method failed. An Model instance is already registered with '" + id + "' id." ) ;
            } ;
            return _map.put(id, model) == null ;
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
         * Removes the Model in the collector specified by the argument <code class="prettyprint">id</code>. 
         * @param id the id of the model to unregister in the collector.
         */
        public static function remove( id:* ):void 
        {
            _map.remove( id ) ;
        }
        
        /**
         * Returns the number of elements in the collector.
         * @return the number of elements in the collector.
         */
        public static function size():int 
        {
            return _map.size() ;
        }
        
        /**
         * Internal HashMap of all Model in the application.
         */
        private static var _map:HashMap = new HashMap() ;
    }

}