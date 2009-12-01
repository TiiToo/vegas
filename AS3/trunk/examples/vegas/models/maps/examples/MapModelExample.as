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
    import system.data.maps.ArrayMap;
    
    import vegas.events.EntryEvent;
    import vegas.models.maps.MapModel;
    
    import flash.display.Sprite;
    
    public class MapModelExample extends Sprite 
    {
        public function MapModelExample()
        {
            var model:MapModel = new MapModel() ;
            
            model.setMap( new ArrayMap() ) ;
            
            model.addEventListener( EntryEvent.ADD           , debug ) ;
            model.addEventListener( EntryEvent.BEFORE_CHANGE , debug ) ;
            model.addEventListener( EntryEvent.CHANGE        , debug ) ;
            model.addEventListener( EntryEvent.REMOVE        , debug ) ;
            model.addEventListener( EntryEvent.UPDATE        , debug ) ;
            
            var count:uint = 4 ;
            
            for (var i:int ; i<count ; i++ ) 
            {
                model.put( "key" + i , "value" + i ) ;
            }
            
            var it:Iterator = model.keyIterator() ;
            
            while( it.hasNext() )
            {
                model.current = it.next() ;
            }
            
            trace( "- model current : " + model.current ) ;
            
            trace( "- model size : " + model.size() ) ;
            
            model.remove( "key2" ) ;
            
            trace( "- model size : " + model.size() ) ;
            
            model.update( "key3" , "content3" ) ;
        }
        
        public function debug( e:EntryEvent ):void
        {
            trace( "# type:" + e.type + " entry:" + e.entry ) ;
        }
    }
}
