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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
  
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

package vegas.models 
{
    import system.events.ArrayEvent;
    import system.numeric.Range;
    
    import vegas.models.CoreModel;
    
    import flash.events.Event;
    
    /**
     * The page navigator model.
     */
    public class PageByPageModel extends CoreModel
    {
        /**
         * Creates a new PageByPageModel instance.
         * @param current the current page of the model.
         * @param total the total number of the model.
         * @param limit the limit number of pages of the model. 
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         * @param id the id of the model.
         */
        public function PageByPageModel( current:uint = 1 , total:uint = 1 , limit:uint = 5 , global:Boolean = false , channel:String = null , id:* = null )
        {
            super( global , channel , id ) ;
            _sChangeType = Event.CHANGE ;
            _range       = new Range( 1 , 1 ) ;
            setNavigator( current, total, limit ) ;
        }
        
        /**
         * Returns the current page number.
         * @return the current page number.
         */
        public function get currentPage() : uint 
        {
            return _currentPage ;
        }
        
        /**
         * Indicates the current page number.
         */
        public function set currentPage( value:uint ):void
        {
            _currentPage = _range.clamp( value > 1 ? value : value ) ;
            run() ;
        }
        
        /**
         * Indicates the array representation of all page numbers with the current navigator values.
         */
        public function get pages():Array 
        {
            return _pages ;
        }
        
        /**
         * Indicates the limit until the current pages.
         */
        public function get limitPage():uint
        {
            return _limitPage ;
        }
        
        /**
         * @private
         */
        public function set limitPage( value:uint ) : void
        {
           _limitPage = value ;
           run() ;
        }
        
        /**
         * Indicates the pages total number.
         */
        public function get totalPage():uint
        {
            return _totalPage ;
        }
        
        /**
         * @private
         */
        public function set totalPage( value:uint ) : void
        {
            _totalPage   = value > 1 ? value : 1 ;
            _range.max   = _totalPage ;
            currentPage  = 1 ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">run</code> method.
         * @return the event name use in the <code class="prettyprint">run</code> method.
         */
        public function getEventTypeCHANGE():String
        {
            return _sChangeType ;
        }
        
        /**
         * Notify a <code class="prettyprint">ArrayEvent</code> when a Array pages change in the model.
         */
        public function notifyChange( value:Array ):void
        {
            if ( isLocked( ) )
            {
                return ;
            }
            dispatchEvent( new ArrayEvent( _sChangeType , value ) );
        }
        
        /**
         * Run the first process with this model.
         */
        public override function run( ...args:Array ):void 
        {
            if ( isLocked() )
            {
                return ;
            }
            if( totalPage > 1 )
            {
                var a       : Array = [] ;
                var current : uint  = currentPage ;
                var r       : uint  = limitPage ;
                
                var firstPage : uint = 1 ;
                var lastPage  : uint = current + r ;
                
                // define the first page.
                
                if( current - r > firstPage )
                {
                   firstPage = current - r ;
                }
                
                // define the last page.
                
                if( lastPage > totalPage )
                {
                    lastPage = totalPage ;
                }    
                
                var i:uint ;
                for( i = firstPage ; i <= lastPage ; i++ )
                {
                    a.push( i ) ;
                }
                
                _pages =  a  ;
            }
            else
            {
                _pages = null ;
            }
            notifyChange( pages ) ;
        }
        
        /**
         * Sets the navigator attributes and run the model.
         */
        public function setNavigator( current:uint=1 , total:uint=1 , limit:uint=5 ):void
        {
            lock() ;
            totalPage   = total   ;
            currentPage = current ;
            limitPage   = limit   ;
            unlock() ;
            run() ;
        }
        
        /**
         * @private
         */
        private var _currentPage:uint ;
        
        /**
         * @private
         */
        private var _limitPage:uint ;
            
        /**
         * @private
         */
        private var _pages:Array ;
        
        /**
         * @private
         */
        private var _range:Range ;
        
        /**
         * @private
         */
        private var _sChangeType:String ;
        
        /**
         * @private
         */
        private var _totalPage:uint ;
    }
}
