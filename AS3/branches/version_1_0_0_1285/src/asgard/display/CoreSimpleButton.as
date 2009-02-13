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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.display 
{
    import andromeda.config.Config;
    
    import system.Reflection;
    
    import vegas.core.HashCode;
    import vegas.logging.ILogger;
    import vegas.logging.Log;
    
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;    

    /**
	 * The CoreSimpleButton class extends the flash.display.SimpleButton class and implements the IDisplayObject interface.
     * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import asgard.display.CoreSimpleButton ;
	 * import asgard.display.DisplayObjectCollector ;
	 * 
	 * import flash.events.MouseEvent ;
	 * 
	 * var click:Function = function( e:MouseEvent ):void
	 * {
	 *     trace(e) ;
	 * }
	 * 
	 * var button:CoreSimpleButton = new CoreSimpleButton( "my_button" , new UpState() , new OverState(), new DownState(), new HitTestState() ) ;
	 * button.addEventListener( MouseEvent.CLICK , click ) ;
	 * 
	 * addChild( button ) ;
	 * 
	 * trace( "DisplayObject contains 'mybutton' : " + DisplayObjectCollector.contains( "my_button" ) ) ;
	 * trace( DisplayObjectCollector.get( "my_button" ) ) ;
	 * </pre>
	 */
	public class CoreSimpleButton extends SimpleButton implements IDisplayObject
	{

		/**
		 * Creates a new CoreSimpleButton instance.
		 * @param id Indicates the id of the object.
		 * @param upState The initial value for the SimpleButton up state. 
		 * @param overState The initial value for the SimpleButton over state. 
		 * @param downState The initial value for the SimpleButton down state.
		 * @param hitTestState The initial value for the SimpleButton hitTest state.  
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object. 
		 */
		public function CoreSimpleButton( id:*=null , upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null, name:String=null  )
		{
			super( upState, overState, downState, hitTestState ) ;
			if ( id != null )
			{
				this.id = id ;
			}
			if ( name != null )
			{
				this.name = name ;
			}
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
	    private var ___isLock___:uint ;
		
	    /**
	     * @private
	     */ 
		private var _logger:ILogger ;
		
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
