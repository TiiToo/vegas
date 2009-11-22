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
    import examples.display.RectangleSprite;
    
    import vegas.ioc.factory.ECMAObjectFactory;
    
    import flash.display.Sprite;
    
    public class ECMAObjectFactory06Example extends Sprite 
    {
        public function ECMAObjectFactory06Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            // if true all Lockable object are locked during the initialization of the properties and methods of the object in the factory.
            // factory.config.lock = true ; 
            
            factory.create( objects ) ;
            
            var rec:RectangleSprite = factory.getObject("my_rectangle") as RectangleSprite ;
            
            addChild( rec ) ;
            
            // if definition.lock == true  : the object is locked.
            // if definition.lock == false : the object is not locked.
            // if definition.lock == null  : the object is locked only if the config.lock attribute in the factory is true.
            
            // in this example if the object is locked only 2 times the update() is invoked else 5 times !
        }
        
        public var objects:Array =
        [
            {   
                id          : "my_rectangle"  ,
                type        : "examples.display.RectangleSprite" ,
                lock        : true     , // can be 'true', 'false' or 'null'
                init        : "update" , 
                properties  : 
                [ 
                    { name : "color" , value : 0xFF00FF } , // launch the update method
                    { name : "w"     , value : 200      } , // launch the update method
                    { name : "h"     , value : 180      } , // launch the update method
                    { name : "x"     , value : 20       } ,
                    { name : "y"     , value : 20       } 
                ]
            }
        ] ;
    }
}
