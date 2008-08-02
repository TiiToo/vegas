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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package vegas.core
{
    import flash.utils.getDefinitionByName;
    
    import system.Reflection;
    import system.formatters.Formattable;
    
    import vegas.core.CoreObject;
    import vegas.core.ICloneable;
    import vegas.core.ICopyable;
    import vegas.util.Serializer;    

    /**
	 * Basic class to creates classes who implemented Formattable interface.
	 * @author eKameleon
	 */
	public class Formatter extends CoreObject implements ICloneable, ICopyable, Formattable
	{
		
		/**
		 * Abstract constructor to creates a new class who extends AbstractFormatter.
		 */
		public function Formatter( pattern:String=null )
		{
			_pattern = pattern ;
		}

		/**
		 * Returns the internal pattern of this formatter.
		 * @return the string representation of the pattern of this formatter.
		 */
		public function get pattern():String 
		{
			return _pattern ;
		}

		/**
		 * Sets the internal pattern of this formatter.
		 */
		public function set pattern( expression:String ):void 
		{
			this._pattern = expression ;
		}

		/**
		 * Creates and returns a shallow copy of the object.
		 * @return A new object that is a shallow copy of this instance.
		 */	
		public function clone():*
		{
			var clazz:Class = getDefinitionByName( Reflection.getClassPath(this) ) as Class;
			return new clazz( pattern )  ;
		}

		/**
		 * Interface implemented by classes that can produce "deep" copies of their objects.
		 * @author eKameleon
		 * @version 1.0.0.0
		 */
		public function copy():*
		{
			var clazz:Class = getDefinitionByName(Reflection.getClassPath(this)) as Class ;
			return new clazz( pattern.valueOf() ) ;
		}

        /**
         * Formats the specified value.
         * @return the string representation of the formatted value. 
         */
        public function format( value:* = null ):String
		{
			return null ; // override this method
		}

		/**
		 * Returns a Eden representation of the object.
		 * @return a string representing the source code of the object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			return Serializer.getSourceOf(this, [ pattern ] ) ;
		}
		
		/**
		 * The internal pattern of this formatter.
		 */
		private var _pattern:String ; // pattern
		
	}
}