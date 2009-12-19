﻿/*

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

package examples 
{
    import system.data.Iterator;
    
    import vegas.ioc.TypeAliases;
    
    import flash.display.Sprite;
    
    public class TypeAliasesExample extends Sprite 
    {
        public function TypeAliasesExample()
        {
            var aliases:TypeAliases = new TypeAliases() ;
            
            aliases.put( "ArrayMap"         , "system.data.maps.ArrayMap" ) ;
            aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
            
            aliases.put( "ObjectFactory"    , "vegas.factory.ObjectFactory" ) ;
            aliases.put( "system.HashMap"   , "system.data.maps.HashMap" ) ; // can use custom alias
            
            trace("-------- aliases.containsAlias('DropShadowFilter')") ;
            
            trace( aliases.containsAlias('DropShadowFilter') ) ;
            trace( aliases.containsAlias('noAlias') ) ;
            
            trace("-------- aliases.containsValue()") ;
            
            trace( aliases.containsValue('system.data.maps.HashMap') ) ;
            trace( aliases.containsValue('noValue') ) ;
            
            trace("-------- aliases.getAliases()") ;
            
            trace( aliases.getAliases() ) ;
            
            trace("-------- aliases.getValue('ArrayMap')") ;
            
            trace( aliases.getValue("ArrayMap") ) ;
            
            trace("-------- aliases.getValues()") ;
            
            trace( aliases.getValues() ) ;
            
            trace("-------- iterator") ;
            
            var it:Iterator = aliases.iterator() ;
            while( it.hasNext() )
            {
                var next:String = it.next() as String ;
                var key:String  = it.key()  as String ;
                trace( aliases + " alias : '" + key + "' -> value : '" + next + "'" ) ;
            }
            
            trace("-------- clear and isEmpty") ;
            
            trace( aliases.isEmpty() ) ;
            aliases.clear() ;
            trace( aliases.isEmpty() ) ;
        }
    }
}
