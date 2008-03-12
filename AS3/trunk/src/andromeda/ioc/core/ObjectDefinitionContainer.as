/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{
    import vegas.errors.IllegalArgumentError;    
    
    import andromeda.ioc.core.IObjectDefinitionContainer;
    import andromeda.process.Action;
    
    import vegas.data.map.HashMap;    

    /**
     * Creates a container to register all the Object define by the corresponding IObjectDefinition objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import test.User ;
     * 
     * import andromeda.ioc.core.ObjectDefinition ;
     * import andromeda.ioc.factory.ObjectFactory ;
     * 
     * import vegas.data.map.HashMap ;
     * 
     * var factory:ObjectFactory = new ObjectFactory();
     * 
     * var properties:HashMap = new HashMap() ;
     * properties.put("pseudo" , "ekameleon" ) ;
     * properties.put("url"  , "http://www.ekameleon.net/blog" );
     * 
     * var definition:ObjectDefinition = new ObjectDefinition( "test.User" ) ;
     * definition.setProperties( properties ) ;
     * definition.setInitMethodName( "initialize" ) ;
     * 
     * factory.addObjectDefinition("user", definition );
     * 
     * var user:User = factory.getObject("user") ;
     * 
     * trace( "# User pseudo : " + user.pseudo ) ; // ekameleon
     * trace( "# User url    : " + user.url    ) ; // http://www.ekameleon.net/blog
     * </pre>
     * With the <b>test.User</b> class :
     * <pre class="prettyprint">
     * package test
     * {
     *     import vegas.core.CoreObject ;
     * 
     *     public class User extends CoreObject
     *     {
     *         
     *         public function User() {}
     *         
     *         public var pseudo:String ;
     *         public var url:String ;
     *         
     *         public function initialize():void
     *         {
     *             trace( "# " + this + " initialize.") ;
     *         }
     *         
     *     }
     * }
     * </pre>
     * @author eKameleon
     */
    public class ObjectDefinitionContainer extends Action implements IObjectDefinitionContainer 
    {

        /**
         * Creates a new ObjectDefinitionContainer instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function ObjectDefinitionContainer( bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal, sChannel ) ;
            _map = new HashMap() ;
        }
        
        /**
         * Registers an object in the container.
         * @param name the name of the object.
         * @param definition the definition of the object.
         */
        public function addObjectDefinition( name:String, definition:IObjectDefinition ):void 
        {
            _map.put( name, definition ) ;
        }
        
        /**
         * Removes all the object definitions register in the container.
         */
        public function clearObjectDefinition():void
        {
            _map.clear() ;
        }        
        
        /**
         * Returns <code class="prettyprint">true</code> if the object define with the specified name in register in the container.
         * @param name the id name of the ObjectDefinition to search. 
         * @return <code class="prettyprint">true</code> if the object define with the specified name in register in the container.
         */
        public function containsObjectDefinition( name:String ):Boolean 
        {
            return _map.containsKey( name ) ;
        }
        
        /**
         * Returns the numbers objects registered in the container.
         * @param name the id name of the ObjectDefinition to return. 
         * @return the IObjectDefinition registered in the container.
         * @throws IllegalArgumentError If the specified object definition don't exist in the container.
         */
        public function getObjectDefinition( name:String ):IObjectDefinition 
        {
            if ( containsObjectDefinition( name ) )
            {
                return _map.get( name ) ;
            }
            else
            {
                throw new IllegalArgumentError( this + " getObjectDefinition failed, the specified object definition don't exist : " + name ) ;
            }
        }
        
        /**
         * Unregisters an object definition in the container.
         * @param name the name of the object definition.
         * @throws IllegalArgumentError If the specified object definition don't exist in the container.
         */
        public function removeObjectDefinition( name:String ):void 
        {
            if ( containsObjectDefinition( name ) )
            {
                _map.remove( name ) ;
            }
            else
            {
                throw new IllegalArgumentError( this + " removeObjectDefinition failed, the specified object definition don't exist : " + name ) ;    
            }
        }        
        
        /**
         * Returns the numbers objects registered in the container.
         * @return the numbers objects registered in the container.
         */
        public function sizeObjectDefinition():Number 
        {
            return _map.size() ;
        }
        
        /**
         * @private
         */
        private var _map:HashMap ;
        
    }
}
