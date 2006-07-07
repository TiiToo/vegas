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

/**	AbstractTypeable

	AUTHOR

		Name : AbstractTypeable
		Package : vegas.util
		Version : 1.0.0.0
		Date :  2006-07-06
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		private

	METHOD SUMMARY
	
		- getType()
				
			return the type.
			
		- setType(type:Function)
			
			the type to set.
		
		- supports(value):Boolean
		
		- validate(value)
	
	INHERIT
	
		CoreObject → AbstractTypeable
	
	IMPLEMENTS 

		IFormattable, ISerializable, IHashable, Typeable, Validator

**/

package vegas.util
{
    
    import vegas.core.CoreObject;
    import vegas.core.ITypeable;
    import vegas.core.IValidator;
    import vegas.errors.IllegalArgumentError;
    import vegas.errors.TypeMismatchError;
    import vegas.util.ClassUtil;
    import vegas.util.TypeUtil;

    internal class AbstractTypeable extends CoreObject implements ITypeable, IValidator
    {
        
        // ----o Constructor
        
        public function AbstractTypeable(type:*)
            {
            super();
       		
       		if (type == null) 
                {
    			throw new IllegalArgumentError("Argument 'type' must not be 'null' or 'undefined'.") ;
	    	    }
		    _type = type ;
            
            }
        
        // ----o Public Methods
        
        public function getType():*
            {
    		return _type ;
            }
        
        public function setType(type:*):Void
            {
    	    _type = type ;
            }
        
        public function supports(value:*):Boolean
            {
            return value is _type ;
            }
        
        public function validate(value:*):Void
            {
		    var name:String = ClassUtil.getName(this) ;
    		if (!supports(value)) 
                {
    		    throw new TypeMismatchError( name + ".validate('value' : " + value + ") is mismatch.") ;
    		    }
            }
        
        // -----o Private Properties
	
    	private var _type:* ;
        
    }
}