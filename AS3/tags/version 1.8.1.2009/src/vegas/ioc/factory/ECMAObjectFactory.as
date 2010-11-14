﻿/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package vegas.ioc.factory 
{
    import system.data.Identifiable;
    import system.data.maps.HashMap;

    /**
     * This IoC factory use an ECMAScript collection of generic objects to create and initialize all object definitions used in the application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.ioc.factory.ECMAObjectFactory ;
     * 
     * var objects:Array =
     * [
     *     {
     *         id        : "my_format" ,
     *         type      : "flash.text.TextFormat" ,
     *         arguments : [ { value:"arial" } , { value:24 } , { value:0xFEF292 } , { value:true } ]
     *     }
     *     ,
     *     {
     *         id         : "my_field" ,
     *         type       : "flash.text.TextField"  ,
     *         properties :
     *         [
     *             { name : "autoSize"          , value  : "left"            } ,
     *             { name : "defaultTextFormat" , ref    : "my_format"       } ,
     *             { name : "text"              , value  : "HELLO WORLD"     } ,
     *             { name : "x"                 , value  : 10                } ,
     *             { name : "y"                 , value  : 10                }
     *         ]
     *     }
     *     ,
     *     {
     *         id               : "root" ,
     *         type             : "flash.display.MovieClip"  ,
     *         factoryReference : "#root" ,
     *         singleton        : true ,
     *         properties       :
     *         [
     *             { name : "addChild" , arguments  : [ { ref:"my_field" } ] }
     *         ]
     *     }
     * ] ;
     * 
     * var factory:ECMAObjectFactory = ECMAObjectFactory.getInstance() ;
     * 
     * factory.config.root = this ;
     * 
     * factory.create( objects ) ; 
     * </pre>
     */
    public class ECMAObjectFactory extends ObjectFactory implements Identifiable
    {
        /**
         * Creates a new ECMAObjectFactory instance.
         * @param id The id of this factory.
         * @param objects This array contains generic objects to fill and initialize this factory with the run or create method.
         */
        public function ECMAObjectFactory( id:* = null , objects:Array = null )
        {
            super( objects ) ;
            this.id  = id ;
        }
        
        /**
         * Indicates the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
         * @private
         */
        public function set id( id:* ):void
        {
            _id = id ;
        }
        
        /**
         * Determinates the default singleton name.
         */
        public static const DEFAULT_SINGLETON_NAME:String = "__default__" ;
        
        /**
         * Indicates if the specified singleton reference is register.
         * @return <code class="prettyprint">true</code> If the specified singleton reference is register.
         */
        public static function containsInstance( id:String ):Boolean
        {
            return _instances.containsKey( id ) ;
        }
        
        /**
         * Clear all globals ECMAObjectFactory singleton references.
         */
        public static function flushInstance():void 
        {
            _instances.clear() ;
        }
        
        /**
         * Returns the singleton reference of this class.
         * @param id The index of the singleton reference to return or create (If this value is Null, the DEFAULT_SINGLETON_NAME static value is used).
         * @return the singleton reference of this class.
         */
        public static function getInstance( id:String = null ):ECMAObjectFactory
        {
            if ( id == null || id.length == 0 ) 
            {
                id = DEFAULT_SINGLETON_NAME ;
            }
            if ( ! _instances.containsKey(id) ) 
            {
                _instances.put( id , new ECMAObjectFactory( id ) ) ;
            }
            return _instances.get( id ) as  ECMAObjectFactory ;
        }
        
        /**
         * Removes a singleton reference of this class with the specified id.
         * @param id The index of the singleton reference to remove (If this value is Null, the DEFAULT_SINGLETON_NAME static value is used).
         * @return <code class="prettyprint">true</code> If the specified singleton reference is removed.
         */
        public static function removeInstance( id:String = null ):Boolean 
        {
            if ( id == null || id.length == 0 ) 
            {
                id = DEFAULT_SINGLETON_NAME ;
            }
            if ( _instances.containsKey( id ) ) 
            {
                return _instances.remove( id ) != null ;
            }
            else 
            {
                return false ;
            }
        }
        
        /**
         * @private
         */
        private var _id:* ;
        
        /**
         * @private
         */
        private static var _instances:HashMap = new HashMap() ;
    }
}