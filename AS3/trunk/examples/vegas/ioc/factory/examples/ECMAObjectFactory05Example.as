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
    import vegas.ioc.factory.ECMAObjectFactory;

    import flash.display.Sprite;

    public class ECMAObjectFactory05Example extends Sprite 
    {
        public function ECMAObjectFactory05Example()
        {
            var factory:ECMAObjectFactory ;
            
            factory = ECMAObjectFactory.getInstance() ;
            trace( "ECMAObjectFactory.getInstance()                   : " + factory + " with the default id : " + factory.id ) ;
            
            factory = ECMAObjectFactory.getInstance("factory_one") ;
            
            trace( "ECMAObjectFactory.getInstance('factory_one')      : " + factory + " with the default id : " + factory.id ) ;
            
            trace( "ECMAObjectFactory.containsInstance('factory_one') : " + ECMAObjectFactory.containsInstance("factory_one") ) ;
            
            trace( "ECMAObjectFactory.removeInstance('factory_one')   : " + ECMAObjectFactory.removeInstance("factory_one") ) ;
            
            trace( "ECMAObjectFactory.containsInstance('factory_one') : " + ECMAObjectFactory.containsInstance("factory_one") ) ;
        }
    }
}
