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

/**	ArrayFieldIterator

	AUTHOR

		Name : ArrayFieldIterator
		Package : vegas.data.iterator
		Version : 1.0.0.0
		Date :  2006-07-08
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var it:ArrayFieldIterator = new ArrayFieldIterator(ar:Array, fieldName:String) ;

	METHOD SUMMARY
	
		- hasNext():Boolean
		
		- key()
		
		- next()
		
		- reset():Void
		
		- remove()
		
		- seek(n:Number)
		
		- toSource(...arguments:Array):String

		- toString():String

	INHERIT
	
		CoreObject → ArrayIterator → ArrayFieldIterator

	IMPLEMENTS
	
		Iterator, IFormattable, IHashable, ISerializable

**/

package vegas.data.iterator
{
   
    import vegas.util.Serializer ;
    
    public class ArrayFieldIterator extends ArrayIterator
    {
    
        // ----o Constructor
        
        public function ArrayFieldIterator(a:Array, fieldName:String=null)
        {
		    super(a) ;
    		this.fieldName = fieldName ;
        }
        
        // ----o Public Properties
	
    	public var fieldName:String ;
    	
	    // ----o Public Methods	

    	override public function next():* {
	    	var o:* = _a[++_k] ;
    		return (fieldName != null) ? o[fieldName] : o ;
    	}

        override public function toSource(...arguments:Array):String 
        {
            var sourceA:String = Serializer.toSource(_a) ;
            var sourceB:String = Serializer.toSource(fieldName) ;
            return "new vegas.data.iterator.ArrayFieldIterator(" + sourceA + "," + sourceB + ")" ;
        }

    }
}