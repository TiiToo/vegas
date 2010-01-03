﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is VEGAS Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2010  the Initial Developer. All Rights Reserved.    Contributor(s) :    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.  */package vegas.managers {    import system.data.Collection;    import system.data.collections.ArrayCollection;    import system.events.BasicEvent;        import vegas.models.CoreModel;        import flash.display.DisplayObject;    import flash.events.Event;    import flash.filters.BitmapFilter;        /**     * Manages the filters apply over a specific DisplayObject.     * <p><b>Example :</b></p>     * <pre class="prettyprint">     * import flash.display.Shape ;     * import flash.display.StageAlign ;     * import flash.display.StageScaleMode ;     *      * import flash.filters.BlurFilter ;     * import flash.filters.DropShadowFilter ;     *      * import vegas.managers.BitmapFilterManager ;     *      * stage.align     = StageAlign.TOP_LEFT ;     * stage.scaleMode = StageScaleMode.NO_SCALE ;     *      * var shape:Shape = new Shape() ;     *      * shape.graphics.beginFill( 0xFF0000 ) ;     * shape.graphics.drawRect(0,0,50,50) ;     *      * shape.x = 50 ;     * shape.y = 50 ;     *      * addChild( shape ) ;     *      * var manager:BitmapFilterManager = new BitmapFilterManager( shape ) ;     * var blur:BlurFilter             = new BlurFilter(10,5,3) ;     * var shadow:DropShadowFilter     = new DropShadowFilter(2,45,0,0.7,10,10,1,3) ;     *      * manager.add( blur ) ;     * manager.add( shadow ) ;     *      * var onKeyDown:Function = function( e:KeyboardEvent ):void     * {     *     var code:uint = e.keyCode ;     *     switch( code )     *     {     *         case Keyboard.UP :     *         {     *             blur.blurX      = 10 ;     *             shadow.distance = 2  ;     *             shadow.angle    = 45 ;     *             manager.update() ;     *             break ;     *         }     *         case Keyboard.DOWN :     *         {     *             blur.blurX      = 20 ;     *             shadow.distance = 6  ;     *             shadow.angle    = 90 ;     *             manager.update() ;     *             break ;     *         }     *         case Keyboard.SPACE :     *         {     *             manager.enabled = !manager.enabled ;     *             break ;     *         }     *    }     * }     *      * stage.addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown ) ;     * </pre>     */    public class BitmapFilterManager extends CoreModel     {        /**         * Creates a new BitmapFilterManager instance.         * @param display The DisplayObject target reference of this manager.          * @param id the id of the model.         * @param bGlobal the flag to use a global event flow or a local event flow.         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.         */        public function BitmapFilterManager( display:DisplayObject = null , id:* = null, bGlobal:Boolean = false, sChannel:String = null)        {            super(id, bGlobal, sChannel);            this.display = display ;            _co = initializeCollection() ;            initEventType() ;        }                /**         * The DisplayObject reference.         */        public var display:DisplayObject ;                /**         * Indicates if the filters can be apply over the DisplayObject in the update method.         */        public function get enabled():Boolean         {            return _enabled ;        }                /**         * @private         */        public function set enabled( b:Boolean ):void         {            _enabled = b ;            update() ;        }                /**         * Insert a new BitmapFilter object in the manager.         * @param id The key of the group to collect the specified interactive object.         * @throws ArgumentError the id argument not must be 'null' or 'undefined'.         * @return <code class="prettyprint">true</code> If the filter is added.         */        public function add( filter:BitmapFilter ):Boolean        {            if ( filter == null )            {                throw new ArgumentError( this + " add failed, the BitmapFilter parameter not must be 'null' or 'undefined'.") ;            }            var b:Boolean = _co.add( filter ) ;            notifyEvent( _sAddType ) ;            update() ;            return b ;        }                /**         * Removes all elements in this manager.         */        public function clear():void         {            _co.clear() ;            if ( display != null )            {                display.filters = null ;            }            notifyEvent( _sRenderType ) ;        }                /**         * Checks whether the map contains the specified group id.         */        public function contains( filter:BitmapFilter ):Boolean        {            return _co.contains( filter ) ;        }                /**         * Returns the event name use in the <code class="prettyprint">add</code> method.         * @return the event name use in the <code class="prettyprint">add</code> method.         */        public function getEventTypeADD():String        {            return _sAddType ;        }                /**         * Returns the event name use in the <code class="prettyprint">remove</code> method.         * @return the event name use in the <code class="prettyprint">remove</code> method.         */        public function getEventTypeREMOVE():String        {            return _sRemoveType ;        }                /**         * Returns the event name use in the <code class="prettyprint">apply</code> method.         * @return the event name use in the <code class="prettyprint">apply</code> method.         */        public function getEventTypeRENDER():String        {            return _sRenderType ;        }                /**         * This method is invoked in the constructor of the class to initialize all events.         * Overrides this method.         */        public function initEventType():void        {            _sAddType    = Event.ADDED ;            _sRemoveType = Event.REMOVED ;            _sRenderType = Event.RENDER ;        }                /**         * Initialize the internal Collection instance in the constructor of the class.         * You can overrides this method if you want change the default SimpleCollection use in this model.         */        public function initializeCollection():Collection        {            return new ArrayCollection() ;         }                          /**         * Notify an <code class="prettyprint">Event</code> with the specified type if the model isn't locked.         */         public function notifyEvent( type:String ):void        {            if ( isLocked() )            {                return ;            }            dispatchEvent( new BasicEvent( type ) ) ;        }                /**         * Insert a new BitmapFilter object in the manager.         * @param id The key of the group to collect the specified interactive object.         * @return <code class="prettyprint">true</code> If the filter is removed.         * @throws ArgumentError the id argument not must be 'null' or 'undefined'.         */        public function remove( filter:BitmapFilter ):*        {            if ( filter == null )            {                throw new ArgumentError( this + " remove failed, the BitmapFilter parameter not must be 'null' or 'undefined'.") ;            }            var r:* = _co.remove( filter ) ;            notifyEvent( _sRemoveType ) ;            update() ;            return r ;        }                 /**         * Sets the event name use in the <code class="prettyprint">add</code> method.         */        public function setEventTypeADD( type:String ):void        {            _sAddType = type ;        }                        /**         * Sets the event name use in the <code class="prettyprint">remove</code> method.         */        public function setEventTypeREMOVE( type:String ):void        {            _sRemoveType = type ;        }                /**         * Sets the event name use in the <code class="prettyprint">remove</code> method.         */        public function setEventTypeRENDER( type:String ):void        {            _sRenderType = type ;        }                /**         * Returns the Array representation of the object.         * @return the Array representation of the object.         */        public function toArray():Array        {            return _co.toArray() ;        }                /**         * Update all filters in the specified DisplayObject..         */        public function update():void        {            if ( !isLocked() && display != null )            {                var filters:Array = _co.toArray() ;                display.filters = ( filters.length > 0 && _enabled ) ? filters : null ;            }            notifyEvent( _sRenderType ) ;        }                /**         * @private         */        protected var _co:Collection ;                /**         * @private         */        private var _enabled:Boolean = true ;                /**         * @private         */        private var _sAddType:String ;                /**         * @private         */        private var _sRemoveType:String ;                /**         * @private         */        private var _sRenderType:String ;    }}