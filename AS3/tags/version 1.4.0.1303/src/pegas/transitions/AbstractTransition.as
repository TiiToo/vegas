﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.transitions 
{
    import pegas.transitions.ITransition;

    import system.data.Identifiable;
    import system.process.CoreAction;

    /**
     * This abstract class defines the skeletal implementation of the ITransition interface.
     */
    public class AbstractTransition extends CoreAction implements ITransition 
    {
        
        /**
         * Creates a new AbstractTransition instance.
         */
        public function AbstractTransition( id:* )
        {
            this.id = id ;
        }
        
        /**
         * Indicates the id value of this object.
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
            if ( o == this )
            {
                return true ;
            }
            else if (o is Identifiable)
            {
                return ( o as Identifiable ).id == this.id ;            
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * @private
         */
        private var _id:* ;
    
    }
}
