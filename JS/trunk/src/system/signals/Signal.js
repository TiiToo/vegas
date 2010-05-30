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
 * This core basic class provides all basic methods of the system.events.Signal interface.
 * You must overrides this class and defines the content emit() method.
 */
if ( system.signals.Signal == undefined ) 
{
    /**
     * @requires system.signals.InternalSignal
     */
    require( "system.signals.InternalSignal" ) ;
    
    /**
     * Creates a new Signal instance.
     * <p><b>Example :</b></p>
     * <pre>
     * </pre>
     * @param types An optional Array who contains any number of class references that enable type checks in the "emit" method. 
     * If this argument is null the "emit" method not check the types of the parameters in the method.
     * @param receivers The Array collection of receiver objects to connect with this signal.
     */
    system.signals.Signal = function ( types /*Array*/ , receivers /*Array*/ ) 
    {
        this.__constructor__.call( this , types , receivers ) ;
    }
    
    ////////////////////////////////////
    
    /**
     * @extends system.signals.InternalSignal
     */
    proto = system.signals.Signal.extend( system.signals.InternalSignal ) ;
    
    /**
     * Emit the specified values to the receivers.
     * @param ...values All values to emit to the receivers.
     */
    proto.emit = function( /*Arguments*/ ) /*void*/
    {
        var values = Array.fromArguments( arguments ) ;
        if ( this.receivers.length == 0 )
        {
            return ;
        }
        this.checkValues( values ) ;
        var i /*int*/ ;
        var l /*int*/ = this.receivers.length ;
        var r /*Array*/ = [] ;
        var v /*Array*/ = this.receivers.slice() ;
        var e /*SignalEntry*/ ;
        for ( i = 0 ; i < l ; i++ ) 
        {
            e = v[i] ;
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
                i = this.receivers.indexOf( r[l] ) ;
                if ( i > -1 )
                {
                    this.receivers.splice( i , 1 ) ;
                }
            }
        }
        l = v.length ;
        for ( i = 0 ; i<l ; i++ ) 
        {
            v[i].receiver.apply( null , values ) ;
        }
    }
    
    ////////////////////////////////////
    
    delete proto ;
}