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

package vegas.ioc.io 
{
    import system.process.CoreActionLoader;

    import vegas.ioc.ObjectDefinition;
    import vegas.ioc.factory.ObjectFactory;
    import vegas.logging.logger;
    import vegas.media.CoreSound;
    import vegas.media.SoundLoader;
    
    import flash.net.URLRequest;
    
    /**
     * This resource contains all information about an external sound to load in the application.
     */
    public class SoundResource extends ObjectResource 
    {
        /**
         * Creates a new SoundResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function SoundResource( init:Object = null )
        {
            super(init);
            type = ObjectResourceType.SOUND ;
        }
        
        /**
         * The root path of all sound resources.
         */
        public static var DEFAULT_PATH:String = "" ;
        
        /**
         * Indicates the definition object to complete and override the default ObjectDefinition of the current sound.
         */
        public var definition:Object ;
        
        /**
         * The optional path of the external Shader file to load.
         */
        public var path:String ;
        
        /**
         * The CoreSound reference or id (in the factory) used to load the resource.
         */
        public var sound:* ;
        
        /**
         * Indicates if the object definition of this resource must be a singleton.
         */
        public var singleton:Boolean = true ;
        
        /**
         * Creates a new CoreActionLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
            try
            {
                if ( id == null || !(id is String) || id == "" )
                {
                    throw new Error(this + " create failed, the String id value of this resource not must be empty or 'null'") ;
                }
                
                var factory:ObjectFactory = owner as ObjectFactory ;
                
                if ( factory == null )
                {
                    throw new Error(this + " create failed, the factory reference of this resource not must be 'null'.") ;
                }
                
                if ( factory.containsObjectDefinition(id) )
                {
                    throw new Error(this + " create failed, the factory already contains the specified id : " + id) ;
                } 
                
                if ( sound != null )
                {
                    if ( sound is String )
                    {
                        sound = factory.getObject( sound as String ) as CoreSound ;
                    }
                    else if ( sound is CoreSound )
                    {
                        sound = sound as CoreSound ;
                    }
                }
                
                if ( sound == null )
                {
                    sound = new CoreSound() ;
                }
                
                var init:Object = 
                {
                    id           : id , 
                    type         : "vegas.media.CoreSound",
                    factoryValue : sound , 
                    singleton    : singleton , 
                    lazyInit     : true 
                };
                
                if ( definition != null )
                {
                    for (var prop:String in definition )
                    {
                       init[prop] = definition[prop] ;
                    }
                }
                
                factory.addObjectDefinition( ObjectDefinition.create( init ) ) ;
                
                var uri:String         = (path || DEFAULT_PATH) + resource ;
                var action:SoundLoader = new SoundLoader( sound )  ;
                
                action.request = new URLRequest( uri ) ;
                
                return action ;
            }
            catch( e:Error )
            {
                if ( verbose )
                {
                    logger.info(e.message) ;
                }
            }
            return null ; 
        }
        
        /**
         * Registers the resource in the ObjectResourceBuilder.
         */
        public static function register( type:String = "sound" ):void
        {
            ObjectResourceBuilder.addObjectResource( type , SoundResource ) ;
        }
    }
}
