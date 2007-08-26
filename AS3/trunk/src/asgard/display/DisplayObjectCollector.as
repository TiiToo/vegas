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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * @author eKameleon.
 */
package asgard.display
{
	
	import flash.display.DisplayObject;

	import vegas.data.map.HashMap;
	import vegas.errors.Warning;
	
	public class DisplayObjectCollector
	{
	
		/**
		 * Clear the DisplayObjectCollector.
		 */
		static public function clear():void 
		{
			_map.clear() ;	
		}
	
		/**
		 * Returns 'true' if the DisplayObjectCollector contains the display's name.
		 * @return 'true' if the DisplayObjectCollector contains the display's name.
		 */	
		static public function contains( sName:String ):Boolean 
		{
			return _map.containsKey( sName ) ;	
		}

		/**
		 * Returns the DisplayObject register in the collector with the name passed in argument.
		 * @return the DisplayObject register in the collector with the name passed in argument.
		 */	
		static public function get(sName:String):DisplayObject 
		{
			try 
			{
				if (!contains(sName) ) 
				{
					throw new Warning("[DisplayObjectCollector].get('" + sName + "'). Can't find DisplayObject instance." ) ;
				} ;
			}
			catch (e:Warning) 
			{
				e.toString() ;
			}
		
			return _map.get(sName) as DisplayObject ;	
		}
	
		/**
		 * Insert a DisplayObject with an unique name into the DisplayObjectCollector.
		 */
		static public function insert(sName:String, dObject:DisplayObject):Boolean 
		{
			try 
			{
				if ( contains(sName) ) 
				{
					throw new Warning("[DisplayObjectCollector].insert(). A DisplayObject instance is already registered with '" + sName + "' name." ) ;
				} ;
			}
			catch (e:Warning) 
			{
				e.toString() ;
			}
			return ( _map.put(sName, dObject) as Boolean )   ;	
		}
	
		/**
		 * Returns 'true' if the DisplayObjectCollector is 'empty'.
		 * @return 'true' if the DisplayObjectCollector is 'empty'.
		 */
		static public function isEmpty():Boolean 
		{
			return _map.isEmpty() ;	
		}
	
		/**
		 * Remove a DisplayObject into the DisplayObjectCollector.
		 */
		static public function remove(sName:String):void 	
		{
			_map.remove(sName) ;
		}

		/**
		 * Returns the size of the DisplayObjectCollector.
		 * @return the size of the DisplayObjectCollector.
		 */
		static public function size():uint 	
		{
			return _map.size() ;
		}
	
		/**
		 * Internal hashmap to collect all DisplayObject in the UI.
		 */
		static private var _map:HashMap = new HashMap() ;
		
	}
}