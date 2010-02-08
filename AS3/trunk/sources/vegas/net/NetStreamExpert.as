﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at              http://www.mozilla.org/MPL/     Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the License.     The Original Code is VEGAS Framework.    The Initial Developer of the Original Code is  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.  Portions created by the Initial Developer are Copyright (C) 2004-2010  the Initial Developer. All Rights Reserved.    Contributor(s) :    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.  */package vegas.net{    import flash.media.Video;    import flash.net.NetStream;    import flash.utils.Timer;        /**     * This expert control a NetStream.     */    public class NetStreamExpert extends NetStreamClient     {        /**         * Creates a new NetStreamExpert instance.         * @param netStream The NetStream reference of this advanced proxy client manager.         * @param video The Video reference of this netstream client to register automatickly the stream with the video.         */        public function NetStreamExpert( netStream:NetStream = null , video:Video = null )        {            super( netStream , video ) ;        }                /**         * The timer reference of this expert.         */        public var timer:Timer ;                /**         * Close the internal NetStream of this expert.         */        public function close():void        {            if ( _netStream )            {                _netStream.close() ;                if ( timer != null )                {                    timer.stop();                }            }        }                /**         * Pauses the internal NetStream of this expert.         */        public function pause():void        {            if ( _netStream )            {                if ( timer != null )                {                    timer.stop();                }                _netStream.pause() ;            }        }                /**         * Play the stream video.         * @param uri The uri of the stream.         */        public function play( uri:String ):void        {            if ( _netStream )            {                _netStream.play( uri ) ;                if ( timer )                {                    timer.start();                }            }        }                /**         * Seek the stream video.         */        public function seek( position:Number ):void        {            if ( _netStream )            {                _netStream.seek( position ) ;            }        }                /**         * Resumes the internal NetStream of this expert.         */        public function resume():void        {            if ( _netStream )            {                _netStream.resume() ;                if ( timer )                {                    timer.start();                }            }        }    }}