/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.text 
{
    import flash.events.Event;
    import flash.system.ApplicationDomain;
    import flash.text.Font;
    
    import asgard.display.CoreLoader;
    import asgard.events.FontEvent;
    
    import vegas.data.iterator.Iterator;
    import vegas.data.sets.HashSet;
    import vegas.util.ClassUtil;    

    /**
     * This loader load an external swf who contains embed fonts.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.events.FontEvent ;
     * import asgard.text.CoreTextField ;
     * import asgard.text.FontLoader ;
     * 
     * import flash.events.Event ;
     * import flash.net.URLRequest ;
     * import flash.system.LoaderContext ;
     * import flash.text.TextFormat ;
     * 
     * var field1:CoreTextField = new CoreTextField( null , 150 , 20 ) ;
     * field1.border     = true ;
     * field1.embedFonts = true ;
     * field1.x          = 25 ;
     * field1.y          = 25 ;
     * 
     * var field2:CoreTextField = new CoreTextField( null , 150 , 20 ) ;
     * field2.x      = 25 ;
     * field2.y      = 50 ;
     * field2.border = true ;
     * 
     * field2.textColor = 0x000000 ;
     * field2.embedFonts = true ;
     * 
     * addChild(field1) ;
     * addChild(field2) ;
     * 
     * var addFont:Function = function( e:FontEvent ):void
     * {
     *     trace( e.type + " font:" + e.font ) ;
     * }
     * 
     * var complete:Function = function( e:Event )
     * {
     * 
     *     trace( "fonts : " + Font.enumerateFonts() ) ;
     *     
     *     field1.defaultTextFormat = new TextFormat("Arial Black", 12 , 0xFFFFFF ) ;
     *     field1.text = "hello world" ;
     *     
     *     field2.defaultTextFormat = new TextFormat("Myriad Pro", 12 , 0xFFFFFF ) ;
     *     field2.text = "hello world" ;
     * }
     * 
     * var request:URLRequest = new URLRequest( "fonts/fonts.swf" ) ;
     * 
     * var loader:FontLoader = new FontLoader() ;
     * 
     * loader.context = new LoaderContext( false , ApplicationDomain.currentDomain ) ;
     * 
     * loader.contentLoaderInfo.addEventListener( Event.COMPLETE , complete ) ;
     * loader.addEventListener( FontEvent.ADD_FONT , addFont ) ;
     * 
     * loader.registerFontClassName( "ArialBlack" ) ;
     * loader.registerFontClassName( "MyriadPro" ) ;
     * 
     * loader.load( request  ) ;
     * </pre>
     * <p>the external file "font/fonts.swf" contains in this library the two Font symbols.</p>
     * @author eKameleon
     */
    public class FontLoader extends CoreLoader 
    {

        /**
         * Creates a new FontLoader instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function FontLoader( id:* = null, isConfigurable:Boolean = false, name:String = null )
        {
            super( id, isConfigurable, name );
            contentLoaderInfo.addEventListener( Event.COMPLETE, complete ) ;
        }
        
        /**
         * Registers a new FontClassName in the specified FontLoader.
         */
        public function registerFontClassName( name:String ):Boolean
        {
            return _fontClassNames.insert( name ) ;
        }
        
        /**
         * Unregisters a new FontClassName in the specified FontLoader.
         */
        public function unRegisterFontClassName( name:String ):Boolean
        {
            return _fontClassNames.remove(name) ;    
        }
        
        /**
         * Returns the number of embed fonts to load and create with this loader.
         * @return the number of embed fonts to load and create with this loader.
         */
        public function size():uint
        {
            return _fontClassNames.size() ;    
        }
        
        /**
         * Returns the Array representation of the font names.
         * @return the Array representation of the font names.
         */
        public function toArray():Array
        {
            return _fontClassNames.toArray() ;    
        }
        
        /**
         * Invoked when the FontLoader process is complete.
         */
        protected function complete( e:Event ) : void
        {
            if ( _fontClassNames.size() > 0 )
            {

                var it:Iterator = _fontClassNames.iterator() ;
                var name:String  ;
                var clazz:Class  ; 
                var font:Font    ;
                
                while ( it.hasNext() )
                {
                    name  = it.next() ;    
                    clazz = contentLoaderInfo.applicationDomain.getDefinition( name ) as Class ;
                    if ( clazz != null )
                    {
                        if ( ClassUtil.extendsClass( clazz, Font ) )
                        {
                            Font.registerFont( clazz ) ;
                            font = new clazz() as Font ;
                            dispatchEvent( new FontEvent( FontEvent.ADD_FONT , font , this ) ) ;
                        }
                    }
                }
            }            

        }
        
        /**
         * The font class name.
         */
        protected var _fontClassNames:HashSet = new HashSet() ;

    }
}
