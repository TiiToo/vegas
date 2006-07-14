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

/**	ProtectedIterator

	AUTHOR

		Name : ProtectedIterator
		Package : vegas.data.iterator
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var pIterator:Iterator = new ProtectedIterator(it:Iterator) ;

	DESCRIPTION
	
		Protège un objet implémenté avec l'interface Iterator.
		Cette classe permet de bloquer les méthodes remove, reset et seek d'un Iterator.

	METHOD SUMMARY
	
		- hasNext():Boolean
		
		- key():*
		
		- next():*
		 
		- toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → ProtectedIterator

	IMPLEMENTS
	
		IFormattable, IHashable, Iterator, ISerializable

**/

package vegas.data.iterator
{

    import vegas.core.CoreObject;
    import vegas.data.iterator.Iterator ;
    import vegas.errors.UnsupportedOperation ;
    import vegas.util.Serializer ;
    
    public class ProtectedIterator extends CoreObject implements Iterator
    {
        
        // ----o Constructor
        
        public function ProtectedIterator(i:Iterator)
        {
		    _i = i ;
        }
        
        // ----o Public Methods
        
        public function hasNext():Boolean
        {
            return _i.hasNext() ;
        }
        
        public function key():*
        {
            return _i.key() ;
        }
        
        public function next():*
        {
            return _i.next() ;
        }
        
        public function remove():*
        {
            throw new UnsupportedOperation("This Iterator does not support the remove() method.") ;
        }
        
        public function reset():void
        {
            throw new UnsupportedOperation("This Iterator does not support the reset() method.") ;
        }
        
        public function seek(position:*):void
        {
            throw new UnsupportedOperation("This Iterator does not support the seek() method.") ;
        }
        
        override public function toSource(...arguments:Array):String 
        {
            return Serializer.getSourceOf(this, [_i]) ;
        }
        
    	// ----o Private Properties
	
	    private var _i:Iterator ;
	    
    }
}