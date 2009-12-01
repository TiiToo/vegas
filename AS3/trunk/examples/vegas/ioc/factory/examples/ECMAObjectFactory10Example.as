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
    import examples.core.FactoryReference;

    import vegas.ioc.factory.ECMAObjectFactory;

    import flash.display.Sprite;

    public class ECMAObjectFactory10Example extends Sprite 
    {
        public function ECMAObjectFactory10Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.config.root = this ;
            
            factory.create( context ) ;
            
            // use the factory
            
            var test:FactoryReference = factory.getObject( "test" ) as FactoryReference ; 
                
            trace( test.factory ) ; // in the constructor (use #this), idem in the methods
            trace( test.root    ) ; // in the properties (use #root)    
            
            trace( factory.getObject("root") as Sprite ) ; // use the strategy factoryReference and the #root expression
        }
        
        public var context:Array =
        [
            { 
                id         : "test" ,
                type       : "examples.core.FactoryReference" ,
                properties : 
                [ 
                    { name:"factory" , ref : "#this" } ,
                    { name:"root"    , ref : "#root" } 
                ]
            }
            ,
            { 
                id               : "root" ,
                type             : "flash.display.Sprite" ,
                factoryReference : "#root"  
            }
        ] ;
    }
}
