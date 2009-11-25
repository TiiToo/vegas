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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import vegas.net.HTMLEntities;
    
    import flash.display.Sprite;
    
    public class HTMLEntitiesExample extends Sprite 
    {
        public function HTMLEntitiesExample()
        {
            var s:String = "<p>Hello, The school is closed at 50%</p><p>The fast food this year is open.</p>" ;
            
            s = HTMLEntities.encode(s) ;
            trace("HTML entities encode : " + s) ;
            
            trace('---------') ;
            
            s = HTMLEntities.decode(s) ;
            trace("HTML entities decode : " + s) ;
            
            trace( HTMLEntities.getCharToEntity("€") ) ;
            trace( HTMLEntities.getCharToEntityNumber("€") ) ;
            trace( HTMLEntities.getEntityNumberToChar("&#8364;") ) ;
        }
    }
}
