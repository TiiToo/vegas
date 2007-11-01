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

import asgard.display.DisplayObject;

import lunas.core.IContainer;
import lunas.display.abstract.AbstractComponentDisplay;
import lunas.model.ContainerModel;

import vegas.core.HashCode;
import vegas.core.IHashable;
import vegas.data.iterator.Iterable;
import vegas.data.iterator.Iterator;
import vegas.util.factory.DisplayFactory;

/**
 * The Skeletal implementation of the IContainer interface.
 * @author eKameleon
 */
class lunas.display.abstract.AbstractContainerDisplay extends AbstractComponentDisplay implements IContainer, Iterable 
{

	/**
	 * Creates a new AbstractContainerDisplay instance.
	 * @param sName:String the name of the display.
	 * @param target:MovieClip the DisplayObject instance control this target.
	 * @param id (optional) the id of the model.
	 * @param bGlobal (optional) the flag to use a global event flow or a local event flow.
	 * @param sChannel (optional) the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 * @param childs (optional) An Array of items to insert in the model.
	 */
	private function AbstractContainerDisplay( sName:String, target:MovieClip , id , bGlobal:Boolean , sChannel:String , childs:Array ) 
	{ 
		super ( sName, target ) ;
		initContainer() ;
		setModel( id, bGlobal, sChannel, childs ) ;
	}
	
	/**
	 * The default container depth.
	 */
	public static var DEFAULT_CONTAINER_DEPTH:Number = 100 ;
	
	/**
	 * The default container name.
	 */
	public static var DEFAULT_CONTAINER_NAME:String  = "container" ;
	
	/**
	 * The container reference of this display.
	 */
	public var container:MovieClip ;

	/**
	 * Adds a visual child in the display.
	 * @param o The object use to defines the new child to creates (this object can be a String, a Visual class (MovieClip, TextField) or a null value to creates an empty movieclip.
	 * @param oInit The optional object use to initialize the new child.
	 * @param noRender The boolean flag who disabled the auto update of this container.
	 * @param callFunction The method invoqued after the child is created. 
	 * @param args An optional array of arguments to passed-in the mapFunction.
	 * @param scope The optional scope of the mapFunction.
	 * @param ...arguments All tne next arguments represents the passed-in arguments in the mapFunction.
	 * @return The new child inserted in the container of the returned value of the mapFunction if this value is not null. 
	 */
	public function addChild( o , oInit ) 
	{
		return addChildAt.apply( this, [o, size(), oInit].concat(  arguments.slice(2) ) ) ;
	}
	
	/**
	 * Adds childs in the container at the specified index.
	 * @param o The object use to defines the new child to creates (this object can be a String, a Visual class (MovieClip, TextField) or a null value to creates an empty movieclip.
	 * @param index The numeric position to create the child in the container model.
	 * @param oInit The optional object use to initialize the new child.
	 * @param noRender The boolean flag who disabled the auto update of this container.
	 * @param mapFunction The optional method invoqued after the child is created to maped this new child. This method receive in argument the new child and must return the final mapped child to be register in the container.
	 * @param scope The optional scope of the mapFunction.
	 * @param ...arguments All tne next arguments represents the passed-in arguments in the mapFunction.
	 * @return The new child inserted in the container of the returned value of the mapFunction if this value is not null. 
	 */
	public function addChildAt(o, index:Number, oInit ) 
	{
		
		var name:String = "child_" + _countChild++ ;
		var depth:Number = container.getNextHighestDepth() ;
		
		var child = DisplayFactory.createChild( o , name , depth , container, oInit ) ;

		if ( ! child instanceof IHashable )
		{
			HashCode.identify(child) ;
		}
		
		// map the new child with an external method
		if( arguments[4] instanceof Function )
		{
			child = arguments[4].apply( arguments[5] , [child].concat( arguments.slice(6) ) ) ;
		}
		
		_model.addChildAt( child , index ) ;
		
		if (arguments[3] == null)
		{
			update() ;
		}
		
		refreshDepths() ;
		
		notifyAdded(child, index) ;
		
		return child ;
		
	}
	
	/**
	 * Clear all items in the container.
	 */
	public function clear():Void 
	{
		removeChilds( toArray() ) ;
		_model.clear() ;
		update() ;
	}
	
	/**
	 * Returns {@code true} if the model contains the specified child reference.
	 * @return {@code true} if the model contains the specified child reference.
	 */
	public  function contains( oChild ):Boolean 
	{
		return _model.contains(oChild) ;
	}
	
	/**
	 * Returns the child reference in the container with the specified index value.
	 * @return the child reference in the container with the specified index value.
	 */
	public function getChildAt(index:Number) 
	{
		return _model.getChildAt(index) ;
	}
	
