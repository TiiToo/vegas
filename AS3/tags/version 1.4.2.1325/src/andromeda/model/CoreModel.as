﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.model
{
    import system.events.CoreEventDispatcher;
    
    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">IModel</code> interface, to minimize the effort required to implement this interface.
     */
    public class CoreModel extends CoreEventDispatcher implements Model
    {
        /**
         * Creates a new CoreModel instance.
         * @param id the id of the model.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */    
        public function CoreModel( id:* = null , global:Boolean = false , channel:String = null )
        {
            super( global , channel ) ;
            _setID( id ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">id</code> of this IModelObject. This method is use to register this object in a category of models.
         * You can overrides this method to change the nature of the natural id property of this object but this hack don't modify the value of the <code class="prettyprint">id</code> property. 
         * @return the <code class="prettyprint">id</code> of this IModelObject.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
         * Sets the <code class="prettyprint">id</code> of this IModelObject.
         */
        public function set id(value:*):void
        {
            _setID( value ) ;
        }
        
        /**
         * Run the first process with this model.
         * Overrides this method if you want implement a command process.
         */
        public function run( ...arguments:Array ):void 
        {
            
        }
        
        /**
         * @private
         */
        private var _id:* ;
        
        /**
         * Internal method to register the IModel in the ModelCollector with the specified id in argument.
         * @see ModelCollector.
         */
        private function _setID( id:* ):void 
        {
            if ( ModelCollector.contains( this._id ) )
            {
                ModelCollector.remove( this._id ) ;
            }
            this._id = id ;
            if ( this._id != null )
            {
                ModelCollector.insert ( this._id, this ) ;
            }
        }
    }
}