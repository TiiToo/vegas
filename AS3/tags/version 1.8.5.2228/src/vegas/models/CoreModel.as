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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
    import system.events.CoreEventDispatcher;
    
    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">IModel</code> interface, to minimize the effort required to implement this interface.
     */
    public class CoreModel extends CoreEventDispatcher implements Model
    {
        /**
         * Creates a new CoreModel instance.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         * @param id the id of the model.
         */    
        public function CoreModel( global:Boolean = true , channel:String = null , id:* = null )
        {
            super( global , channel ) ;
            this.id = id ;
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
            _id = value ;
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
    }
}