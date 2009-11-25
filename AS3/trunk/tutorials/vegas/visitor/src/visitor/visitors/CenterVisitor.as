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

package visitor.visitors
{
    import vegas.utils.visitors.Visitable;
    import vegas.utils.visitors.Visitor;
    
    import visitor.display.Picture;
    
    import flash.display.DisplayObject;
    
    /**
     * This visitor align (center) a display with the passed in Visitable object (must be a Picture reference).
     */
	public class CenterVisitor implements Visitor
    {
        /**
         * Creates a new CenterVisitor instance.
         * @param target The target of the DisplayObject to align (center).
         */
        public function CenterVisitor( target:DisplayObject )
        {
            this.target = target ;
        }
        
        /**
         * The target of the display to center with the visitable object.
         */
        public var target:DisplayObject ;
        
        /**
         * Visit the Visitable object. 
         */
        public function visit(o:Visitable):void
        {
            var picture:Picture = o as Picture ;
            trace( this + " visit : " + picture ) ;
            if ( picture != null && target != null )
            {
                target.x = ( picture.w - target.width  ) / 2 ;
                target.y = ( picture.h - target.height ) / 2 ;
            }
            else
            {
                throw new Error(this + " 'visit' method failed, the argument of this method must be a Picture instance.") ;
            }
        }
    }
}

