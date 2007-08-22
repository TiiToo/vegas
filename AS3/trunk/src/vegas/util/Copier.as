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

package vegas.util
{

    import vegas.core.ICopyable;
    import vegas.util.ArrayUtil;
    import vegas.util.DateUtil;
    import vegas.util.ObjectUtil;
    
    /**
 	 * The {@code Copier} utility class is an all-static class with a method to returns a copy representation of an object.
 	 * @author eKameleon
 	 * @see ICopyable
 	 */
	public class Copier
	{

		/**
		 * Returns a deep copy of the specified object passed in argument. You can use a {@code ICopyable} instance or a native object.
	 	 * <p><b>Example :</b></p>
		 * {@code
		 * import vegas.data.list.LinkedList ;
		 * import vegas.util.Copier ;
		 * var list:LinkedList = new LinkedList() ;
		 * list.insert("item1") ;
		 * list.insert("item2") ;
		 * var copy:LinkedList = Copier.copy(list) as LinkedList ; // LinkedList is ICopyable !
	 	 * trace( copy.equals(list) ) ; // true
	 	 * }
	 	 * @return a deep copy of the specified object passed in argument.
	 	 */	
        static public function copy( o:* ):* 
        {
		    if (o === undefined) 
		    {
		        return undefined ;
            }
    		if (o === null) 
    		{
    		    return null ;
    		}
    		if (o is ICopyable) 
    		{
    		    return o.copy() ;
    		}
    		else if (o as Array) 
    		{
    		    return ArrayUtil.copy( o ) ;
    		}
    		else if (o as Boolean)
    		{
    		    return Boolean(o) ;
    		}
    		else if (o is Date) 
    		{
    		    return DateUtil.copy( o as Date ) ;
    		}
    		else if ( o is Function ) 
    		{
        		return o ;
    	    }
    		else if (o is Number) 
    		{
    		    return o.valueOf() ;
    		}
    		else if (o is String) 
    		{
    		    return o.valueOf() ;
    		}
    		else if (o is Object) 
    		{
    		    return ObjectUtil.copy( o ) ;
    		}
    		else 
    		{
        		return null ;
		    }
    	}	

	}    
    
}