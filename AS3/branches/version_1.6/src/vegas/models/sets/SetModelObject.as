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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.models.sets 
{
    import system.data.Collection;
    import system.data.Set;
    import system.data.sets.HashSet;
    
    import vegas.models.collections.CollectionModelObject;
    
    /**
     * This model use an internal <code class="prettyprint">Set</code> to register value objects.
     */
    public class SetModelObject extends CollectionModelObject
    {
        /**
         * Creates a new SetModelObject instance.
         * @param id the id of this model.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel (optional) the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */ 
        public function SetModelObject(id:* = null, global:Boolean = false, channel:String = null)
        {
            super( id, global, channel );
        }
        
        /**
         * Returns the internal {@code Set} of this model.
         * @return the internal {@code Set} of this model.
         */
        public function getSet():Set
        {
            return getCollection() as Set ;
        }
        
        /**
         * Initialize the internal Collection instance in the constructor of the class.
         * You can overrides this method if you want change the default HashSet use in this model.
         */
        public override function initializeCollection():Collection
        {
            return new HashSet() ;
        }
    }
}
