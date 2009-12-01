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

package vegas.text 
{
    import system.Reflection;
    import system.logging.Log;
    import system.logging.Logger;
    
    import vegas.display.DisplayObjectCollector;
    import vegas.display.IDisplayObject;
    
    import flash.events.Event;
    import flash.text.TextField;
    
    /**
     * The CoreTextField class extends the flash.text.TextField class and implements the IDisplayObject interface.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.display.DisplayObjectCollector ;
     * import vegas.text.CoreTextField ;
     * 
     * var field:CoreTextField = new CoreTextField( "my_field" , 150 , 22 ) ;
     * 
     * field.x                 = 25 ;
     * field.y                 = 25 ;
     * field.background        = true ;
     * field.backgroundColor   = 0x000000 ;
     * field.border            = true ;
     * field.borderColor       = 0xFFFFFF ;
     * field.defaultTextFormat = new TextFormat("arial", 11, 0xFFFFFF, true, null, null, null, null, "center") ;
     * field.text              = "hello world" ;
     * 
     * trace( "DisplayObject contains 'my_field' : " + DisplayObjectCollector.contains( "my_field" ) ) ;
     * trace( DisplayObjectCollector.get( "my_field" ) ) ;
     * 
     * addChild(field) ;
     */
    public class CoreTextField extends TextField implements IDisplayObject
    {
        /**
         * Creates a new CoreTextField instance.
         * @param id Indicates the id of the object.
         * @param width Indicates the width of the display object, in pixels.
         * @param height Indicates the height of the display object, in pixels.
         * @param name Indicates the instance name of the object.
         */
        public function CoreTextField( id:*=null , width:Number=100 , height:Number=100, name:String=null )
        {
            addEventListener( Event.ADDED_TO_STAGE      , addedToStage ) ;
            addEventListener( Event.REMOVED_FROM_STAGE  , removedFromStage ) ;
            if ( id != null )
            {
                this.id = id ;
            }
            if ( name != null )
            {
                this.name = name ;
            }
            this.width  = width  ;
            this.height = height ;
            this.logger = null   ;
        }
        
        /**
         * Returns the id of this object.
         * @return the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
          * Returns the <code class="prettyprint">String</code> representation of this object.
          * @return the <code class="prettyprint">String</code> representation of this object.
          */
        public function set id( id:* ):void
        {
            _setID( id ) ;
        }
        
        /**
         * Determinates the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">Logable</code> object.
         */
        public function get logger():Logger
        {
            return _logger ;
        }
        
        /**
         * @private
         */
        public function set logger( log:Logger ):void 
        {
            _logger = ( log == null ) ? Log.getLogger( Reflection.getClassPath(this) ) : log ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return ___isLock___ > 0 ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            ___isLock___ ++ ;
        }
        
        /**
         * Reset the lock security of the display.
         */
        public function resetLock():void 
        {
            ___isLock___ = 0 ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " " + this.id ;
            } 
            str += "]" ;
            return str ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = Math.max( ___isLock___ - 1  , 0 ) ;
        }
        
        /**
         * Invoked when the display is added to the stage.
         */
        protected function addedToStage( e:Event = null ):void
        {
            //
        }
        
        /**
         * Invoked when the display is removed from the stage.
         */
        protected function removedFromStage( e:Event = null ):void
        {
            //
        }
        
        /**
         * @private
         */
        private var _id:* ;
        
        /**
         * @private
         */ 
        private var ___isLock___:uint ;
        
        /**
         * @private
         */ 
        private var _logger:Logger ;
        
        /**
         * Sets the id of the object and register it in the DisplayObjectCollector if it's possible.
         * @see DisplayObjectCollector
         * @private
         */
        private function _setID( id:* ):void 
        {
            if ( DisplayObjectCollector.contains( this._id ) )
            {
                DisplayObjectCollector.remove( this._id ) ;
            }
            this._id = id ;
            if ( this._id != null )
            {
                DisplayObjectCollector.insert ( this._id, this ) ;
            }
        }
    }
}
