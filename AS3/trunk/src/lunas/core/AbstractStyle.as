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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.core 
{
	import flash.text.StyleSheet;
	
	import lunas.events.StyleEvent;
	
	import system.Reflection;
	
	import vegas.events.AbstractCoreEventDispatcher;	

	/**
	 * This class provides a skeletal implementation of the {@code IStyle} interface, to minimize the effort required to implement this interface.
	 * @author eKameleon
 	 */
	public class AbstractStyle extends AbstractCoreEventDispatcher implements IStyle
	{
		
		/**
		 * Creates a new AbstractStyle instance.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
		 */
		public function AbstractStyle ( id:*=null , init:*=null )
		{
			if ( id != null )
			{
				this.id = id ;
			}
			if ( init != null )
			{		
				for (var prop:String in init) 
				{
					this[prop] = init[prop] ;
				}
			}
			initialize() ;
			update() ;
		}

		/**
		 * (read-write) Indicates the id of this IStyle object.
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
		 * Indicates the style sheet reference of this object.
		 */
		public function get styleSheet():StyleSheet
		{
			return _ss ;
		}
	
		/**
		 * @private
		 */		
		public function set styleSheet(ss:StyleSheet):void
		{
			_ss = ss ;
			styleSheetChanged() ;
			update() ;
			dispatchEvent( new StyleEvent( StyleEvent.STYLE_SHEET_CHANGE , this ) ) ;
		}

		/**
		 * Returns the value of the specified property if it's exist in the object, else returns null.
		 * @return the value of the specified property if it's exist in the object or {@code null}.
		 */
		public function getStyle(prop:String):*
		{
			if ( prop in this )
			{
				return this[prop] ;
			}
			else
			{
				return null ;	
			}
		}

		/**
		 * Invoked in the constructor of the {@code IStyle} instance.
		 */
		public function initialize():void
		{
			// overrides this method.
		}
		
		public function setStyle( ...args:Array ):void
		{
			if (args.length == 0 ) 
			{
				return ;
			} 
				
			if (  args[0] is String && args.length == 2 ) 
			{
				if ( args[0] in this ) 
				{
					this[ args[0] ] = args[1] ;
					dispatchEvent( new StyleEvent( StyleEvent.STYLE_CHANGE , this ) ) ;
				}
			}
			else if ( args[0] is Object ) 
			{
				var prop:* = args[0] ;
				for (var i:String in prop) 
				{
					this[i] = prop[i] ;
				}
				dispatchEvent( new StyleEvent( StyleEvent.STYLE_CHANGE , this ) ) ;
			}
		}
		
		/**
		 * Invoked when a style property of this {@code IStyle} change.
		 * By default this method is empty, you can override this method.
		 */
		public function styleChanged():void 
		{
			// override
		}
			
		/**
		 * Invoked when the styleSheet value of this {@code IStyle} change.
		 * By default this method is empty, you can override this method.
		 */
		public function styleSheetChanged():void 
		{
			// override
		}
		
		/**
	 	 * Returns the {@code String} representation of this object.
	 	 * @return the {@code String} representation of this object.
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
		 * Updates the {@code IStyle} object.
		 * By default this method is empty, you can override this method.
		 */
		public function update():void
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
		private var _ss:StyleSheet ;

		/**
		 * Sets the id of the object and register it in the StyleCollector if it's possible.
		 * @see StyleCollector.
		 */
		private function _setID( id:* ):void 
		{
			if ( StyleCollector.contains( this._id ) )
			{
				StyleCollector.remove( this._id ) ;
			}
			this._id = id ;
			if ( this._id != null )
			{
				StyleCollector.insert ( this._id, this ) ;
			}
		}

	}
}
