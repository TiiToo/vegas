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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package visitor.visitors
{
    import vegas.utils.visitors.Visitable;
    import vegas.utils.visitors.Visitor;
    
    import visitor.display.Picture;
    
    /**
     * This visitor show the Picture reference of the application.
     */
	public class ShowVisitor implements Visitor
    {
        /**
         * Creates a new ShowVisitor instance.
         */
        public function ShowVisitor()
        {
            super();
        }
        
        /**
         * Show a Picture object. Visit the Visitable object.
         */
        public function visit(o:Visitable):void
        {
            var picture:Picture = o as Picture ;
            trace( this + " visit : " + picture ) ;
            if ( picture != null )
            {
                picture.visible = true ;
            }
            else
            {
                throw new Error(this + " 'visit' method failed, the argument of this method must be a Picture instance.") ;
            }
        }
	}
}
