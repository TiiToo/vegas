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
 * The error throws when a key is non unique.
 */
if ( system.errors.NonUniqueKeyError == undefined ) 
{
    /**
     * Creates a new NonUniqueKeyError instance.
     */
    system.errors.NonUniqueKeyError = function( key , pattern /*String*/ ) 
    {
        this.pattern = ( pattern == null || pattern.length == 0 ) ? system.errors.NonUniqueKeyError.PATTERN : pattern ;
        this.message = core.strings.fastformat( this.pattern , key ) ;
        this.name    = "NonUniqueKeyError" ;
        this.key     = key ;
    }
    
    /**
     * The localizable or changeable expression to defines the pattern of the error message.
     */
    system.errors.NonUniqueKeyError.PATTERN = "attempting to insert '{0}'" ;
    
    /**
     * @extends Error
     */
    proto = system.errors.NonUniqueKeyError.extend( Error ) ;
    
    /**
     * The key non unique of this error.
     */
    proto.key = null ;
    
    /**
     * The pattern of this error.
     */
    proto.pattern = null ;
    
    /**
     * Returns the eden representation of this map.
     * @return the eden representation of this map.
     */
    proto.toSource = function () /*String*/ 
    {
        return "new system.errors.NonUniqueKeyError(" + this.key.toSource() + "," + this.pattern.toSource() + ")" ;
    }
    
    //////// encapsulate
    
    delete proto ;
}