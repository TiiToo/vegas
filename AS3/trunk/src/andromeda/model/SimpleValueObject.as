/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package andromeda.model
{
    import vegas.core.CoreObject;
    import vegas.core.IEquality;
    import vegas.core.Identifiable;
    import vegas.util.ClassUtil;

    /**
	 * Creates a new SimpleValueObject instance.
	 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
	 */
	public class SimpleValueObject extends CoreObject implements IEquality, IValueObject
	{
		
		/**
		 * Creates a new SimpleValueObject.
		 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
		 */
		public function SimpleValueObject( init:Object=null )
		{
			if ( init != null )
			{
				for (var prop:String in init )
				{
					this[prop] = init[prop] ;	
				} 	
			}
		}
		
		/**
		 * (read-write) Returns the id of this IValueObject.
		 * @return the id of this IValueObject.
		 */
		public function get id():*
		{
			return _id ;
		}
	
		/**
		 * (read-write) Sets the id of this IValueObject.
		 * @return the id of this IValueObject.
		 */
		public function set id( id:* ):void
		{
			_id = id ;
		}
		
		/**
		 * Compares the specified object with this object for equality. This method compares the ids of the objects with the {@code Identifiable.getID()} method.
		 * @return {@code true} if the the specified object is equal with this object.
		 */
		public function equals( o:* ):Boolean
		{
			if (o is Identifiable)
			{
				return ( o as Identifiable ).id == this.id ;			
			}
			else
			{
				return false ;
			}
		}
			
		/**
	 	 * Returns the {@code String} representation of this object.
	 	 * @return the {@code String} representation of this object.
	 	 */
		public function toString():String
		{
			var str:String = "[" + ClassUtil.getName(this) ;
			if ( this.id != null )
			{
				str += " " + this.id ;	
			} 
			str += "]" ;
			return str ;
		}	
		
		/**
		 * The internal id of this IValueObject
		 */
		private var _id:* ;
		
	}
}