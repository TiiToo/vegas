/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package visitor.display
{
    import vegas.utils.visitors.Visitable;
    import vegas.utils.visitors.Visitor;
    
    import flash.display.Sprite;
    
    /**
     * The Picture class.
     */
    public class Picture extends Sprite implements Visitable
    {
        /**
         * Creates a new Picture instance.
         */
        public function Picture( w:uint = 260 , h:uint = 260 ) 
        {
            this.w = w ;
            this.h = h ;
            update() ;
        }
        
        /**
         * The virtual height of the picture to draw this background.
         */  
        public var h:uint ;
        
        /**
         * The virtual width of the picture to draw this background.
         */  
        public var w:uint ;
        
        /**
         * Accept a Visitor object.
         */
        public function accept( visitor:Visitor ):void
        {
            visitor.visit(this) ;
        }
        
        /**
         * Update the view of the display.
         */
        public function update():void
        {
            graphics.clear() ;
            graphics.beginFill( 0 ) ;
            graphics.drawRect( 0 , 0 , w , h ) ;
        }
    }
}