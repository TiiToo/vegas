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

/* StringIterator

	AUTHOR
	
		Name : StringIterator
		Package : vegas.data.iterator
		Version : 1.0.0.0
		Date :  2006-07-09
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Permet de parcourir les attributs d'un objet à condition que les attributs soient énumérables."
		PS : iterator d'objets (plus lent qu'un for..in classique)

	METHOD SUMMARY
	
		- hashCode():uint
	
		- hasNext():Boolean
		
			renvoi true si il existe encore une propriété dans l'objet
		
		- key():*
		
			récupère le nom de l'attribut en cours aprés un it.next()
		
		- next():*
		
			récupère le prochain attribut dans l'objet
		
		- remove():*
		
			supprime une propriété aprés un it.next()
		
		- reset():void
		
			Réinitialise l'iterator
		
		- seek(position:*):void
		
			Permet de changer l'index de l'iterator (entre 0 et nombre de propriétés dans l'objet)

 		- toSource(...arguments:Array):String 
 		
 		- toString():String

	INHERIT
	
		CoreObject → StringIterator

	IMPLEMENTS
	
		IFormattable, IHashable, Iterator, ISerializable

	EXAMPLE
	
		var it:StringIterator = new StringIterator( "Hello World" ) ;
		trace(it) ;
		while(it.hasNext()) 
		{
		
		    var value:* = it.next() ;
		    var key:* = it.key() ;
		    trace("key : " + key + " / value : " + value) ;
			
		}

*/

package vegas.data.iterator
{
	import vegas.core.CoreObject;
	import vegas.errors.UnsupportedOperation ;
	import vegas.util.MathsUtil ;
	import vegas.util.Serializer ;

	public class StringIterator extends CoreObject implements Iterator
	{
		
		// ----o Constructor
		
		public function StringIterator(s:String)
		{
			_s = s ;
			_k = -1 ;
			_size = s.length ;
		}
		
		// -----o Public MEthods
		
		/**
		 * renvoi true si il existe encore une propriété dans l'objet.
		 */
		public function hasNext():Boolean
		{
			return _k < _size-1  ;
		}

		public function key():*
		{
			return _k ;
		}

		public function next():*
		{
			return _s.charAt( ++_k );
		}
		
		public function remove():*
		{
			throw new UnsupportedOperation("This " + this + " does not support the reset() method.") ;
			return null ;
		}
		
		public function reset():void
		{
			_k = -1 ;
		}

		public function seek(position:*):void
		{
			_k = MathsUtil.clamp ((position-1), -1, _size-1) ;
		}

        override public function toSource(...arguments:Array):String 
        {
            return Serializer.getSourceOf(this, [_s] ) ;
        }

		// ----o Private Properties
		
		private var _s:String ;
		private var _k:Number ;
		private var _size:Number ;
	
	}
}