	/**
	 * Returns the child reference in the container specified by the passed-in key number.
	 * @return the child reference in the container specified by the passed-in key number.
	 */
	public function getChildByKey( key:Number ) 
	{
		return _model.getChildByKey(key) ;
	}
	
	/**
	 * Returns the child reference in the container specified by the passed-in key name.
	 * @return the child reference in the container specified by the passed-in key name.
	 */
	public function getChildByName(name:String) 
	{
		return _model.getChildByName(name) ;
	}
	
	/**
	 * Returns the internal model reference of this container.
	 * @return the internal model reference of this container.
	 */
	public function getModel():ContainerModel
	{
		return _model ;	
	}
	
	/**
	 * Initialize the container of this display.
	 */
	public function initContainer():Void
	{
		container = view.createEmptyMovieClip( DEFAULT_CONTAINER_NAME , DEFAULT_CONTAINER_DEPTH ) ;
	}
	
	/**
	 * Returns the {@code Iterator} of this container.
	 * @return the {@code Iterator} of this container.
	 */
	public function iterator():Iterator 
	{
		return _model.iterator() ;
	}
	
	/**
	 * Returns the index number value of the specified child reference in argument.
	 * @return the index number value of the specified child reference in argument.
	 */
	public function indexOf( oChild ):Number 
	{
		return _model.indexOf(oChild) ;
	}
	
	/**
	 * Refreshs the depths of all childs in the container.
	 */
	public function refreshDepths():Void
	{
		var ar:Array = _model.toArray() ;
		var l:Number = ar.length ;
		while(l--)
		{
			MovieClip.prototype.swapDephts.call(ar[l], l) ;	
		}
	}
	
	/**
	 * Removes the specified child in argument.
	 * @return the removed child.
	 */
	public function removeChild( oChild ):Void 
	{
		var removed = _model.removeChild(oChild) ;
		removeChilds( [removed] ) ;
		refreshDepths() ;
		update() ; 
	}

	/**
	 * Removes the specified child defines with the index value in argument.
	 * @return the removed child.
	 */	
	public function removeChildAt(index:Number):Void 
	{
		if ( getChildAt(index) ) 
		{
			removeChildsAt(index, 1) ;
		}
	}

	/**
	 * Removes all childs in the model defined for the first item by the specified index value, 
	 * this method remove the first child and all to the {@code size - 1} items.
	 */
	public function removeChildsAt(index:Number, len:Number):Void 
	{
		var removes:Array = _model.removeChildsAt(index, len) ;
		removeChilds(removes) ;
		refreshDepths() ;
		update() ; 
		notifyRemoved() ;
	}
	
	/**
	 * Removes the childs defined by the passed-in array in the container display.
	 * @param items The array of all childs to removes.
	 */
	/*protected*/ public function removeChilds(items:Array):Void 
	{
		var l:Number = items.length ;
		while(--l > -1) 
		{
			var child = items[l] ;
			if ( child instanceof DisplayObject)
			{
				child.view.removeMovieClip() ;
				child.release() ;
			}
			else if (child instanceof MovieClip) 
			{
				child.removeMovieClip() ;
			}
			else if (child instanceof TextField)	
			{
				child.removeTextField() ;
			}
		}
	}

	/**
	 * Removes a range of childs in the model.
	 * @return the array representation of all removed items.
	 */
	public function removeRange(from:Number, to:Number):Void 
	{
		var removes:Array = _model.removeRange(from, to) ;
		removeChilds(removes) ;
		refreshDepths() ;
		update() ; 
		notifyRemoved() ;
	}
	
	/**
	 * Sets the specified child index (move the child in the model).
	 */
	public function setChildIndex( oChild, index:Number):Void 
	{
		_model.setChildIndex(oChild, index) ;
		refreshDepths() ;
		update() ; 
	}

	/**
	 * Sets the model of the IContainer reference.
	 * @param id the id of the model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 * @param childs An Array of items to insert in the model.
	 */
	public function setModel( id , bGlobal:Boolean , sChannel:String , childs:Array ):Void
	{
		if ( size() > 0 )
		{
			clear() ;	
		}
		_model = new ContainerModel( id , bGlobal, sChannel, childs ) ;	
	}

	/**
	 * Returns the number of childs in the container.
	 * @return the number of childs in the container.
	 */
	public function size():Number 
	{
		return _model.size() ;
	}
	
	/**
	 * Returns the Array representation of all childs in this container.
	 * @return the Array representation of all childs in this container.
	 */
	public function toArray():Array
	{
		return _model.toArray() ;	
	}
	
	/**
	 * The model of this display.
	 */	
	private var _model:ContainerModel ;
	
	private static var _countChild:Number = 0 ;
}