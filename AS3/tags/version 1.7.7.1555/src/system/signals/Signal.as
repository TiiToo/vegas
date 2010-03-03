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

package system.signals 
{
    import system.Cloneable;
    
    /**
     * This class provides a fast Signaler implementation.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import system.signals.Signal ;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.Event;
     *     
     *     [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
     *     
     *     public class SignalExample extends Sprite
     *     {
     *         public function SignalExample()
     *         {
     *             var signal:Signal = new Signal() ;
     *             
     *             signal.connect( write ) ;
     *             
     *             signal.emit( "hello world" ) ; // hello world
     *             signal.emit( "thank you" ) ; // thank you
     *         }
     *         
     *         public function write( message:String ):void
     *         {
     *             trace( message ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class Signal extends InternalSignal implements Cloneable
    {
        /**
         * Creates a new Signal instance.
         * @param types An optional Array who contains any number of class references that enable type checks in the "emit" method. 
         * If this argument is null the "emit" method not check the types of the parameters in the method.
         * @param receivers The Array collection of receiver objects to connect with this signal.
         */
        public function Signal( types:Array = null , receivers:Array = null )
        {
            super( types , receivers ) ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Signal( types , toArray() ) ;
        }
        
        /**
         * Emit the specified values to the receivers.
         * @param ...values All values to emit to the receivers.
         */
        public override function emit( ...values:Array ):void
        {
            if ( receivers.length == 0 )
            {
                return ;
            }
            checkValues( values ) ;
            var i:int ;
            var l:int = receivers.length ;
            var r:Array = [] ;
            var a:Array = receivers.slice() ;
            var e:SignalEntry ;
            for ( i = 0 ; i < l ; i++ ) 
            {
                e = a[i] as SignalEntry ;
                if ( e.auto )
                {
                    r[ r.length ] = e  ;
                }
            }
            if ( r.length > 0 )
            {
                l = r.length ;
                while( --l > -1 )
                {
                    i = receivers.indexOf( r[l] ) ;
                    if ( i > -1 )
                    {
                        receivers.splice( i , 1 ) ;
                    }
                }
            }
            l = a.length ;
            for ( i = 0 ; i<l ; i++ ) 
            {
                (a[i] as SignalEntry).receiver.apply( null , values ) ;
            }
        }
    }
}
