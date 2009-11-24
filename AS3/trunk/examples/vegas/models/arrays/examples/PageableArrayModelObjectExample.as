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
package examples 
{
    import system.events.ArrayEvent;
    
    import vegas.events.ModelObjectEvent;
    import vegas.models.arrays.PageableArrayModelObject;
    import vegas.vo.SimpleValueObject;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    public class PageableArrayModelObjectExample extends Sprite 
    {
        public function PageableArrayModelObjectExample()
        {
            model = new PageableArrayModelObject() ;
            
            model.count =  1 ;
            model.count =  2 ;
            
            model.addEventListener( ModelObjectEvent.UPDATE_VO , update ) ;
            
            var datas:Array = [] ;
            var count:uint  = 20 ;
            
            for (var i:uint = 0 ; i<count ; i++ ) 
            {
                datas.push( new SimpleValueObject( { id:i } ) ) ;
            }
            
            model.init( datas ) ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            trace( "Press Keyboard.LEFT and Keyboard.RIGHT keys to test this model" ) ;
            trace( "Press Keyboard.SPACE to use a page with 4 items inside (change count of items)." ) ;
            
            model.currentPage = 2 ;
        }
        
        public var model:PageableArrayModelObject ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    if ( model.hasPrevious() == false )
                    {
                        model.lastPage() ;
                    }
                    else
                    {
                        model.previous() ;
                    }
                    break ;
                }
                
                case Keyboard.RIGHT :
                {
                    if ( model.hasNext() == false )
                    {
                        model.firstPage() ;
                    }
                    else
                    {
                        model.next() ;
                    }
                    break ;
                }
                case Keyboard.SPACE :
                {
                    model.setCount( 4 , true ) ; // change the count value but not auto restart the update process of the model.
                }
            }
        }
        
        public function update( e:Event ):void
        {
            switch( true )
            {
                case e is ArrayEvent :
                {
                    trace( e + " : " + (e as ArrayEvent).array ) ;
                    break ;
                }
                case e is ModelObjectEvent :
                {
                    trace( e + " : " + (e as ModelObjectEvent).getVO() ) ;
                    break ;
                }
                default :
                {
                    trace( e + " : unknow type of event.") ;
                }
            }
        }
    }
}
