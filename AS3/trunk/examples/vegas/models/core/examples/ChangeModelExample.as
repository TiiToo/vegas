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
    import vegas.events.ValueEvent;
    import vegas.models.ChangeModel;
    
    import flash.display.Sprite;
    
    public class ChangeModelExample extends Sprite 
    {
        public function ChangeModelExample()
        {
            var model:ChangeModel = new ChangeModel() ;
            
            model.addEventListener( ValueEvent.BEFORE_CHANGE , debug ) ;
            model.addEventListener( ValueEvent.CHANGE        , debug ) ;
            model.addEventListener( ValueEvent.CLEAR         , debug ) ;
            
            model.current = "value1" ;
            model.current = "value2" ;
            
            model.clear() ;
        }
        
        public function debug( e:ValueEvent ):void
        {
            trace( "# type:" + e ) ;
        }
    }
}
