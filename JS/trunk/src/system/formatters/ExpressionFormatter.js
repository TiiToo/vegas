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
 * This object register formattable expression and format a String with all expressions register in this internal dictionnary. 
 */
if ( system.formatters.ExpressionFormatter == undefined ) 
{
    /**
     * @requires system.formatters.Formattable
     */
    require( "system.formatters.Formattable" ) ;
    
    /**
     * Creates a new ExpressionFormatter instance.
     */
    system.formatters.ExpressionFormatter = function () 
    {
        this._reset() ;
    }
    
    //////// static
    
    system.formatters.ExpressionFormatter.MAX_RECURSION /*uint*/ = 200 ;
    
    //////// inherit
    
    /**
     * @extends
     */
    proto = system.formatters.ExpressionFormatter.extend( system.formatters.Formattable ) ;
    
    //////// public
    
    /**
     * The dictionary of all expressions register in the formatter.
     */
    proto.expressions = {} ;
    
    /**
     * Formats the specified value.
     * @param value The object to format.
     * @return the string representation of the formatted value. 
     */
    proto.format = function ( value ) /*String*/ 
    {
        // 
    }
    
    //////// getter/setter
    
    /**
     * The begin separator of the expression to format (default "{").
     */
    proto.getBeginSeparator = function() /*String*/
    {
        return this._beginSeparator ;
    }
    
    /**
     * @private
     */
    proto.setBeginSeparator = function( str /*String*/ ) /*void*/
    {
        this._beginSeparator = str || "{" ;
        this._reset() ;
    }
    
    /**
     * The end separator of the expression to format (default "}").
     */
    proto.getEndSeparator = function() /*String*/
    {
        return this._endSeparator ;
    }
    
    /**
     * @private
     */
    proto.setEndSeparator = function( str /*String*/ ) /*void*/
    {
        this._endSeparator = str || "}" ;
        this._reset() ;
    }
    
    //////// virtual properties
    
    proto.__defineGetter__( "beginSeparator" , proto.getBeginSeparator ) ;
    proto.__defineSetter__( "beginSeparator" , proto.setBeginSeparator ) ;
    
    proto.__defineGetter__( "endSeparator" , proto.getEndSeparator ) ;
    proto.__defineSetter__( "endSeparator" , proto.setEndSeparator ) ;
    
    //////// private
    
    /**
     * @private
     */
    proto._beginSeparator /*String*/ = "{" ;
    
    /**
     * @private
     */
    proto._endSeparator /*String*/ = "}" ;
    
    /**
     * @private
     */
    proto._pattern /*String*/ = "{0}((\\w+\)|(\\w+)((.\\w)+|(.\\w+))){1}" ;
    
    /**
     * @private
     */
    proto._reg /*RegExp*/ = null ;
    
    /**
     * @private
     */
    proto._format = function( value /*String*/ ) /*void*/
    {
        
    }
    
    /**
     * @private
     */
    proto._reset = function() /*void*/
    {
        this._reg = new RegExp( core.strings.format( this._pattern , this.beginSeparator , this.endSeparator ), "g" ) ;
    }
}