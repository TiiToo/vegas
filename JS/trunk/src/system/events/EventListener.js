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

/**
 * The {@code EventListener} interface is the primary method for handling events. 
 * Users implement the EventListener interface and register their listener on an {@code EventTarget} using the {@code addEventListener method}. 
 * The users should also remove their EventListener from its {@code EventTarget} after they have completed using the listener.
 */
if ( system.events.EventListener == undefined ) 
{
    /**
     * Creates a new EventListener instance.
     */
    system.events.EventListener = function () 
    { 
        
    }
    
    /**
     * @extends Object
     */
    proto = system.events.EventListener.extend( Object ) ;
    
    /**
     * This method is called whenever an event occurs of the type for which the EventListener interface was registered.
     * @param e The Event contains contextual information about the event.
     */
    proto.handleEvent = function ( e /*Event*/ ) 
    {
        // override this method
    }
    
    /**
     * Returns the string representation of this instance.
     * @return the string representation of this instance.
     */
    proto.toString = function () /*String*/ 
    {
        return "[" + this.getConstructorName() + "]" ;
    }
    
    //////////
    
    delete proto ;
}