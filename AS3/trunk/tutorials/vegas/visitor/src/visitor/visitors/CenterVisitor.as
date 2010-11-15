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

