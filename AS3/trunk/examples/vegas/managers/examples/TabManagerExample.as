﻿/*  The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is VEGAS Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2010  the Initial Developer. All Rights Reserved.    Contributor(s) :  */package examples {    import vegas.managers.TabManager;        import flash.display.MovieClip;    import flash.events.KeyboardEvent;    import flash.ui.Keyboard;        public dynamic class TabManagerExample extends MovieClip     {        public function TabManagerExample()        {            manager      = new TabManager() ;            manager.auto = true ;                        // container1 and container2 two MovieClip on the Stage of the animation.                        container1.field1.tabIndex = 10 ;            container1.field2.tabIndex = 20 ;            container1.field3.tabIndex = 30 ;            container1.field4.tabIndex = 40 ;                        container2.field1.tabIndex = 2 ;            container2.field2.tabIndex = 1 ;            container2.field3.tabIndex = 4 ;            container2.field4.tabIndex = 3 ;                        manager.insert("group1", container1.field1 ) ;            manager.insert("group1", container1.field2 ) ;            manager.insert("group1", container1.field3 ) ;            manager.insert("group1", container1.field4 ) ;                         manager.insert("group2", container2.field1 ) ;            manager.insert("group2", container2.field2 ) ;            manager.insert("group2", container2.field3 ) ;            manager.insert("group2", container2.field4 ) ;                         manager.select("group1") ;                        stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;        }                public var manager:TabManager ;                public function keyDown(e:KeyboardEvent):void        {            var code:uint = e.keyCode ;            switch( code )            {                case Keyboard.UP :                {                    manager.select("group1") ;                    break ;                }                case Keyboard.DOWN :                {                    manager.select("group1" , container1.field3 ) ;                    break ;                }                case Keyboard.LEFT :                {                    manager.select("group2") ;                    break ;                }                case Keyboard.RIGHT :                {                    manager.select("group2" , container2.field2 ) ;                    break ;                }            }        }    }}