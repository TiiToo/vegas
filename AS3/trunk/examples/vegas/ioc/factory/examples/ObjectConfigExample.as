/*

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
    import vegas.ioc.TypePolicy;
    import vegas.ioc.factory.ECMAObjectFactory;
    import vegas.ioc.factory.ObjectConfig;
    
    import flash.display.Sprite;
    
    public class ObjectConfigExample extends Sprite 
    {
        public function ObjectConfigExample()
        {
            var factory:ECMAObjectFactory = new ECMAObjectFactory() ;
            var conf:ObjectConfig         = factory.config ;
            
            conf.config = 
            { 
                prop1 : "hello world" , 
                prop2 : true 
            } ;
            
            conf.locale = 
            {
                messages :
                {
                    message1 : "my first message"  ,
                    message2 : "my second message" 
                }
            } ;
            
            conf.defaultInitMethod        = "init" ;
            conf.defaultDestroyMethod     = "destroy" ;
            
            conf.identify                 = true ;
            conf.lock                     = true ;
            
            conf.typePolicy               = TypePolicy.ALL ; // TypePolicy.NONE, TypePolicy.ALIAS, TypePolicy.EXPRESSION
            
            conf.useLogger                = true ; // indicates if the ILogger of the ObjectFactory is used to notify the warnings 
            
            conf.typeAliases              = [ { alias:"ObjectConfig" , type:"vegas.ioc.factory.ObjectConfig" } ] ;
            conf.typeExpression           = 
            [ 
                { name:"map"     , value:"system.data.maps" } ,
                { name:"HashMap" , value:"{map}.HashMap"  } 
            ] ;
            
            trace( conf ) ; // [ObjectConfig defaultDestroyMethod:destroy defaultInitMethod:init identify:true lock:true]
            
            trace("--- configEvaluator attribute") ;
            
            trace( conf.configEvaluator.eval("prop1") ) ;
            
            trace("--- localeEvaluator attribute") ;
            
            trace( conf.localeEvaluator.eval("messages.message1") ) ;
            
            trace("--- typegEvaluator attribute") ;
            
            trace( conf.typeEvaluator.eval("ObjectConfig") ) ;
            trace( conf.typeEvaluator.eval("{map}.ArrayMap") ) ;
            
            trace("--- config clear and reset the internal config object with the resetConfigTarget() method.") ;
            
            conf.config = {} ; 
            
            trace(conf.config.prop1) ; // hello world
            
            conf.resetConfigTarget() ; 
            
            trace(conf.config.prop1) ; // undefined
            
            trace("--- Defines a new internal object reference of the config attribut with the setConfigTarget() method.") ;
            
            conf.setConfigTarget( new Object() ) ;  // the passed-in objet must be dynamic !
        }
    }
}
