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

/**	MultiMapFormat

	AUTHOR

		Name : MultiMapFormat
		Package : vegas.data.map
		Version : 1.0.0.0
		Date :  2006-07-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- formatToString(o):String
	
	INHERIT

		CoreObject → MultiMapFormat

	IMPLEMENT
	
		IFormat, IFormattable, IHashable, ISerializable
	
*/

package vegas.data.map
{
	import vegas.core.IFormat;
	import vegas.core.CoreObject;
	import vegas.data.iterator.Iterator ;
	import vegas.data.Map ;
	import vegas.data.MultiMap;
	

	public class MultiMapFormat extends CoreObject implements IFormat
	{
		
		// ----o Constructor
		
		public function MultiMapFormat()
		{
			super();
		}
		
		// ----o Public Methods
		
		public function formatToString(o:*):String
		{
		    var m:MultiMap = (o as MultiMap) ;
		    if (m == null) 
		    {
		       return null ;
		   	}
    		var r:String = "{";
    		var vIterator:Iterator = m.valueIterator() ;
    		var kIterator:Iterator = m.keyIterator() ;
    		while (kIterator.hasNext()) {
    			r += kIterator.next().toString() + ":" + vIterator.next().toString();
    			if (kIterator.hasNext()) r += ",";
    		}
    		r += "}";
    		return r ;
		}
		
	}
}