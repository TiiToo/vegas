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

/**	BagFormat

	AUTHOR

		Name : BagFormat
		Package : vegas.data.queue
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- formatToString(o):String
	
	INHERIT

		CoreObject → BagFormat

	IMPLEMENT
	
		IFormat, IFormattable, IHashable, ISerializable
	
**/

package vegas.data.bag
{

	import vegas.core.CoreObject;
	import vegas.core.IFormat;

	import vegas.data.Bag;
	import vegas.data.iterator.Iterator;

	public class BagFormat extends CoreObject implements IFormat
	{
		
		// ----o Constructor
		
		public function BagFormat()
		{
			super();
		}
		
		// ----o Public Methods
		
		public function formatToString(o:*):String
		{
			if ( ! o is Bag) return null ;
			var s:String = "{" ;
			var it:Iterator = o.uniqueSet().iterator() ;
			var cur:* ;
			var count:uint ;
			while (it.hasNext()) 
			{
				cur = it.next() ;
				count = o.getCount(cur) ;
				s += count + ":" + cur ;
				if (it.hasNext())
				{
					s += "," ;
				}
			}
			s += "}" ;
			return s ;
		}
		
	}
}