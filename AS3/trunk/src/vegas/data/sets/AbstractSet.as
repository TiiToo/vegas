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

/* AbstractSet

	AUTHOR
	
		Name : AbstractSet
		Package : vegas.data.sets
		Version : 1.0.0.0
		Date : 2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY

		- clear():void
		
		- clone():*
		
		- copy():*
				
		- contains(o:*):Boolean
		
		- containsAll(c:Collection):Boolean
		
		- equals(o:*):Boolean
		
		- get(id)
		
		- hashCode():uint
		
		- indexOf(o:*, fromIndex:uint=0):int
		
		- insert(o:*):Boolean
		
		- insertAll(c:Collection):Boolean
		
		- isEmpty():Boolean
		
		- iterator():Iterator
		
		- remove(o):Boolean
		
		- removeAll(c:Collection):Boolean
		
		- retainAll(c:Collection):Boolean
		
		- size():Number
		
		- toArray():Array
		
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → AbstractCollection → SimpleCollection → AbstractSet

	IMPLEMENTS
	
		Collection, ICloneable, ICopyable, IEquality, IFormattable, IHashable, ISerialzable, Iterable, Set

*/

package vegas.data.sets
{

	import vegas.core.IEquality ;
	import vegas.data.Collection ;
	import vegas.data.collections.SimpleCollection;
	import vegas.data.Set ;

	internal class AbstractSet extends SimpleCollection implements IEquality, Set
	{
		
		// ----o Constructor
		
		public function AbstractSet( ar:Array )
		{
			super(ar) ;		
		}
		
		// ----o Public Methods
		
		public function equals(o:*):Boolean 
		{
			
			if (o == this) 
			{
				return true ;
			}
			if ( ! (o is Set) ) 
			{
				return false ;
			}
			var c:Collection = Collection(o) ;
			if (c.size() != size()) 
			{
				return false ;
			}		
			
			return this.containsAll(c) ;
			
		}
		
	}
	
	
	


}
