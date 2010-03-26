/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
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
package lunas.groups 
{
    import lunas.Groupable;
    
    import system.data.Map;
    import system.data.maps.HashMap;
    
    import flash.events.Event;
    
    /**
     * This abstract class defined a skeletal implementation to create component's groups.
     */
    public dynamic class CoreGroup 
    {
        /**
         * Creates a new CoreGroup instance.
         */
        public function CoreGroup()
        {
            groups = initMap() ;
        }
        
        /**
         * The internal MultiHashSet reference of this manager.
         */
        public var groups:Map ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified group name exist.
         * @return <code class="prettyprint">true</code> if the specified group name exist.
         */
        public function contains( groupName:String ):Boolean
        {
            return groups.containsKey(groupName) ;
        }
        
        /**
         * Returns the current IGroupable object selected with the passed-in group name.
         */
        public function get( groupName:String ):Groupable
        {
            return groups.get(groupName) ;
        }
        
        /**
         * Handles the event.
         */
        public function handleEvent( e:Event ):void 
        {
            var target:Groupable = e.target as Groupable ;
            if ( target != null )
            {
                this["select"]( target ) ;
            }
        }
        
        /**
         * Initialize the internal map of this group manager. This method is used in the constructor of this class.
         * You can overrides this method.
          */
        public function initMap():Map
        {
            return new HashMap() ;
        }
        
        /**
         * Selects the passed-in IGroupable item.
         * Overrides this method.
         */
        prototype.select = function( item:Groupable ):void
        {
            // overrides this method.
        };
        
        /**
         * Returns the <code class="prettyprint">Map</code> representation of the groups.
         * @return the <code class="prettyprint">Map</code> representation of the groups.
         */
        public function toMap():Map
        {
            return groups.clone() ;
        }
        
        /**
         * Unselect the specified item in argument. 
         * This item can be a IGroupable object or the String representation of the name's group to unselect.
         * Overrides this method.
         */
        prototype.unSelect = function( item:* ):void 
        {
            // overrides this method.
        };
    }
}
