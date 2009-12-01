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
package examples 
{
    import system.data.Iterator;
    
    import vegas.events.ModelObjectEvent;
    import vegas.models.collections.CollectionModelObject;
    import vegas.vo.SimpleValueObject;
    
    import flash.display.Sprite;
    
    public class CollectionModelObjectExample extends Sprite 
    {
        public function CollectionModelObjectExample()
        {
            var model:CollectionModelObject = new CollectionModelObject() ;
            
            model.addEventListener( ModelObjectEvent.ADD_VO           , debug ) ;
            model.addEventListener( ModelObjectEvent.BEFORE_CHANGE_VO , debug ) ;
            model.addEventListener( ModelObjectEvent.CHANGE_VO        , debug ) ;
            
            var count:uint = 4 ;
            
            for (var i:int ; i<count ; i++ ) 
            {
                model.addVO( new SimpleValueObject( { id:i } ) ) ;
            }
            
            var it:Iterator = model.iterator() ;
            
            while( it.hasNext() )
            {
                model.setCurrentVO( it.next() as SimpleValueObject ) ;
            }
        }
        
        public function debug( e:ModelObjectEvent ):void
        {
            trace( e.type + " : " + e.getVO() ) ;
        }
    }
}
