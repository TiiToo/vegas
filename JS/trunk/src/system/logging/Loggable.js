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
 * Implementing this interface allows an object who use a <code class="prettyprint">Logger</code> object.
 */
if ( system.logging.Loggable == undefined ) 
{
    /**
     * Creates a new Loggable instance.
     */
    system.logging.Loggable = function () 
    {
        //
    }
    
    /**
     * @extends Object
     */
    proto = system.logging.Loggable.extend( Object ) ;
    
    /**
     * Determinates the internal <code class="prettyprint">Logger</code> reference of this <code class="prettyprint">Loggable</code> object.
     */
    proto.getLogger = function ( context ) /*Logger*/ 
    {
        return this._logger ;
    }
    
    /**
     * Sets the internal <code class="prettyprint">Logger</code> reference of this <code class="prettyprint">Loggable</code> object.
     */
    proto.setLogger = function ( logger /*Logger*/ ) /*void*/ 
    {
        this._logger = logger ;
    }
    
    //////////////////////////////////// Virtual properties
    
    proto.__defineGetter__( "logger" , proto.getLogger ) ;
    proto.__defineSetter__( "logger" , proto.setLogger ) ;
    
    ////////////////////////////////////
    
    delete proto ;
}