﻿/*  The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is VEGAS Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2010  the Initial Developer. All Rights Reserved.    Contributor(s) :    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.  */package vegas.ui {    import system.Environment;    import system.hosts.PlatformID;        import vegas.logging.logger;        import flash.display.InteractiveObject;    import flash.display.Stage;    import flash.events.MouseEvent;    import flash.external.ExternalInterface;        /**     * This mousewheel inspector use JS to inspect the mouse wheel event (problem with mac for example).     */    public class MouseWheelInspector     {        /**         * Creates a new MouseWheelInspector instance.         * @param stage The stage reference of the application.         */        public function MouseWheelInspector( stage:Stage )        {            if ( available && _stage == null )            {                _stage = stage  ;                ExternalInterface.call( MouseWheelScript );                ExternalInterface.addCallback( "checkScrolling" , _checkScrolling ) ;                ExternalInterface.call( RUNNER , ExternalInterface.objectID ) ;                var enforce:Boolean = ExternalInterface.call( ENFORCER , ExternalInterface.objectID) as Boolean ;                if ( isMac || enforce )                {                    _stage.addEventListener( MouseEvent.MOUSE_MOVE , _move );                     ExternalInterface.addCallback( "onMouseEvent", _onMouseEvent );                }            }        }                /**         * This Javascript script is used to tests if the inspector if available.         */        public static const AVAILABLE:XML =         <script><![CDATA[        function()        {            return true ;        }        ]]></script>;                /**         * This Javascript script is used to tests if the inspector if available.         */        public static const DISPOSE:XML =         <script><![CDATA[        function()        {            if ( window.MouseWheelInspector )            {                window.MouseWheelInspector = undefined ;                MouseWheelInspector        = undefined ;                return true ;            }            else            {                return false ;            }        }        ]]></script>;                /**         * The command name to force the patch.         */        public static const ENFORCER:String = "MouseWheelInspector.force" ;                /**         * The command name to execute the patch.         */        public static const RUNNER:String = "MouseWheelInspector.run"  ;                /**         * Indicates if the inspector Javascript connection is available.         */        public function get available():Boolean        {            if ( !ExternalInterface.available )             {                return false ;            }            var b:Boolean ;            try            {                b = Boolean( ExternalInterface.call( AVAILABLE ) ) ;            }            catch ( e:Error )            {                logger.warn( this + " available property not valid, the inspector can't be connected with external interface.");            }            return b ;        }                /**         * Returns the id attribute of the object tag in Internet Explorer, or the name attribute of the embed tag in Netscape.         */        public function get objectID():String        {            return ExternalInterface.objectID ;        }                /**         * Indicates if the platform used to open the application is a MAC.         */        public function get isMac():Boolean        {            return Environment.os.platform == PlatformID.Macintosh ;        }                /**         * Indicates if the browser scrolling.         */        public function get scrolling():Boolean        {            return _scrolling ;        }                /**         * @private         */        public function set scrolling( b:Boolean ):void        {            _scrolling = b ;        }                /**         * @private         */        private var _dispatcher:InteractiveObject;                /**         * @private         */        private var _event:MouseEvent ;                /**         * @private         */        private var _scrolling:Boolean ;                /**         * @private         */        private function _checkScrolling():Boolean        {            return _scrolling ;        }                /**         * @private         */        protected var _stage:Stage ;                /**         * @private         */        private function _move( e:MouseEvent ):void        {            _dispatcher  = e.target as InteractiveObject ;            _event       = e as MouseEvent ;        }                /**         * @private         */        private function _onMouseEvent( delta:Number ):void        {            if ( _event == null || _dispatcher == null )             {                return ;            }            var event:MouseEvent = new MouseEvent            (                    MouseEvent.MOUSE_WHEEL,                    true,                    false,                    _event.localX,                    _event.localY,                    _event.relatedObject,                    _event.ctrlKey,                    _event.altKey,                    _event.shiftKey,                    _event.buttonDown,                    int( delta )            );            _dispatcher.dispatchEvent( event ) ;        }    }}