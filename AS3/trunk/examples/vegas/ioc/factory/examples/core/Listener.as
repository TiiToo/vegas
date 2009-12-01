/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples.core
{
    import system.events.EventListener;

    import flash.events.Event;

    /**
     * The Listener class.
     */
    public class Listener implements EventListener
    {
        /**
         * Creates a new Listener instance.
         */
        public function Listener()
        {
            //
        }
        
        /**
         * The custom callback method who handle an event.
         */
        public function change( e:Event ):void
        {
            trace( this + " change " + e ) ;
        }
        
        /**
         * Handles the event.
         */
        public function handleEvent( e:Event ):void
        {
            trace( this + " handleEvent " + e ) ;
        }
    }
}