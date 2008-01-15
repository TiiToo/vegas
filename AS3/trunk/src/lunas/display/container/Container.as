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
package lunas.display.container 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import lunas.core.AbstractComponent;
	import lunas.events.ComponentEvent;	

	/**
	 * The Container class is the base components for all objects that can serve as display object containers on the display list. 
	 * @author eKameleon
	 */
	public class Container extends AbstractComponent 
	{

		/**
		 * Creates a new Container instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function Container(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name ) ;
		}
		
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. 
		 * The child is added to the front (top) of all other children in this DisplayObjectContainer instance. 
		 * (To add a child to a specific index position, use the addChildAt() method.)
		 * If you add a child object that already has a different display object container as a parent, 
		 * the object is removed from the child list of the other display object container.
		 * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
		 * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
		 * @return The DisplayObject instance that you pass in the child parameter.  
		 */
		public override function addChild( child:DisplayObject ):DisplayObject
		{
			var d:DisplayObject = super.addChild( child ) ;
			update() ;
			return d ;
		}
		
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added at the index position specified. 
		 * An index of 0 represents the back (bottom) of the display list for this DisplayObjectContainer object. 
		 * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance. 
		 * @param index The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list. 
		 * @throws RangeError Throws if the index position does not exist in the child list.
		 * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
		 * @return The DisplayObject instance that you pass in the child parameter. 
		 */
		public override function addChildAt( child:DisplayObject , index:int ):DisplayObject
		{
			var d:DisplayObject = super.addChildAt(child, index) ;
			update() ;
			return d ;
		}
		
		/**
		 * Removes all childs in the container.
		 */
		public function clear():void
		{
			var size:uint = numChildren ;
			while(--size > -1)
			{
				removeChildAt( size ) ; 
			}
			update() ;
			_fireComponentEvent( ComponentEvent.CLEAR ) ;
		}

		/**
		 * Returns {@code true} if a child exist in the display list at the specified index value.
		 * @return {@code true} if a child exist in the display list at the specified index value.
		 */
		public function containsAt( index:int ):Boolean 
		{
			return getChildAt(index) != null ;
		}

		/**
		 * Returns the index number value of the specified child reference in argument.
		 * @return the index number value of the specified child reference in argument.
		 */
		public function indexOf( child:DisplayObject ):int 
		{
			return getChildIndex( child ) ;
		}
		
		/**
		 * Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance. 
		 * The parent property of the removed child is set to null , and the object is garbage collected if no other references to the child exist. 
		 * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
		 * @param child The DisplayObject instance to remove.
		 * @throws ArgumentError Throws if the child parameter is not a child of this object.
		 * @return The DisplayObject instance that you pass in the child parameter.
		 */
		public override function removeChild( child:DisplayObject ):DisplayObject
		{
			var d:DisplayObject = super.removeChild(child) ;
			update() ;
			return d ;
		}
		
		/**
		 * Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer. 
		 * The parent property of the removed child is set to null, and the object is garbage collected if no other references to the child exist. 
		 * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
		 * @param index The child index of the DisplayObject to remove.
		 * @throws RangeError Throws if the index does not exist in the child list.
		 * @throws SecurityError This child display object belongs to a sandbox to which the calling object does not have access. 
		 * You can avoid this situation by having the child movie call the Security.allowDomain() method. 		 
		 * @return The DisplayObject instance that was removed.
		 */
		public override function removeChildAt( index:int):DisplayObject
		{
			var d:DisplayObject = super.removeChildAt( index ) ;
			update() ;
			return d ;
		}
		
		/**
		 * Removes all childs in the model defined for the first item by the specified index value, 
		 * this method remove the first and the {@code size - 1} items.
		 */
		public function removeChildsAt( index:int, size:Number ):Array 
		{
			var removes:Array = [] ;
			for (var i:int = index ; i< ( index + size ) ; i++ )
			{
				var child:DisplayObject = super.removeChildAt(i) ;
				if ( child != null )
				{
					removes.push( child ) ;	
				}
			}
			update() ;
			return ( removes.length > 0 ) ? removes : null ;
		}
		
		/**
		 * Removes a range of childs in the container.
		 * @return the array representation of all removed items.
		 */
		public function removeRange( from:int , to:int ):Array 
		{
			var removes:Array = [] ;
			if ( to <= from )
			{
				if ( containsAt( from ) )
				{
					removes.push( super.removeChildAt( from ) ) ;
				}
				else
				{
					return null ;
				} 
				update() ; 
			}
			else
			{
				removes = removeChildsAt( from , to - from ) ;
			}
			return removes ;
		}
		
		/**
		 * Returns the number of children of this object.
		 * @return the number of children of this object.
		 */
		public function size():uint
		{
			return numChildren ;	
		}
		
		/**
		 * Returns the Array representation of all childs in this container.
		 * @return the Array representation of all childs in this container.
		 */
		public function toArray():Array
		{
			var ar:Array    = [] ;
			var size:uint   = numChildren ;
			for( var i:uint = 0 ; i<size ; i++ )
			{
				ar[i] = getChildAt(i) ; 
			}
			return ar ;
		}
		
	}
}
