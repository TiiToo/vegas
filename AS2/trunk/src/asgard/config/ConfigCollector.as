/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.config.IConfigurable;

import vegas.data.iterator.Iterator;
import vegas.data.list.ArrayList;

// TODO utiliser un Set et pas une ArrayList !!

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/

class asgard.config.ConfigCollector 
{
	
	/**
	 * constructor
	 */
    private function ConfigCollector() 
    {
		//
    }

	/**
	 * Public Methods
	 */
	
	static public function contains( conf:IConfigurable ) :Boolean 
	{
		return _list.contains( conf ) ;	
	}
	
	static public function insert( conf:IConfigurable ) :Boolean 
	{
		return _list.insert( conf ) ;
	}
	
	static public function iterator() :Iterator
	{
		return _list.iterator() ;	
	}
	
	static public function remove( conf:IConfigurable ) :Void 
	{
		_list.remove( conf ) ;
	}
	
	static public function run():Void
	{
		if (size() > 0)
		{
			var it:Iterator = iterator() ;
			while(it.hasNext())
			{
				(it.next()).setup() ;	
			}
		}	
	}
	
	static public function size():Number
	{
		return _list.size() ;
	}
	
	/**
	 * Private Methods
	 */
	
	static private var _list:ArrayList = new ArrayList() ;
	
}