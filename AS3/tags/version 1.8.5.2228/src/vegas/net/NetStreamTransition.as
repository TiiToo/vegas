/*

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

package vegas.net
{
    import graphics.transitions.CoreTransition;
    
    import flash.events.NetStatusEvent;
    import flash.media.Video;
    import flash.net.NetStream;
    
    /**
     * This transition control a netstream with a specific expert.
     */
    public class NetStreamTransition extends CoreTransition 
    {
        /**
         * Creates a new NetStreamTransition instance.
         * @param netStream The NetStreamExpert reference.
         * @param uri The uri of the stream to play.
         */
        public function NetStreamTransition( netStream:NetStream = null , uri:String = null )
        {
            this.netStream = netStream ;
            this.uri       = uri ;
        }
        
        /**
         * The NetStream reference.
         */
        public function get netStream():NetStream
        {
            return _netStream ; 
        }
        
        /**
         * @private
         */
        public function set netStream( netStream:NetStream ):void
        {
            _netStream = netStream ;
        }
        
        public var video:Video ;
        
        /**
         * The uri of the stream to play.
         */
        public function get uri():String
        {
            return _uri ;
        }
        
        /**
         * @private
         */
        public function set uri( value:String ):void
        {
            _uri = value ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if( running )
            {
                return ;
            }
            notifyStarted() ;
            if ( _netStream )
            {
                if ( arguments.length == 1 && arguments[0] is String )
                {
                    _uri = arguments[0] as String ;
                }
                if ( _netStream )
                {
                    _netStream.addEventListener( NetStatusEvent.NET_STATUS , status , false, 0 , true ) ;
                }
                _netStream.play( _uri ) ;
            }
            else
            {
                notifyFinished() ;
            }
        }
        
        /**
         * Starts the stream from.
         */
        public override function start():void
        {
            run() ;
        }
        
        /**
         * Stops the transition.
         */
        public override function stop():void
        {
            if ( _netStream )
            {
                _netStream.pause() ;
            }
        }
        
        /**
         * @private
         */
        protected function status( e:NetStatusEvent ):void
        {
            var info:Object = e.info ;
            switch( info.code )
            {
                case "NetStream.Buffer.Flush" :
                {
                    break ;
                }
                case "NetStream.Play.StreamNotFound":
                case "NetStream.Play.Stop" :
                {
                    if ( running )
                    {
                        _netStream.removeEventListener( NetStatusEvent.NET_STATUS , status ) ;
                        notifyFinished() ;
                    }
                    break ;
                }
            }
        }
        
        /**
         * @private
         */
        private var _netStream:NetStream ;
        
        /**
         * @private
         */
        private var _uri:String ;
   }
}