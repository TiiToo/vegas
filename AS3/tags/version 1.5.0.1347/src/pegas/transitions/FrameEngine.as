/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.transitions 
{
    import system.process.Startable;
    import system.process.Stoppable;
    import system.process.Task;
    
    import flash.display.Shape;
    import flash.events.Event;
    
    /**
     * This singleton create a virtual Frame interval with a onEnterFrame event. 
     * The use can register object listeners to receive by default the Event.ENTER_FRAME event.
     */
    public class FrameEngine extends Task implements Startable, Stoppable
    {
        /**
         * Creates a new FrameEngine instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function FrameEngine( global:Boolean = false , channel:String = null )
        {
            super( global , channel ) ;
        }
        
        /**
         * @private
         */
        public function enterFrame( e:Event = null ):void
        {
            dispatchEvent( new Event( Event.ENTER_FRAME ) ) ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if( !running )
            {
                notifyStarted() ;
                _engine.addEventListener( Event.ENTER_FRAME, enterFrame );
            }
        }
        
        /**
         * Start the process.
         */
        public function start():void
        {
            run() ;
        }
        
        /**
         * Stop the process.
         */
        public function stop():void
        {
            if( running )
            {
                _engine.removeEventListener( Event.ENTER_FRAME, enterFrame );
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        private static var _engine:Shape = new Shape() ;
    }
}
