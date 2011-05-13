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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

package graphics 
{
    import graphics.geom.Matrixs;
    
    import flash.display.Graphics;
    import flash.display.Shader;
    import flash.geom.Matrix;
    
    /**
     * Defines the fill style of the vector shapes. See the Graphics.beginShaderStyle method.
     * @since Flash Player 10, AIR 1.5
     */
    public class FillShaderStyle implements IFillStyle
    {
        /**
         * Creates a new FillShaderStyle instance.
         * @param shader The shader to use for the fill.
         * @param matrix An optional transformation matrix as defined by the flash.geom.Matrix class. The matrix can be used to scale or otherwise manipulate the bitmap before applying it to the fill style.
         */
        public function FillShaderStyle( shader:Shader = null , matrix:Matrix = null )
        {
            this.shader = shader ;
            this.matrix = matrix ;
        }
        
        /**
         * An optional transformation matrix as defined by the flash.geom.Matrix class. The matrix can be used to scale or otherwise manipulate the bitmap before applying it to the line style.
         */
        public var matrix:Matrix ;
        
        /**
         * The shader to use for the line stroke.
         */
        public var shader:Shader;
        
        /**
         * Initialize and launch the beginFill method of the specified Graphics reference.
         */
        public function apply( graphic:Graphics ):void
        {
            graphic.beginShaderFill( shader , matrix );
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():* 
        {
            return new FillShaderStyle( shader , matrix ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            var s:FillShaderStyle = o as FillShaderStyle ;
            if ( s )
            {
                return (shader == s.shader) && (matrix == s.matrix) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var source:String = "new graphics.FillShaderStyle(null,"
                              + Matrixs.toSource( matrix ) 
                              + ")" ;
            return source ;
        }
    }
}
