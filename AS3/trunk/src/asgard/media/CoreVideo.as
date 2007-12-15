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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.media 
{
	import flash.media.Video;
	
	import asgard.config.Config;
	import asgard.config.ConfigCollector;
	import asgard.config.IConfigurable;
	import asgard.display.DisplayObjectCollector;
	
	import vegas.core.ILockable;
	import vegas.core.Identifiable;
	import vegas.util.ClassUtil;	

	/**
	 * The CoreVideo class extends the flash.media.Video class and implements the IConfigurable, the Identifiable and the ILockable interfaces.
	 * @author eKameleon
	 */
	public class CoreVideo extends Video implements IConfigurable, Identifiable, ILockable
	{

		/**
		 * Creates a new CoreVideo instance.
		 * If no values for the width and height parameters are supplied, the default values are used. 
		 * You can also set the width and height properties of the Video object after the initial construction, using Video.width and Video.height. 
		 * When a new Video object is created, values of zero for width or height are not allowed ; 
		 * if you pass zero, the defaults will be applied. 
		 * @param id Indicates the id of the object.
		 * @param width The width of the video, in pixels. (default 320)
		 * @param height The width of the video, in pixels. (default 240)
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 */
		public function CoreVideo( id:*=null , width:int = 320, height:int = 240, isConfigurable:Boolean=false )
		{
			super( width , height ) ;
			this.id = id ;
			this.isConfigurable = isConfigurable ;
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
	 	 * Returns the {@code String} representation of this object.
	 	 * @return the {@code String} representation of this object.
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
	     * Returns {@code true} if the object is locked.
	     * @return {@code true} if the object is locked.
	     */
	    public function isLocked():Boolean 
	    {
        	return ___isLock___ ;
    	}
		
    	/**
	     * Locks the object.
	     */
	    public function lock():void 
	    {
        	___isLock___ = true ;
    	}
		
		/**
         * Setup the IConfigurable object.
         */
        public function setup():void
        {
			var config:Object = Config.getInstance()[ id ] ; 
			if ( config != null ) 
			{
				for (var prop:String in config)
				{
					this[prop] = config[prop] ; 
				}
			}
			update() ;	
        }
        
		/**
	 	 * Returns the {@code String} representation of this object.
	 	 * @return the {@code String} representation of this object.
	 	 */
		public override function toString():String
		{
			var str:String = "[" + ClassUtil.getName(this) ;
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
    	public function unLock():void 
    	{
	        ___isLock___ = false ;
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
		 * The internal id of this object.
		 * @private
		 */
		private var _id:* = null ;

		/**
		 * @private
		 */
		private var _isConfigurable:Boolean ;

	    /**
	     * The internal flag to indicates if the display is locked or not.
	     * @private
	     */ 
	    private var ___isLock___:Boolean = false ;

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
