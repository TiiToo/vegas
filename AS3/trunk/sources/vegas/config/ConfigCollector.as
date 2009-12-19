/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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

package vegas.config
{
    import system.data.Iterator;
    import system.data.sets.HashSet;
    
    /**
     * The ConfigCollector class is a static collection to register all IConfigurable objects.
     */
    public class ConfigCollector
    {
        /**
         * Returns <code class="prettyprint">true</code> if the collector contains the specified <code class="prettyprint">IConfigurable</code> object.
         * @return <code class="prettyprint">true</code> if the collector contains the specified <code class="prettyprint">IConfigurable</code> object.
         */    
        public static function contains( conf:IConfigurable ):Boolean 
        {
            return _set.contains( conf ) ;
        }
        
        /**
         * Inserts an IConfigurable object in the collector.
         */
        public static function insert( conf:IConfigurable ):Boolean 
        {
            return _set.add( conf ) ;
        }
        
        /**
        * Returns the <code class="prettyprint">Iterator</code> of this collector.
        * @return the <code class="prettyprint">Iterator</code> of this collector.
        */
        public static function iterator() :Iterator
        {
            return _set.iterator() ;
        }
        
        /**
         * Removes the specified <code class="prettyprint">IConfigurable</code> object in the collector.
         */
        public static function remove( conf:IConfigurable ):*
        {
            return _set.remove( conf ) ;
        }
        
        /**
         * Run the <code class="prettyprint">ConfigCollector</code> command to invoked the <code class="prettyprint">setup()</code> method of all <code class="prettyprint">IConfigurable</code> object registered in the collector.
         */
        public static function run():void
        {
            if (size() > 0)
            {
                var ar:Array = _set.toArray() ;
                var l:uint = ar.length ;
                while(--l > -1)
                {
                    if ( ar[l] is IConfigurable)
                    {
                        (ar[l] as IConfigurable).setup() ;
                    }
                }
            }
        }
        
        /**
         * Returns the number of elements in the collector.
         * @return the number of elements in the collector.
         */
        public static function size():Number
        {
            return _set.size() ;
        }
        
        /**
         * The internal Set of this collector.
         */
        private static var _set:HashSet = new HashSet() ;
    }
}