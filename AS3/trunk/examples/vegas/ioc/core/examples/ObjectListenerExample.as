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
    import vegas.ioc.ObjectListener;
    
    import flash.display.Sprite;
    
    public class ObjectListenerExample extends Sprite 
    {
        public function ObjectListenerExample()
        {
            var init:Array = 
            [
                { dispatcher:"dispatcher1" , type:"change" , method:"handleEvent" } ,
                { dispatcher:"dispatcher2" , type:"change" , method:"handleEvent" , order:"before" } ,
                { dispatcher:"dispatcher3" , type:"change" } 
            ] ;
                
            var listeners:Array = ObjectListener.create( init ) ;
            
            trace( listeners ) ;
        }
    }
}
