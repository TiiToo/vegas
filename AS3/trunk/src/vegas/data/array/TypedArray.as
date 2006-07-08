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

/** TypedArray

	AUTHOR

		Name : TypedArray
		Package : vegas.data.array
		Version : 1.0.0.0
		Date :  2006-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		var ta:TypedArray = new TypedArray( type:*, ar:Array ) 

	METHOD SUMMARY
	
	    - clone():*
	    
	    - copy():*
	
		- concat() : return a TypedArray
		
		- getType()
		
		- hashCode():Number
		
		- iterator()
		
		- push(value)
		
		- setType(type:Function) : set the type and clear TypedArray
		
		- supports(value)
		
		- toSource(...arguments:Array):String
		
		- toString():String
		
		- unshift(value):Number
		
		- validate(value):Void
	
	INHERIT 
	
		Object → Array → ProxyArray → TypedArray

	IMPLEMENTS 

    	ICloneable, ICopyable, IFormattable, IHashable, Iterable, ISerializable, ITypeable, IValidator

	EXAMPLE
	
		import vegas.data.array.TypedArray ;
		
		var ta:TypedArray = new TypedArray(String, ["item1", "item2", "item3"]) ;
		trace ("ta : " + ta) ;
		ta.push(2) ;
		
		// Output
		// ta : item1,item2,item3
		// [TypeMismatchError] TypedArray.validate('value':2) is mismatch
	
**/

package vegas.data.array
{

    import vegas.core.CoreObject ;
    import vegas.core.HashCode ;
    import vegas.core.ICloneable;
    import vegas.core.IFormattable;
    import vegas.core.IHashable ;
    import vegas.core.ISerializable;    
    import vegas.core.ITypeable;
    import vegas.core.IValidator;
   
    import vegas.data.iterator.ArrayIterator ;
    import vegas.data.iterator.Iterable;    
    import vegas.data.iterator.Iterator;    
   
    import vegas.errors.IllegalArgumentError ;
    import vegas.errors.TypeMismatchError ;

    import vegas.util.ClassUtil ;    
    import vegas.util.Serializer ;

    public class TypedArray extends ProxyArray implements ITypeable, IValidator
    {
        
        // ----o Constructor
        
        public function TypedArray( ...arguments:Array )
        {
            
            super() ;
            
            var type:* = arguments[0] ;
            var ar:Array = arguments[1] || null ;
		    
		    try {
		        
		        if (type == null) 
		        {
		            throw new IllegalArgumentError("TypedArray constructor, argument 'type' must not be 'null' nor 'undefined'.") ;
		        }
		        
		    }
		    catch(e:IllegalArgumentError)
		    {
    		    trace(e.toString()) ;
    		}

    		_type = type ;
    		
    		if (ar == null) return ;
    		var l:uint = ar.length ;
    		if (l > 0) 
    		{
	    		for (var i:Number = 0 ; i<l ; i++) 
	    		{
    				var value:* = ar[i] ;
    				if (supports(value)) _ar[i] = value ;
		    	}
    		}
        }
        
        // ----o Public Methods
        
        override public function clone():*
        {
            return new TypedArray(_type, _ar.slice()) ;
        }

        override public function copy():*
        {
            return new TypedArray(_type, _ar.slice()) ;
        }

        public function concat( ...arguments:Array ):TypedArray 
        {
		    var r:TypedArray = new TypedArray(_type) ;
    		var i:uint = _ar.length ;
    		while(--i>-1) 
    		{
    		    r[i] = _ar[i];
    		}
    		var l2:uint ;
    		var k:int ;
    		var l1:uint = arguments.length ;
    		var j:int = -1 ;
    		while(++j < l1) 
    		{
    			
    			var cur:* = arguments[j] ;
    			
    			if (cur as Array) 
    			{
    				l2 = cur.length ;
    				k = -1 ;
    				while (++k < l2) 
    				{
    				    _ar.push( cur[k] );
    				}
    			} 
    			else 
    			{
    				_ar.push(cur);
    			}
    		}
    		return r ;
        }
        
        public function getType():*
        {
            return _type;
        }

    	public function push( ...arguments:Array ):uint 
    	{
		    if (arguments.length > 1) 
		    {
			    var l:uint = arguments.length;
    			var i:uint = 0 ;
    			while (++i < l)
    			{
    			    validate(arguments[i]) ;
    			}
    		}
    		else
    		{
			    validate(arguments[0]) ;
    		}
		    return Number(_ar.push.apply(_ar, arguments)) ;
    	}


        public function setType(type:*):void
        {
		    _type = type ;
    		_ar.length = 0 ;
        }

    	public function supports(value:*):Boolean 
    	{
		    return value is _type ;
	    }

        public function unshift( ...arguments:Array ):uint
        {
            if (arguments.length > 1) {
			    
			    var l:uint = arguments.length ;
    			var i:int = -1 ;
    			while (++i < l ) 
    			{
        			validate(arguments[i]);
                }
    			
		    }
		    else 
		    {
			 
			    validate(arguments[0]) ;
			    
    		}
    		
		    return Number(_ar.unshift.apply(_ar, arguments)) ;
		    
    	}
  
        public function validate(value:*):void
        {
  		    if (!supports(value)) 
   		    {
   			    throw new TypeMismatchError("TypedArray.validate('value':" + value + ") is mismatch") ;
   		    }
        }
        
        // ----o Protected Methods
        
        override protected function getSourceParams():String
        {
            
            var sourceA:String = ClassUtil.getName(_type) ;
            var sourceB:String = Serializer.toSource(_ar) ;
            return sourceA + "," + sourceB ;
            
        }
	
	    // -----o Private Properties
		    
	    private var _type:* ;
	    
    }
}