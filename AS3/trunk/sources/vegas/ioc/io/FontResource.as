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
    import system.process.ActionLoader;
    import system.process.CoreActionLoader;
    
    import vegas.events.FontEvent;
    import vegas.ioc.factory.ObjectFactory;
    import vegas.text.FontLoader;
    import vegas.ioc.io.ObjectResourceBuilder;
    
    import vegas.logging.logger;
    
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.text.Font;
    
    /**
     * This resource contains all information about an external library (swf) to embed fonts in the application.
     */
    public class FontResource extends ObjectResource 
    {
        /**
         * Creates a new FontResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function FontResource( init:Object=null )
        {
            super(init) ;
            type = ObjectResourceType.FONT ;
        }
        
        /**
         * The root path of all stylesheet resources.
         */
        public static var DEFAULT_PATH:String = "" ;
        
        /**
         * Indicates if the fonts in the external swf library (symbol class) are auto registered when the external file is loading. 
         */
        public var autoRegister:Boolean ;
        
        /**
         * Indicates if the assembly must check a policy file in the server of the external library to load.
         */
        public var checkPolicyFile:Boolean ;
        
        /**
         * The Array representation of all full class name of all embed fonts to load and register in the external library.
         */
        public var fonts:Array ;
        
        /**
         * The optional path of the external font library to load.
         */
        public var path:String ;
        
        /**
         * Creates a new CoreActionLoader object with the resource.
         */
        public override function create():CoreActionLoader
        {
               var action:ActionLoader ;
               var isRegistered:Boolean = ( fonts != null && fonts.length > 0 ) ;
               if ( autoRegister || isRegistered  )
               {
                   var name:String ;
                   var path:String       = path || DEFAULT_PATH ;
                   var loader:FontLoader = new FontLoader() ;
                   
                   loader.addEventListener( FontEvent.ADD_FONT , _addFont ) ;
                   
                loader.autoRegister   = autoRegister ;
                if ( isRegistered )
                {
                     
                       var size:int          = fonts.length ;
                       for ( var i:int ; i<size ; i++ )
                       {
                           name = fonts[i] as String ;
                          if (name != null && name.length > 0 )
                          {
                              loader.registerFontClassName(name) ;
                          }
                       }
                }
                   action          = new ActionLoader( loader ) ;
                   action.context  = new LoaderContext( checkPolicyFile , ApplicationDomain.currentDomain ) ; 
                action.request  = new URLRequest( path + resource ) ;
               }
            return action ;
        }
        
        /**
         * Registers the resource in the ObjectResourceBuilder.
         */
        public static function register( type:String = "font" ):void
        {
            ObjectResourceBuilder.addObjectResource( type , FontResource ) ;
        }
        
        /**
         * @private
         */
        private function _addFont( e:FontEvent ):void
        {
            if ( verbose )
            {
                var font:Font = e.font ;
                if ( font != null )
                {
                    var message:String = this + " register a new font [name:" + font.fontName + ", type:" + font.fontType + ", style:" + font.fontStyle + "]" ;
                    var factory:ObjectFactory = owner as ObjectFactory ;
                    if ( factory != null )
                    {
                        if ( factory.config.useLogger )
                        {
                            logger.info( message ) ;
                            return ;
                        }
                    }
                }
            }
        }
    }
}
