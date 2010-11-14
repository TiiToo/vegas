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

package vegas.utils
{
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    
    /**
     * Returns the unique name of the specified instance in argument.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.Sprite ;
     * import vegas.utils.getUniqueName ;
     * 
     * trace( getUniqueName( new Sprite()  ) ) ; // Sprite0
     * trace( getUniqueName( new Sprite()  ) ) ; // Sprite1
     * 
     * trace( getUniqueName( new Sprite() , true ) ) ; // flash.display.Sprite0
     * trace( getUniqueName( new Sprite() , true ) ) ; // flash.display.Sprite1
     * </pre>
     * @return the unique name of the specified instance in argument.
     */
    public function getUniqueName( o:* , isFull:Boolean = false ):String
    {
        var name:String = isFull ? getClassPath( o , true ) : getClassName( o ) ;
        var charCode:int = name.charCodeAt( name.length - 1 );
        if (charCode >= 48 && charCode <= 57) // if the class name finish with a number 0..9
        {
            name += "_" ;
        }
        if ( clazzBuffer[name] != null )
        {
            clazzBuffer[name] ++ ;
        }
        else
        {
            clazzBuffer[name] = 0 ;
        }
        return name + clazzBuffer[name] ;
    }
}

import flash.utils.Dictionary;

internal var clazzBuffer:Dictionary = new Dictionary(true) ;
