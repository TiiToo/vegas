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

import andromeda.model.AbstractModel;

import asgard.display.DisplayObject;

import vegas.data.iterator.Iterator;
import vegas.data.map.HashMap;
import vegas.data.set.MultiHashSet;
import vegas.errors.IllegalArgumentError;

/**
 * The TabManager manage visual tab process in the applications.
 * <p><b>Example :</b></p>
 * {@code
 * import asgard.managers.TabManager ;
 * 
 * var manager:TabManager = TabManager.getInstance() ;
 * 
 * // auto focus the group when an interactive object is selected
 * manager.auto = true ; 
 * 
 * // container1 is a movieclip with foor TextField reference inside : field1, field2, field3 and field4
 * 
 * container1.field1.tabIndex = 1 ;
 * container1.field2.tabIndex = 2 ;
 * container1.field3.tabIndex = 3 ;
 * container1.field4.tabIndex = 4 ;
 * 
 * // container2 is a movieclip with foor TextField reference inside : field1, field2, field3 and field4
 * 
 * container2.field1.tabIndex = 2 ;
 * container2.field2.tabIndex = 1 ;
 * container2.field3.tabIndex = 4 ;
 * container2.field4.tabIndex = 3 ;
 * 
 * manager.insert("group1", container1.field1 ) ;
 * manager.insert("group1", container1.field1 ) ;
 * manager.insert("group1", container1.field2 ) ;
 * manager.insert("group1", container1.field3 ) ;
 * manager.insert("group1", container1.field4 ) ;
 * 
 * manager.insert("group2", container2.field1 ) ;
 * manager.insert("group2", container2.field2 ) ;
 * manager.insert("group2", container2.field3 ) ;
 * manager.insert("group2", container2.field4 ) ;
 * 
 * manager.select("group1") ;
 * 
 * Key.addListener( this ) ;
 * 
 * var onKeyDown:Function = function():Void
 * {
 *     var code:Number = Key.getCode() ;
 *     switch( code )
 *     {
 *         case Key.UP :
 *         {
 *             manager.select("group1") ;
 *             break ;
 *         }
 *         case Key.DOWN :
 *         {
 *         	   manager.select("group1", container1.field2) ;
 *             break ;
 *         }
 *         case Key.LEFT :
 *         {
 *              manager.select("group2") ;
 *              break ;
 *         }
 *         case Key.RIGHT :
 *         {
 *             manager.select("group2", container2.field3) ;
 *             break ;
 *         }
 *     }
 * }
 * 
 * trace("press UP, DOWN, LEFT, RIGHT keys to test the tab manager.") ;
 * }
 * @author eKameleon
 */
class asgard.managers.TabManager extends AbstractModel 
{
	
	/**
	 * Creates a new TabManager instance.
	 * @param id the id of the model.
	 * @param bGlobal the flag to use a global event flow or a local event flow.
	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
	 */
	function TabManager( id, bGlobal:Boolean, sChannel:String ) 
	{
		super( id, bGlobal, sChannel);
		_map = new HashMap() ;
		_set = new MultiHashSet() ;
	}
	
	/**
	 * Indicates if the tab manager use a auto group focus over the interactive objects when there are focused.
	 */
	public function get auto():Boolean
	{
		return _auto ;
	}
	
	/**
	 * @private
	 */
	public function set auto(b:Boolean):Void
	{
		_auto = b ;
		if ( _auto )
		{
			Selection.addListener(this) ;	
		}
		else
		{
			Selection.removeListener(this) ;	
		}
	}

	/**
	 * Removes all elements in this manager.
	 */
	public function clear():Void 
	{
		unSelect() ;
		_map.clear() ;
		_set.clear() ;
	}

	/**
	 * Checks whether the map contains the specified group id.
	 */
	public function contains( id ):Boolean
	{
		return _set.containsKey(id) ;	
	}
	
	/**
	 * Returns the current group id selected in the manager.
	 * @return the current group id selected in the manager.
	 */
	public function getCurrent()
	{
		return _current ;
	}	

	/**
	 * Returns the singleton reference of the TabManager class.
	 * @return the singleton reference of the TabManager class.
	 */
	public static function getInstance():TabManager 
	{
		if (_instance == null)
		{
			_instance = new TabManager();
		}
		return _instance;
	}

