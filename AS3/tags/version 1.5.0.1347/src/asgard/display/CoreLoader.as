/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.display 
{
    import system.Reflection;
    import system.logging.Log;
    import system.logging.Logger;
    
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    
    /**
     * The CoreLoader class extends the flash.display.Loader class and implements the IDisplayObject interface.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.display.CoreLoader ;
     * import asgard.display.DisplayObjectCollector ;
     * 
     * import flash.net.URLRequest ;
     * 
     * var loader:CoreLoader = new CoreLoader( "my_loader" ) ;
     * loader.x = 25 ;
     * loader.y = 25 ;
     * 
     * addChild( loader ) ;
     * 
     * var url:String = "library/picture.jpg" ;
     * var request:URLRequest = new URLRequest( url ) ;
     * 
     * loader.load( request ) ;
     * 
     * trace( "DisplayObject contains 'my_loader' : " + DisplayObjectCollector.contains( "my_loader" ) ) ;
     * trace( DisplayObjectCollector.get( "my_loader" ) ) ;
     * </pre>
     */
    public class CoreLoader extends Loader implements IDisplayObject 
    {
        /**
         * Creates a new CoreLoader instance.
         * @param id Indicates the id of the object.
         * @param name Indicates the instance name of the object.
         */
        public function CoreLoader( id:*=null, name:String=null  )
        {
            if ( id != null )
            {
                this.id = id ;
            }
            if ( name != null )
            {
                this.name = name ;
            }
            logger = null ;
        }
        
        /**
         * The LoaderContext object of this loader.
         */
        public function get context():LoaderContext
        {
            return _context ;
        }
        
        /**
         * @private
         */
        public function set context( context:LoaderContext ):void
        {
            _context = context || null ;
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
         * @private
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
         * Loads a SWF, JPEG, progressive JPEG, unanimated GIF, or PNG file into an object that is a child of this Loader object.
         * @param request The absolute or relative URL of the SWF, JPEG, GIF, or PNG file to be loaded. A relative path must be relative to the main SWF file. Absolute URLs must include the protocol reference, such as http:// or file:///. Filenames cannot include disk drive specifications.
         * @param context A LoaderContext object.
         */
        public override function load( request:URLRequest , context:LoaderContext = null ):void
        {
            if ( context != null )
            {
                this.context = context ;
            }
            super.load( request , this.context ) ;
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
         * @private
         */
        private var _context:LoaderContext ;
        
        /**
         * @private
         */
        private var _id:* = null ;
        
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
