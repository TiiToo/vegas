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

/** Copier

	AUTHOR
	
		Name : Copier
		Package : vegas.util
		Version : 1.0.0.0
		Date : 2006-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
	METHOD SUMMARY
	
		- static copy(o)
			
			return a deep copy of the object.

	SEE ALSO

		ICopyable

**/

package vegas.util
{

    import vegas.core.ICopyable;
    import vegas.util.ArrayUtil;
    import vegas.util.BooleanUtil;
    import vegas.util.DateUtil;
    import vegas.util.FunctionUtil;
    import vegas.util.NumberUtil ;
    import vegas.util.ObjectUtil;
    import vegas.util.TypeUtil;

    /**
     * @author eKameleon
     * @version 1.0.0.0
     */

	public class Copier
	{

        static public function copy( o:* ):* {
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
    		    return DateUtil.copy( o ) ;
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
    		    return ObjectUtil.copy(o) ;
    		}
    		else 
    		{
        		return null ;
		    }
    	}	

	}    
    
}