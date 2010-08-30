﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
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

package system.process 
{
    /**
     * This Action launch the initialize method of the object but notify an event before (ActionEvent.START) and after(ActionEvent.FINISH) the process.
     * <p>You can override the initialize method of the object or extends the class.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * import system.process.Initializer ;
     * 
     * var debug:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e.type ) ;
     * }
     * 
     * var process:Initializer = new Initializer() ;
     * 
     * process.initialize = function():void
     * {
     *     trace( "custom init process !" ) ;
     * }
     * 
     * process.addEventListener( ActionEvent.START  , debug ) ;
     * process.addEventListener( ActionEvent.FINISH , debug ) ;
     * 
     * process.run() ;
     * 
     * // start
     * // "custom init process !"
     * // finish
     * </pre>
     */
    public dynamic class Initializer extends Task
    {
        /**
         * Creates a new InitProcess instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function Initializer( global:Boolean = false , channel:String = null ) 
        {
            super( global, channel );
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new Initializer( _isGlobal , channel ) ;
        }
        
        /**
         * The initialize method.
         */
        prototype.initialize = function():void
        {
            // override
        };
        
        /**
         * Invoked when the process is run. 
         */
        public override function run( ...arguments:Array ):void
        {
            notifyStarted() ;
            this["initialize"]() ;
            notifyFinished() ;
        };
    }
}
