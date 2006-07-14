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

/**	MapFormat

	AUTHOR

		Name : MapFormat
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- formatToString(o):String
	
	INHERIT

		CoreObject → MapFormat

	IMPLEMENT
	
		IFormat, IFormattable, IHashable, ISerializable
	
*/

package vegas.data.map
{
	
	import vegas.core.IFormat;
	import vegas.core.CoreObject;
	import vegas.data.Map ;
	import vegas.data.iterator.ArrayIterator ;
	import vegas.data.iterator.Iterator ;

	public class MapFormat extends CoreObject implements IFormat
	{
		
		// ----o Constructor
		
		public function MapFormat()
		{
			super();
		}

		// ----o Public Methods
		
		public function formatToString(o:*):String
		{
		    var m:Map = o as Map ;
		    if (m == null) return null ;
    		var r:String = "{";
    		var vIterator:Iterator = new ArrayIterator(m.getValues());
    		var kIterator:Iterator = new ArrayIterator(m.getKeys());
    		while (kIterator.hasNext()) {
    			var k:* = kIterator.next() ;
    			var v:* = vIterator.next() ;
    			r += k + ":" + v ;
    			if (kIterator.hasNext()) r += ",";
    		}
    		r += "}";
    		return r ;
        }
		
	}

}