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
