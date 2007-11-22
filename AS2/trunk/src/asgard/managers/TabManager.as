
import andromeda.model.AbstractModel;

import asgard.display.DisplayObject;

import vegas.data.iterator.Iterator;
import vegas.data.set.MultiHashSet;

/**
 * The TabManager manage visual tab process in the applications.
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
		_set = new MultiHashSet() ;
	}

	/**
	 * Removes all elements in this manager.
	 */
	public function clear():Void 
	{
		unSelect() ;
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
	 */
	public function insert( id:String , child ):Boolean
	{
		if ( child instanceof MovieClip || child instanceof TextField || child instanceof DisplayObject || child instanceof Button )
		{
			var b:Boolean = _set.put( id , child ) ;
			if ( b )
			{
				child.tabEnabled = false ;
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
	 */
	public function remove( id:String , child ):Boolean
	{
		if ( child instanceof MovieClip || child instanceof TextField || child instanceof DisplayObject || child instanceof Button )
		{
			var b:Boolean = _set.remove( id , child ) ; 
			if ( b )
			{
				child.tabEnabled = false ;
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
	 */
	public function select( id ):Boolean
	{
		if ( contains( id ) )
		{
			unSelect() ;
			_current = id ;
			var it:Iterator     = _set.iterator( _current ) ;
			var isFirst:Boolean = true ;
			while (it.hasNext()) 
			{
				var next = it.next() ;
				if ( isFirst )
				{
					Selection.setFocus( (next instanceof DisplayObject) ? next.view : next ) ;
					isFirst = false ;	
				}
				next.tabEnabled = true ;	
			}
			return _set.containsKey(id) ;
		}
		else
		{
			return false ;	
		}	
	}

	/**
	 * Select the specified group and returns {@code true} if the group exist.
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
	private var _set:MultiHashSet ;

}