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
    import vegas.ioc.ObjectArgument;
    import vegas.ioc.ObjectAttribute;
    
    import flash.display.Sprite;
    
    public class ObjectArgumentExample extends Sprite 
    {
        public function ObjectArgumentExample()
        {
            var args:Array =
            [
            
                { value  : "hello world"  } ,
                { ref    : "my_id"        } ,
                { config : "config.value" } ,
                { locale : "locale.value" } ,
                
                { value  : "hello world" , evaluators:["myEvaluator"] } 
                
            ] ;
            
            args = ObjectArgument.create( args ) ; // transform all arguments with the ObjectArgument factory.
            
            trace( args[0] is ObjectArgument ) ; // true
            
            trace( args[0].policy == ObjectAttribute.VALUE     ) ; // true
            trace( args[1].policy == ObjectAttribute.REFERENCE ) ; // true
            trace( args[2].policy == ObjectAttribute.CONFIG    ) ; // true
            trace( args[3].policy == ObjectAttribute.LOCALE    ) ; // true
            
            trace( args[4].evaluators ) ; // myEvaluator
        }
    }
}
