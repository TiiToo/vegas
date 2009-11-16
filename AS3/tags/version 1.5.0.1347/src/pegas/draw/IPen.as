/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.draw 
{
    import flash.display.Graphics;
    
    /**
     * This interface defined the IPen implementation to creates shaped in Shape, Sprite and MovieClip objects.
     */
    public interface IPen extends Drawable 
    {
        /**
         * Determinates the align value of the pen.
         */
        function get align():uint ;
        
        /**
         * @private
         */
        function set align( align:uint ):void ; 
        
        /**
         * Determinates the fill style object of the pen.
         */
        function get fill():IFillStyle ;
        
        /**
         * @private
         */
        function set fill( style:IFillStyle ):void ;
        
        /**
         * Specifies the Graphics object belonging to this Shape object, where vector drawing commands can occur.
         */
        function get graphics():Graphics ;
        
        /**
         * @private
         */
        function set graphics( graphic:Graphics ):void ;
        
        /**
         * Determinates the line style object of the pen.
         */
        function get line():ILineStyle ;
        
        /**
         * @private
         */
        function set line( style:ILineStyle ):void ;
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        function drawShape():void ;
    }
}
