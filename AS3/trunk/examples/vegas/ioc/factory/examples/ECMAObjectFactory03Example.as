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
    import examples.core.Civility;
    import examples.core.User;
    import examples.factory.UserFactory;
    import examples.factory.UserFilterFactory;
    
    import vegas.ioc.factory.ECMAObjectFactory;
    
    import flash.display.Sprite;
    
    public class ECMAObjectFactory03Example extends Sprite 
    {
        public function ECMAObjectFactory03Example()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            
            factory.create( objects ) ;
            
            var user:User ;
                
            trace("------------- examples.core static method factory") ;    
                
            user = factory.getObject( "user1" ) ;
            trace( "user1 pseudo : " + user ) ; // ekameleon
                
            trace("------------- examples.core method factory") ;   
                
            user = factory.getObject( "user2" ) ;
            trace( "user2 pseudo : " + user ) ; // pegas
                
            user = factory.getObject( "user3" ) ;
            trace( "user3 pseudo : " + user ) ; // null
                
            trace("------------- examples.core static property factory") ;
                
            trace("civility : " + factory.getObject("man") ) ;
                
            trace("------------- examples.core property factory") ;
                
            trace("name : " + factory.getObject("name") ) ; 
                
            trace("------------- examples.core value factory") ;    
                
            trace("my_value : " + factory.getObject("my_value") ) ;
                
            trace("------------- examples.core reference factory") ;
                
            trace("my_user : " + factory.getObject("my_user") + " -> " + factory.getObject("my_user").url ) ; 
        }
        
        ///////////// linkage enforcer
        
        Civility  ; 
        UserFactory ; 
        UserFilterFactory ;
        
        ////////////
        
        public var objects:Array =
        [
            // examples.core method factory
                
            {   
                id          : "user_filter_factory"  ,
                type        : "examples.factory.UserFilterFactory" ,
                arguments   : [ { value : [ "lunas" ] } ]
            }
            ,
            {   
                id                  : "user1"     , 
                type                : "examples.core.User" , 
                staticFactoryMethod : { type:"examples.factory.UserFactory" , name:"create" , arguments:[ { value : "ekameleon" } ] }
            }
            ,
            {   
                id             : "user2" , 
                type           : "examples.core.User" , 
                factoryMethod  : { factory:"user_filter_factory" , name:"build" , arguments:[ { value:"pegas" } ] }
            }
            ,
            {   
                id             : "user3" , 
                type           : "examples.core.User" , 
                factoryMethod  : {  factory:"user_filter_factory" , name:"build", arguments:[ { value : "lunas" } ]  }
            }
            ,
            
            // examples.core property factory
            
            {   
                id                    : "man"    , 
                type                  : "String" , 
                staticFactoryProperty : { type:"examples.core.Civility" , name:"MAN" }
            }
            ,
            {   
                id              : "name"   , 
                type            : "String" , 
                factoryProperty : { factory:"user2" , name:"pseudo" }
            }
            ,
            
            // examples.core value factory
            
            {
                id           : "my_value" , 
                type         : "String"   , 
                factoryValue : new String("hello world")
            }
            ,
            
            // examples.core reference factory
            
            {   
                id               : "my_user"   , 
                type             : "examples.core.User" , 
                factoryReference : "user1"     ,
                singleton        : true        ,
                lazyInit         : true        ,
                properties       : 
                [ 
                    { name:"url" , value : "http://www.ekameleon.net/" }    
                ]
            }
        ] ;
    }
}
