﻿/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.vo
{
    import system.Equatable;
    import system.Reflection;
    import system.Serializable;
    import system.data.Identifiable;
    import system.data.ValueObject;
    
    /**
     * The SimpleValueObject class provides a basic implementation of the ValueObject interface.
     * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
     */
    public class SimpleValueObject implements Equatable, Serializable, ValueObject
    {
        /**
         * Creates a new SimpleValueObject instance.
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
         * Indicates the id of this IValueObject.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
         * @private
         */
        public function set id( id:* ):void
        {
            _id = id ;
        }
        
        /**
         * Compares the specified object with this object for equality. This method compares the ids of the objects with the <code class="prettyprint">Identifiable.getID()</code> method.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
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
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "()" ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " " + this.id ;
            } 
            str += "]" ;
            return str ;
        }    
        
        /**
         * @private
         */
        private var _id:* ;
    }
}