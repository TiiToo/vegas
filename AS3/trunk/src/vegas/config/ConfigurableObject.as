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

package vegas.config
{
    import system.data.Identifiable;
    import system.events.CoreEventDispatcher;
    
    /**
     * This core class extend the CoreObject class and implement the IConfigurable interface.
     * A IConfigurable object handle a notification of the ConfigCollector class with the method setup(), you must override this method in your concrete class.
     * The IConfigurable objects are registered in the ConfigCollector to launch the setup of all IConfigurable object one time with the <code class="prettyprint">ConfigCollector.run()</code> method when the Config is loaded for example. 
     */
    public class ConfigurableObject extends CoreEventDispatcher implements IConfigurable, Identifiable
    {
        /**
         * Creates a new ConfigurableObject instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function ConfigurableObject( id:*=null, isConfigurable:Boolean = false, global:Boolean = false , channel:String = null )
        {
            super( global , channel ) ;
            if ( id != null )
            {
                this.id = id ;
            }
            this.isConfigurable = isConfigurable ;
        }
        
        /**
         * Returns the id of this object.
         * @return the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
         * @private
         */
        public function set id( id:* ):void
        {
            _setID( id ) ;
        }
        
        /**
         * Indicates if the object is configurable and receive the notification of the ConfigCollector in the setup() method.
         */
        public function get isConfigurable():Boolean
        {
            return _isConfigurable ;
        }
        
        /**
         * @private
         */
        public function set isConfigurable(b:Boolean):void
        {
            _isConfigurable = (b == true) ;
            if (_isConfigurable)
            {
                ConfigCollector.insert(this) ;
            }
            else
            {
                ConfigCollector.remove(this) ;
            }
        }
         
        /**
         * Invoked when this object when the ConfigCollector is run.
         */
        public function setup():void
        {
            if ( id != null )
            {
                Config.getInstance().init( this , id , update ) ;
            }
        }
        
        /**
         * Update the display.
         * You must override this method. This method is launch by the setup() method when the Config is checked.
         */    
        public function update():void
        {
            // overrides this method.
        }
        
        /**
         * The internal id of this object.
         * @private
         */
        private var _id:* ;
        
         /**
         * Determinates if the object is configurable.
         */
        private var _isConfigurable:Boolean ;
        
        /**
         * Sets the id of the object with a custom method.
         */
        protected function _setID( id:* ):void 
        {
            this._id = id ;
        }
    }
}