﻿/*

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

package vegas.models.maps 
{
    import system.data.Map;
    import system.data.ValueObject;
    import system.data.maps.ArrayMap;
    
    /**
     * This map model object is indexed and you can select all value objects register in it with the basic <code>index</code> property.
     */
    public class IndexedMapModelObject extends MapModelObject 
    {
        /**
         * Creates a new IndexedMapModelObject instance.
         * @param id the id of this model.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel (optional) the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function IndexedMapModelObject( id:* = null , global:Boolean = true , channel:String = null )
        {
            super( id, global, channel, new ArrayMap() );
        }
        
        /**
         * Indicates the current index of the current selected value object in the model.
         */
        public function get index():int
        {
            return _index ;
        }
        
        /**
         * @private
         */
        public function set index( value:int ):void
        {
            if( value < 0 || value >= size() )
            {
                return;
            }
            var m:ArrayMap    = getMap() as ArrayMap ;
            var v:ValueObject = m.getValueAt( value ) as ValueObject ;
            if ( v )
            {
                _index = value ;
                super.setCurrentVO( v ) ;
            }
            else
            {
                _index = -1 ;
            }
        }
        
        /**
         * Clear the model.
         */
        public override function clear():void
        {
            _index = -1 ;
            super.clear() ;
        }
        
        /**
         * Initialize the internal Map instance in the constructor of the class.
         */
        public override function initializeMap():Map
        {
            return new ArrayMap() ;
        }
        
        /**
         * Removes a value object in the model.
         */
        public override function removeVO( vo:ValueObject ):void
        {
            if (vo && _vo == vo)
            {
                _index = -1   ;
                _vo    = null ;
            }
            super.removeVO( vo ) ;
        }
        
        /**
         * Sets the current <code class="prettyprint">ValueObject</code> selected in this model.
         * @throws ArgumentError If the passed-in ValueObject parameter is not register in the model.
         */
        public override function setCurrentVO( vo:ValueObject ):void
        {
            var m:ArrayMap = getMap() as ArrayMap ;
            var i:int      = m.indexOfValue(vo) ;
            if ( i > -1 )
            {
                _index = i ;
                super.setCurrentVO( vo ) ;
            }
            else
            {
                throw new ArgumentError( this + " setCurrentVO(" + vo + ") failed, the value object must be register in the model to be selected") ;
            }
        }
        
        /**
         * @private
         */
        protected var _index:int = -1 ;
    }
}
