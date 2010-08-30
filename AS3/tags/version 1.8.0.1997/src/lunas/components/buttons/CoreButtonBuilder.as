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
package lunas.components.buttons
{
    import lunas.Builder;
    import lunas.CoreBuilder;
    
    import system.data.maps.HashMap;
    
    import flash.display.DisplayObject;
    import flash.events.Event;
    
    /**
     * This class provides a skeletal implementation of the button IBuilder objects.
     */
    public class CoreButtonBuilder extends CoreBuilder implements Builder
    {
        /**
         * Creates a new CoreButtonBuilder instance.
         * @param target the target of the component reference to build.
         */
        public function CoreButtonBuilder( target:DisplayObject )
        {
            super( target );
            _map = new HashMap() ;
            initType() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified type is register in the object.
         * @return <code class="prettyprint">true</code> if the specified type is register in the object.
         */
        public function containsType( type:String ):Boolean
        {
            return _map.containsKey(type) ;
        }
        
        /**
         * Initialize all register type of this builder.
         * Overrides this method in the concrete implementations.
         */
        public function initType():void
        {
            //
        }
        
        /**
         * Invoked when a ButtonEvent register in this builder is dispatched.
         */
        protected function refreshState( e:Event ):void 
        {
            var type:String = e.type ;
            var callback:* = _map.get( type ) ;
            if ( callback is Function && callback != PRESENT )
            {
                ( callback as Function ).call( this , e ) ;
            }
        }
        
        /**
         * Registers the ButtonEvent type passed in argument.
         * @param type The type of the frame event to register (choose your event in the ButtonEvent static enumeration).
         * @param callback The optional method of the button to launch 
         */
        public function registerType( type:String , callback:Function=null ):void
        {
            var noExist:Boolean = _map.put( type , callback == null ? PRESENT : callback ) == null ;
            if ( noExist )
            {
                target.addEventListener( type , refreshState ) ;
            }
        }
        
        /**
         * Unregisters the ButtonEvent type passed in argument.
         */
        public function unregisterType( type:String ):void
        {
            if ( _map.containsKey( type ) )
            {
                target.removeEventListener( type , refreshState ) ;
                _map.remove( type ) ;
            }
        }
        
        /**
         * @private
         */
        private var _map:HashMap ;
        
        /**
         * @private
         */
        private static const PRESENT:Object = new Object() ;
    }
}
