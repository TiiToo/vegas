﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.data.maps 
{
    import system.Cloneable;
    import system.Reflection;
    import system.data.Entry;

    /**
     * Represents a pair key/value entry in a Map.
     */
    public class MapEntry implements Cloneable, Entry
    {
        /**
         * Creates a new MapEntry instance.
         * @param key The key representation of the entry.
         * @param value The value representation of the entry.
         */
        public function MapEntry( key:* = null , value:* = null )
        {
            _key   = key   ;
            _value = value ;
        }
        
         /**
         * Indicates the key corresponding to this entry.
         */        
        public function get key():*
        {
            return _key ;
        }
        
        /**
         * @private
         */        
        public function set key( key:* ):void
        {
            _key = key ;
        }        
        
        /**
         * Indicates the value corresponding to this entry.
         */        
        public function get value():*
        {
            return _value ;
        }
        
        /**
         * @private
         */        
        public function set value( value:* ):void
        {
            _value = value ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */    
        public function clone():*
        {
            return new MapEntry(key,value);
        }        
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return "[" + Reflection.getClassName(this) + " key:" + key + " value:" + value + "]" ;
        }
        
        /**
         * @private
         */
        private var _key:* ;
        
        /**
         * @private
         */
        private var _value:* ;
    }
}
