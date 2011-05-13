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

package lunas 
{
    import system.events.CoreEventDispatcher;
    
    import flash.display.DisplayObject;
    
    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">Builder</code> interface, to minimize the effort required to implement this interface.
     */
    public class CoreBuilder extends CoreEventDispatcher implements Builder
    {
        /**
         * Creates a new CoreBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function CoreBuilder( target:DisplayObject )
        {
            this.target = target ;
        }
        
        /**
         * Indicates the target reference of the component.
         */
        public function get target():DisplayObject
        {
            return _target ;
        }
        
        /**
         * @private
         */
        public function set target( target:DisplayObject ):void
        {
            if ( _target != null )
            {
                clear() ;
            }
            _target = target ;
        }
        
        /**
         * Clear the view of the component.
         */
        public function clear():void
        {
            // overrides
        }
        
        /**
         * Runs the build of the component.
         */
        public function run( ...arguments:Array ):void
        {
            // overrides
        }
        
        /**
         * Update the view of the component.
         */
        public function update():void
        {
            // overrides
        }
        
        /**
         * @private
         */
        private var _target:DisplayObject ;
    }
}
