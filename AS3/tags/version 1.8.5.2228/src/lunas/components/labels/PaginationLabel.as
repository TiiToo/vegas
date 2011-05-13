/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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

package lunas.components.labels 
{
    import system.events.NumberEvent;
    
    import vegas.models.PageByPageModel;
    
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    /**
     * The pagination label component.
     */
    public class PaginationLabel extends Label
    {
        /**
         * Creates a new PaginationTitle instance.
         * @param w The prefered width of the button (default 610 pixels).
         * @param h The prefered height of the button (default 22 pixels).
         */
        public function PaginationLabel( w:Number = 610 , h:Number = 22 )
        {
            lock() ;
            pagination = new PageByPageModel() ;
            unlock() ;
            super( w , h );
        }
        
        /**
         * Indicates the current page number.
         */
        public function get currentPage():uint 
        {
            return _pagination.currentPage ;
        }
        
        /**
         * @private
         */
        public function set currentPage( value:uint ):void
        {
            _pagination.currentPage = value ;
        }
        
        /**
         * Indicates if the key controller is enabled.
         */
        public var enabledKey:Boolean = true ;
        
        /**
         * Indicates the first label value of this display.
         */
        public function get firstLabel():String
        {
            return _firstLabel ;
        }
            
        /**
         * @private
         */
        public function set firstLabel( str:String ):void
        {
            _firstLabel = str || "" ;
            update() ;
        }
        
        /**
         * Indicates the last label value of this display.
         */
        public function get lastLabel():String
        {
            return _lastLabel  ;
        }
        
        /**
         * @private
         */
        public function set lastLabel( str:String ):void
        {
            _lastLabel = str || "" ;
            update() ;
        }         
        
        /**
         * Indicates the array representation of all page numbers with the current navigator values. 
         */
        public function get pages():Array 
        {
            return _pagination.pages ;
        }
        
        /**
         * Indicates the limit until the current pages.
         */
        public function get limitPage() : uint
        {
            return _pagination.limitPage ;
        }
        
        /**
         * @private
         */
        public function set limitPage( value:uint ) : void
        {
           _pagination.limitPage = value ;
        }
        
        /**
         * Indicates the next label value of this display.
         */
        public function get nextLabel():String
        {
            return _nextLabel ;
        }
            
        /**
         * @private
          */
        public function set nextLabel( str:String ):void
        {
            _nextLabel = str || "" ;
            update() ;
        }
        
        /**
         * Return the _pagination reference.
         */
        public function get pagination():PageByPageModel
        {
            return _pagination ;
        }
        
        /**
         * @private
         */
        public function set pagination( pagination:PageByPageModel ) : void
        {
            if ( _pagination != null )
            {
                _pagination.removeEventListener( _pagination.getEventTypeCHANGE() , _paginationChange ) ;
            }
            _pagination = pagination || new PageByPageModel() ;
            _pagination.addEventListener( _pagination.getEventTypeCHANGE() , _paginationChange ) ;
            if ( !isLocked() )
            {
                _pagination.run() ;
            }
        }
        
        /**
         * Indicates the previous label value of this display.
         */
        public function get previousLabel():String
        {
            return _previousLabel ;
        }
            
        /**
         * @private
          */
        public function set previousLabel( str:String ):void
        {
            _previousLabel = str || "" ;
            update() ;
        }
        
        /**
         * Indicates the title value of this display.
         */
        public function get title():String
        {
            return _title ;
        }
            
        /**
         * @private
          */
        public function set title( str:String ):void
        {
            _title = str || "" ;
            update() ;
        }
        
        /**
         * Indicates the pages total number.
         */
        public function get totalPage():uint
        {
            return _pagination.totalPage ;
        }
        
        /**
         * @private
         */
        public function set totalPage( value:uint ) : void
        {
            _pagination.totalPage = value ;
        }
        
        /**
         * Returns the IBuilder constructor use to initialize this component.
         * @return the IBuilder constructor use to initialize this component.
         */
        public override function getBuilderRenderer():Class 
        {
            return PaginationLabelBuilder ;
        }
        
        /**
         * Returns the Style constructor use to initialize this component.
         * @return the Style constructor use to initialize this component.
         */
        public override function getStyleRenderer():Class 
        {
            return PaginationLabelStyle ;
        }
        
        /**
         * Notify a change with the current selected page.
         */
        public function notifyChange( page:Number ):void
        {
            dispatchEvent( new NumberEvent( Event.CHANGE , page ) );
        }
        
        /**
         * Sets the pagination navigator inside the title.
         */
        public function setNavigator( current:uint=1 , total:uint=1 , limit:uint=5 ):void
        {
            _pagination.setNavigator( current, total, limit ) ;
        }
        
        /**
         * Invoked when the display is added to the stage.
         */
        protected override function addedToStage( e:Event = null ):void
        {
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        /**
         * Invoked when a key is down in the stage.
         */
        protected function keyDown( e:KeyboardEvent = null ):void
        {
            var code:uint = e.keyCode ;
            
            var b:PaginationLabelBuilder = builder as PaginationLabelBuilder ;
            
            if ( enabledKey == false || b == null || b.field == null || (stage.focus != b.field ) ) 
            {
                return ;
            }
            
            var old:uint = pagination.currentPage ;
            
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    if ( pagination.currentPage > 1 )
                    {
                        pagination.currentPage -- ;
                    }
                    break ; 
                }
                case Keyboard.RIGHT :
                {
                    if ( pagination.currentPage < pagination.totalPage )
                    {
                        pagination.currentPage ++ ;
                    }
                    break ;
                }
            }
            
            if ( currentPage != old )
            {
                notifyChange(currentPage) ;
            }
        }
        
        /**
         * Invoked when the display is removed from the stage.
         */
        protected override function removedFromStage( e:Event = null ):void
        {
            stage.removeEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;  
        }
        
        /**
         * @private
         */
        private var _firstLabel:String = "First" ;
        
        /**
         * @private
         */
        private var _lastLabel:String = "Last" ;
        
        /**
         * @private
         */
        private var _nextLabel:String = "Next" ;
        
        /**
         * @private
         */
        private var _pagination:PageByPageModel ;
        
        /**
         * @private
         */
        private var _previousLabel:String = "Previous" ;
        
        /**
         * @private
         */
        private var _title:String = "Pages" ;
        
        /**
         * @private
         */
        private function _paginationChange( e:Event = null ):void
        {
            update() ;
        }
    }
}