	/**
	 * Insert a new child object in the manager with the specified id.
	 * @param id The key of the group to collect the specified interactive object.
	 * @param child The interactive object to collect in the manager.
	 * @return {@code true} if the interactive object is inserted in the manager.
	 * @throws IllegalArgumentError the id argument not must be 'null' or 'undefined'.
	 */
	public function insert( id , child ):Boolean
	{
		if ( id == null )
		{
			throw new IllegalArgumentError( this + " insert failed, the id argument not must be 'null' or 'undefined'.") ;
		}
		if ( child instanceof MovieClip || child instanceof TextField || child instanceof DisplayObject || child instanceof Button )
		{
			var b:Boolean = _set.put( id , child ) ;
			if ( b )
			{
				child.tabEnabled = false ;
				_map.put( child , id ) ;
			}
			return b ;
		}
		else
		{
			return false ;	
		}	
	} 

	/**
	 * Removes a child object in the manager with the specified id.
	 * @param id The key of the group to collect the specified interactive object.
	 * @param child The interactive object to collect in the manager.
	 * @return {@code true} if the interactive object is removed in the manager.
	 * @throws IllegalArgumentError the id argument not must be 'null' or 'undefined'.
	 */
	public function remove( id , child ):Boolean
	{
		if ( id == null )
		{
			throw new IllegalArgumentError( this + " insert failed, the id argument not must be 'null' or 'undefined'.") ;
		}
		if ( child instanceof MovieClip || child instanceof TextField || child instanceof DisplayObject || child instanceof Button )
		{
			var b:Boolean = _set.remove( id , child ) ; 
			if ( b )
			{
				child.tabEnabled = false ;
				_map.remove( child ) ;
			}
			return b ;
		}
		else
		{
			return false ;	
		}	
	} 

	/**
	 * Select the specified group and returns {@code true} if the group exist.
	 * @param id The key of the tab group of interactive objects.
	 * @param defaultChild (optional) The default interactive object to select by default when the group is selected.
	 * @return {@code true} if the specified group of interactive objects is selected.
	 * @throws IllegalArgumentError the id argument not must be 'null' or 'undefined'.
	 */
	public function select( id , defaultChild ):Boolean
	{
		if ( id == null )
		{
			throw new IllegalArgumentError( this + " insert failed, the id argument not must be 'null' or 'undefined'.") ;
		}
		if ( contains( id ) )
		{
			unSelect() ;
			_current = id ;
			var it:Iterator = _set.iterator( _current ) ;
			var first ;
			var isFirst:Boolean = true ;
			while (it.hasNext()) 
			{
				var next = it.next() ;
				if ( isFirst )
				{
					first = (next instanceof DisplayObject) ? next.view : next ;
					isFirst = false ;	
				}
				next.tabEnabled = true ;	
			}
			Selection.setFocus( (defaultChild != null && _set.contains( id, defaultChild)) ? defaultChild : first ) ;
			return true ;
		}
		else
		{
			return false ;	
		}	
	}

	/**
	 * Unselect the specified group and returns {@code true} if the group exist.
	 * @return {@code true} if the unselected group exist and the process is success.
	 */
	public function unSelect():Boolean
	{
		if ( _current != null )
		{
			var it:Iterator = _set.iterator( _current ) ;
			while (it.hasNext()) 
			{
				it.next().tabEnabled = false ;	
			}
			_current = null ;
			return true ;
		}
		else
		{
			return false ;	
		}
	}
	
	/**
	 * @private
	 */
	private var _auto:Boolean = false ;
	
	/**
	 * The current group selected in the manager.
	 */
	private var _current = null ;

	/**
	 * @private
	 */
	private static var _instance:TabManager ;

	/**
	 * @private
	 */
	private var _map:HashMap ;
	
	/**
	 * @private
	 */
	private var _set:MultiHashSet ;

	/**
	 * Invoked when the focus of the stage is changed.
	 */
	private function onSetFocus( oldFocus, newFocus ):Void
	{
		if ( _map.containsKey( newFocus ) )
		{
			var id = _map.get( newFocus ) ;
			if ( id != getCurrent() )
			{
				select( id , newFocus ) ;	
			}
		}
		
	}

}