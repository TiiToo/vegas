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
package mvc.model
{
    import mvc.vo.PictureVO;
    
    import vegas.models.maps.OrderedMapModelObject;
    
    /**
     * The model of all pictures.
     */
    public final class PictureModel extends OrderedMapModelObject
    {
        /**
         * Creates a new PictureModel instance.
         * @param id the id of this model.
         */
        public function PictureModel( id:* = null )
        {
            super( id ) ;
        }
        
        /**
         * Returns <code>true</code> if the <code>IValidator</code> object validate the value. Overrides this method in your concrete IModelObject class.
         * @param value the object to test.
         * @return <code>true</code> is this specific value is valid.
         */
        public override function supports( value:* ):Boolean 
        {
            return value is PictureVO ;
        }
    }
}