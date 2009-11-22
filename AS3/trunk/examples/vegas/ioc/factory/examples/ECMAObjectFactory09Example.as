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
    import examples.core.FactoryReference;

    import vegas.ioc.factory.ECMAObjectFactory;

    import flash.display.Sprite;

    public class ECMAObjectFactory09Example extends Sprite 
    {
        public function ECMAObjectFactory09Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.create( context ) ; 
            
            // test the factory
            
            var test1:FactoryReference = factory.getObject( "test1" ) as FactoryReference ;
            var test2:FactoryReference = factory.getObject( "test2" ) as FactoryReference ;
                
            trace( test1.factory ) ; // in the constructor (use #this), idem in the methods
            trace( test2.factory ) ; // in the properties (use #this)
        }
        
        public var context:Array =
        [
            { 
                id         : "test1" ,
                type       : "examples.core.FactoryReference" ,
                arguments  : [ { ref : "#this" } ]
            }
            ,
            { 
                id         : "test2" ,
                type       : "examples.core.FactoryReference" ,
                properties : 
                [ 
                    { name:"factory" , ref : "#this" }
                ]
            }
        ] ;
    }
}
