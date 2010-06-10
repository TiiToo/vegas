/*

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
            
            // model.count =  1 ;
            // model.count =  5 ;
            
            model.count =  4 ;
            
            model.addEventListener( Event.INIT                 , init   ) ;
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
            
            trace("--------") ;
            
            var vo:SimpleValueObject ;
            
            vo = model.getVO( 4 ) as SimpleValueObject ;
            model.currentPage = model.pageOf(vo) ;
            
            trace("--------") ;
        }
        
        public var model:PageableArrayModelObject ;
        
        public function init( e:Event ):void
        {
            trace( e ) ;
        }
        
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
                    trace( "page " + model.currentPage + " : " + (e as ArrayEvent).array ) ;
                    break ;
                }
                case e is ModelObjectEvent :
                {
                    trace( "page " + model.currentPage + " : " + (e as ModelObjectEvent).getVO() ) ;
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
