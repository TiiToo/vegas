/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

// TODO finish mask + layout of the childs 

package lunas.display.container 
{
	import lunas.core.AbstractComponent;
	import lunas.core.Direction;
	import lunas.core.IDirectionable;	

	/**
	 * The ListContainer class is a list container component. 
	 * @author eKameleon
	 */
	public class ListContainer extends Container implements IDirectionable
	{

		/**
		 * Creates a new ListContainer instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function ListContainer(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name );
		}

		/**
		 * Returns the number of childs in this container.
		 * @return the number of childs in this container.
		 */
		public function get childCount():int 
		{
			return _childCount > numChildren ? numChildren : _childCount ;
		}
	
		/**
		 * Sets the number of childs visible in this container. 
		 * If this value is -1 no mask effect is apply over the list container, all the childs are visible.
		 * @param value The number of childs visible in the container.
		 */
		public function set childCount( value:int ):void 
		{
			_childCount = value > -1 ? value : -1 ; // -1 no mask effect
			_bMaskIsActive = _childCount > 0 ;
			update() ;
		}

		/**
		 * Indicates the direction value of this object.
		 * @see Direction
		 */
		public function get direction():String
		{
			return _direction ;
		}

		/**
		 * @private
		 */
		public function set direction(value:String):void
		{
			_direction = (value == Direction.HORIZONTAL) ? Direction.HORIZONTAL : Direction.VERTICAL ;
		}
		
		/**
		 * The height property name use in the container to layout all items.
		 */
		public var propHeight:String = "height" ;
		
		/**
		 * The x property name use in the container to layout all items.
		 */
		public var propX:String = "x" ;
		
		/**
		 * The y property name use in the container to layout all items.
		 */
		public var propY:String = "y" ;
		
		/**
	 	 * The width property name use in the container to layout all items.
	 	 */
		public var propWidth:String = "width" ;
		
		/**
		 * (read-write) Indicates if this container use a scrollRect reference to mask the content.
		 */
		public function get useScrollRect():Boolean
		{
			return _useScrollRect ;
		}

		/**
		 * @private
		 */
		public function set useScrollRect( b :Boolean ):void
		{
			_useScrollRect = b ;
			update() ;
		}
		
		/**
		 * @private
		 */
		private var _bMaskIsActive:Boolean ;
		
		/**
		 * @private
		 */
		private var _childCount:int = -1 ;
		
		/**
		 * @private
		 */
		private var _direction:String = Direction.VERTICAL ;
		
		/**
		 * @private
		 */
		private var _useScrollRect:Boolean = false ;
		
	}	

}
