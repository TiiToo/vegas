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
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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
