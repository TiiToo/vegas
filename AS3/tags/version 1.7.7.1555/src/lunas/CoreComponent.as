/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
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
    import graphics.geom.EdgeMetrics;
    
    import lunas.events.ComponentEvent;
    import lunas.events.StyleEvent;
    
    import system.Reflection;
    
    import vegas.display.Background;
    
    import flash.events.Event;
    
    /**
     * This class provides a skeletal implementation of all the components in Lunas, to minimize the effort required to implement this interface.
     */
    public class CoreComponent extends Background implements Component
    {
        /**
         * Creates a new CoreComponent instance.
         * @param id Indicates the id of the object.
         * @param isFull Indicates if the display is full size or not.
         * @param name Indicates the instance name of the object.
         */
        public function CoreComponent( id:* = null, isFull:Boolean=false, name:String = null)
        {
            lock() ;
            super( id, isFull, name );
            unlock() ;
            
            addEventListener( Event.REMOVED , viewDestroyed ) ;
            
            focusRect = false ;
            tabEnabled = this is Focusable ;
            
            initialize() ;
            
            var cb:Class = getBuilderRenderer() ; 
            if ( cb != null && Reflection.getClassInfo(cb).hasInterface(Builder) )
            {
                builder = ( new cb(this) as Builder ) ;
            }
            
            var cs:Class = getStyleRenderer() ;
            if ( cs != null && Reflection.getClassInfo(cs).hasInterface(Style) ) 
            {
                var path:String = Reflection.getClassPath(this) ;
                if ( StyleCollector.contains( path ) )
                {
                    style = StyleCollector.get( path ) ;
                }
                else
                {
                    style = new cs() as Style ;
                    if ( style )
                    {
                        style.id = path ; // creates the default singleton Style reference of this component
                    }
                }
            }
        }
        
        /**
         * Indicates the thickness, in pixels, of the four edge regions around a visual component.
         */
        public function get border():EdgeMetrics
        {
            return _border ;
        }
        
        /**
         * @private
         */
        public function set border( em:EdgeMetrics ):void
        {
            _border = em || EdgeMetrics.EMPTY ;
            update() ;
        }
        
        /**
         * Indicates if the events use bubbling when are dispatched.
         */
        public var bubbles:Boolean = true ;
        
        /**
         * Indicates the IBuilder reference of this instance.
         */
        public function get builder():Builder 
        {
            return _builder ;
        }
        
        /**
         * @private
         */
        public function set builder( builder:Builder ):void
        {
            if (_builder != null) 
            {
                _builder.clear() ;
                _builder = null ;
            }
            if ( builder != null ) 
            {
                _builder        = builder ;
                _builder.target = this    ;
                _builder.run() ;
            }
        }
        
        /**
         * Initialize when the Flash component settings are initialized (only in Flash with a compiled component).
         */
        public function get componentInspectorSetting():Boolean
        {
            return _componentInspectorSetting ;
        }
        
        /**
         * @private
         */
        public function set componentInspectorSetting( value:Boolean ):void
        {
            _componentInspectorSetting = value;
        }
        
        /**
         * Indicates the enabled state of the component.
         */
        public function get enabled():Boolean 
        {
            return _enabled ;
        }
        
        /**
         * Sets the enabled state of the component.
         */
        public function set enabled( b:Boolean ):void 
        {
            _enabled = (b == true) ;
            if ( isLocked() ) 
            {
                return ;
            }
            viewEnabled() ;
            notifyEnabled() ;
        }
        
        /**
         * Indicates with a boolean if this object is grouped.
         * @return <code class="prettyprint">true</code> if this object is grouped.
         */
        public function get group():Boolean
        {
            return _group ;
        }
        
        /**
         * @private
         */
        public function set group(b:Boolean):void
        {
            _group = b ;
            groupPolicyChanged() ;
        }
        
        /**
          * Indicates the name of the group of this object.
          */
        public function get groupName():String
        {
            return _groupName ;
        }
        
        /**
         * @private
         */
        public function set groupName(sName:String ):void
        {
            _group        = sName != null ;
            _oldGroupName = _groupName ;
            _groupName    = sName ;    
            groupPolicyChanged() ;
            _oldGroupName = _groupName ;
        }
        
        /**
         * Returns the style of this component.
         * @return the style of this component.
         */
        public function get style():Style 
        {
            return _style ;
        }
        
        /**
         * Sets the style of this component.
         */
        public function set style( s:Style ):void 
        {
            _unregisterStyle() ;
            var path:String = Reflection.getClassPath(this) ;
            if ( s == null && StyleCollector.contains( path ) )
            {
                s = StyleCollector.get( path ) ; // default IStyle of the component
            }
            else if ( s == null ) 
            {
                return ;
            }
            _style = s ; 
            _registerStyle() ;
            if ( isLocked() ) 
            {
                return ;
            }
            dispatchEvent( new StyleEvent( StyleEvent.STYLE_CHANGE , this, bubbles  ) ) ;
            update() ;
        }
        
        /**
         * Returns the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
         */
        public function getBuilderRenderer():Class 
        {
            return null ; // overrides
        }
        
        /**
         * Returns the <code class="prettyprint">IStyle</code> constructor use to initialize this component.
         * @return the <code class="prettyprint">IStyle</code> constructor use to initialize this component.
         */
        public function getStyleRenderer():Class 
        {
            return null ; // overrides
        }
        
        /**
         * Invoked when the group property or the groupName property changed.
         * Overrides this method in concrete class.
         */
        public function groupPolicyChanged():void 
        {
            //
        }
        
        /**
         * Hides the component.
         */
        public function hide():void 
        {
            visible = false ;
            fireComponentEvent( ComponentEvent.HIDE  ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the component is visible.
         * @return <code class="prettyprint">true</code> if the component is visible.
         */
        public function isVisible():Boolean 
        {
            return visible ;
        }
        
        /**
         * Initialize the component.
         * You can override this method.
         */
        public function initialize():void 
        {
            // overrides
        }
        
        /**
         * Moves the component.
         * @param x The x position of the component.
         * @param y The y position of the component.
         */
        public function move( x:Number=NaN , y:Number=NaN ):void
        {
            if ( !isNaN(x) )
            {
                this.x = x ;
            }
            if ( !isNaN(y) )
            {
                this.y = y ;
            }
            fireComponentEvent( ComponentEvent.MOVE ) ;
        }
        
        /**
         * Notify a change in this component.
         */
        public function notifyChanged():void 
        {
            fireComponentEvent( ComponentEvent.CHANGE ) ;
        }
        
        /**
         * Notify an event when the enabled property is changed. 
         * This event can be a ComponentEvent.ENABLED or ComponentEvent.DISABLED event.
         */
        public function notifyEnabled():void
        {
            fireComponentEvent( ComponentEvent.ENABLED ) ;
        }
        
        /**
         * Sets the style property on the style declaration or object.
         */
        public function setStyle( ...args:Array ):void 
        {
            if ( args.length == 1 && args[0] is Style )
            {
                style = args[0] as Style ;
            }
            else
            {
                style.setStyle.apply( style , args ) ;
            }
        }
        
        /**
         * Shows the component.
         */
        public function show():void 
        {
            visible = true ;
            fireComponentEvent( ComponentEvent.SHOW  ) ;
        }
        
        /**
         * Updates the component.
         */
        public override function update():void 
        {
            if ( isLocked() ) 
            {
                return ;
            }
            draw() ;
            if ( _builder != null ) 
            {
                _builder.update() ;
            }
            viewChanged() ;
            fireComponentEvent( Event.RENDER ) ;
        }
        
        /**
         * Invoked when the component is removed.
         * Overrides this method.
         */
        public function viewDestroyed( e:Event=null ):void 
        {
            // overrides
        }
        
        /**
         * Invoked when the component IStyle changed.
         * Overrides this method.
         */
        public function viewStyleChanged( e:Event=null ):void 
        {
            // overrides
        }
        
        /**
         * @private
         */
        private var _border:EdgeMetrics = EdgeMetrics.EMPTY ;
        
        /**
         * @private
         */
        private var _builder:Builder ;
        
        /**
         * @private
         */
        private var _componentInspectorSetting:Boolean ;
        
        /**
         * @private
         */
        private var _enabled:Boolean = true ;
        
        /**
         * @private
         */
        private var _group:Boolean ;
        
        /**
         * @private
         */
        private var _groupName:String ;
        
        /**
         * @private
         */
        protected var _oldGroupName:String ; 
        
        /**
         * @private
         */
        private var _style:Style ;
        
        /**
         * Dispatchs a ComponentEvent with the specified type.
         */
        protected function fireComponentEvent( type:String ):void
        {
            dispatchEvent( new ComponentEvent( type , this , bubbles )  ) ;
        }
        
        /**
         * Register the IStyle reference of the component.
         */
        private function _registerStyle():void
        {
            if (_style != null)
            {
                _style.addEventListener( StyleEvent.STYLE_CHANGE       , viewStyleChanged ) ;
                _style.addEventListener( StyleEvent.STYLE_SHEET_CHANGE , viewStyleChanged ) ;
            }
        }
        
        /**
         * Unregister the IStyle reference of the component.
         */
        private function _unregisterStyle():void
        {
            if ( _style != null ) 
            {
                _style.removeEventListener( StyleEvent.STYLE_CHANGE       , viewStyleChanged ) ;
                _style.removeEventListener( StyleEvent.STYLE_SHEET_CHANGE , viewStyleChanged ) ;
                _style = null ;
            }
        }
    }
}
