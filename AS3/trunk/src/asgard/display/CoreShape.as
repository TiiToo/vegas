﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.display 
{
    import flash.display.Shape;
    import flash.events.Event;
    
    import asgard.config.Config;
    import asgard.config.ConfigCollector;
    
    import system.Reflection;
    
    import vegas.core.HashCode;
    import vegas.logging.ILogger;
    import vegas.logging.Log;    

    /**
	 * The CoreShape class extends the flash.display.Shape class and implements the IDisplayObject interface.
	 * @example
	 * <pre class="prettyprint">
	 * import asgard.display.CoreShape ;
	 * import asgard.display.DisplayObjectCollector ;
	 * 
	 * var shape:CoreShape = new CoreShape( "my_shape" ) ;
	 * shape.x = 25 ;
	 * shape.y = 25 ;
	 * 
	 * shape.graphics.beginFill( 0xFF0000 , 100 ) ;
	 * shape.graphics.drawRect( 0, 0, 200, 160 ) ;
	 * 
	 * addChild( shape ) ;
	 * 
	 * trace( "DisplayObject contains 'my_shape' : " + DisplayObjectCollector.contains( "my_shape" ) ) ;
	 * trace( DisplayObjectCollector.get( "my_shape" ) ) ;
	 * </pre>
	 * @author eKameleon
	 */
	public class CoreShape extends Shape implements IDisplayObject
	{

		/**
		 * Creates a new CoreShape instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function CoreShape( id:*=null, isConfigurable:Boolean=false, name:String=null  )
		{
			if ( id != null )
			{
				this.id = id ;
			}
			if ( name != null )
			{
				this.name = name ;
			}
			this.isConfigurable = isConfigurable ;
            addEventListener( Event.ADDED_TO_STAGE      , addedToStage ) ;
            addEventListener( Event.REMOVED_FROM_STAGE  , removedFromStage ) ;
			setLogger() ;
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
		 * Indicates if the display is configurable.
		 */
		public function get isConfigurable():Boolean
		{
			return _isConfigurable ;
		}
				
		/**
		 * @private
		 */
		public function set isConfigurable(b:Boolean):void
		{
			_isConfigurable = (b == true) ;
			if (_isConfigurable)
			{
				ConfigCollector.insert(this) ;	
			}
			else
			{
				ConfigCollector.remove(this) ;
			}
		}

		/**
		 * Returns the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
		 * @return the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
		 */
		public function getLogger():ILogger
		{
			return _logger ; 	
		}
		
		/**
		 * Returns a hashcode value for the object.
		 * @return a hashcode value for the object.
		 */
		public function hashCode():uint 
		{
			if ( isNaN( __hashcode__ ) ) 
			{
				__hashcode__ = HashCode.next() ;
			}
			return __hashcode__ ;
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
		 * Sets the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
		 */
		public function setLogger( log:ILogger=null ):void 
		{
			_logger = ( log == null ) ? Log.getLogger( Reflection.getClassPath(this) ) : log ;
		}
		
		/**
         * Setup the IConfigurable object.
         */
        public function setup():void
        {
        	if ( id != null )
        	{
				Config.getInstance().init( this , id , update ) ;
        	}	
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
		 * Update the display.
		 * You must override this method. This method is launch by the setup() method when the Config is checked.
		 */	
		public function update():void
		{
			// overrides this method.
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
		private var __hashcode__:Number ;

		/**
		 * @private
		 */
		private var _id:* = null ;

		/**
		 * @private
		 */
		private var _isConfigurable:Boolean ;

	    /**
	     * @private
	     */ 
	    private var ___isLock___:uint ;
		
	    /**
	     * @private
	     */ 
		private var _logger:ILogger ;

		/**
		 * Sets the id of the object and register it in the DisplayObjectCollector if it's possible.
		 * @see DisplayObjectCollector.
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
