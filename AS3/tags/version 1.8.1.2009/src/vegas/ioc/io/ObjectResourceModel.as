/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package vegas.ioc.io 
{
    import system.Reflection;
    import system.data.maps.HashMap;
    
    import vegas.ioc.ObjectAttribute;
    import vegas.models.CoreModel;
    
    /**
     * This tool class is a helper to create an ObjectResource object with a generic object in the IoC context.
     */
    internal class ObjectResourceModel extends CoreModel
    {
        /**
         * Creates a new ObjectResourceModel instance.
         */
        public function ObjectResourceModel( id:* = null )
        {
            super( id ) ;
            _map = new HashMap() ;
        }
        
        /**
         * Inserts a new ObjectResource class reference with the specified type in the builder.
         */
        public function addObjectResource( type:String , clazz:Class ):Boolean
        {
            if ( Reflection.getClassInfo(clazz).inheritFrom(ObjectResource) )  
            {
                _map.put( type, clazz ) ;
                return true ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Creates the ObjectAttribute object with the specified generic object.
         * @param o The object definition to create an ObjectAttribute instance.
         */
        public function get( o:Object ):ObjectResource
        {
            if ( ObjectAttribute.RESOURCE in o )
            {
                var type:String = o[ ObjectAttribute.TYPE ] as String ;
                if ( _map.containsKey( type ) )
                {
                    var clazz:Class = _map.get( type ) as Class ;
                    if ( clazz != null )
                    {
                        return new clazz( o ) as ObjectResource ;
                    }
                }   
            }
            return null ;
        }
        
        /**
         * Removes the ObjectResource class reference with the specified type in the builder.
         */
        public function removeObjectResource( type:String ):Boolean
        {
            return _map.remove( type ) != null ;
        }
        
        /**
         * @private
         */
        private var _map:HashMap ;
    }
}
