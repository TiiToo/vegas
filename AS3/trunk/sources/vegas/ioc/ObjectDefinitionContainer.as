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

package vegas.ioc 
{
    import vegas.ioc.IObjectDefinition;
    import vegas.ioc.IObjectDefinitionContainer;
    
    import system.data.maps.HashMap;
    import system.process.CoreAction;
    
    /**
     * Creates a container to register all the Object define by the corresponding IObjectDefinition objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.text.TextField ;
     * import flash.text.TextFormat ;
     * 
     * import vegas.ioc.ObjectDefinition ;
     * import vegas.ioc.ObjectDefinitionContainer ;
     * import vegas.ioc.factory.ObjectFactory ;
     * 
     * var factory:ObjectDefinitionContainer = new ObjectFactory();
     * 
     * var context:Object =
     * {
     *     id         : "my_field" ,
     *     type       : "flash.text.TextField" ,
     *     properties :
     *     [
     *         { name:"defaultTextFormat" , value:new TextFormat("verdana", 11) } ,
     *         { name:"selectable"        , value:false                         } ,
     *         { name:"text"              , value:"hello world"                 } ,
     *         { name:"textColor"         , value:0xF7F744                      } ,
     *         { name:"x"                 , value:100                           } ,
     *         { name:"y"                 , value:100                           }
     *     ]
     * }
     * 
     * var definition:ObjectDefinition = ObjectDefinition.create( context ) ;
     * 
     * container.addObjectDefinition( definition );
     * 
     * var field:TextField = (factory as ObjectFactory).getObject("my_field") as TextField ;
     * 
     * addChild(field) ;
     * </pre>
     */
    public class ObjectDefinitionContainer extends CoreAction implements IObjectDefinitionContainer 
    {
        /**
         * Creates a new ObjectDefinitionContainer instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function ObjectDefinitionContainer( global:Boolean = false , channel:String = null )
        {
            super( global, channel ) ;
            _map = new HashMap() ;
        }
        
        /**
         * Registers a new object definition in the container.
         * @param definition The Identifiable ObjectDefinition reference to register in the container.
         * @throws ArgumentError If the specified object definition is null or if this id attribut is null.
         */
        public function addObjectDefinition( definition:IObjectDefinition ):void 
        {
            if ( definition == null || definition.id == null )
            {
                throw new ArgumentError( this + " addObjectDefinition failed, the specified object definition not must be 'null' or 'undefined' or not identifiable." ) ;
            }
            else
            {
                _map.put( definition.id , definition ) ;
            }
        }
        
        /**
         * Removes all the object definitions register in the container.
         */
        public function clearObjectDefinition():void
        {
            _map.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object defines with the specified id is register in the container.
         * @param id The id of the ObjectDefinition to search. 
         * @return <code class="prettyprint">true</code> if the object defines with the specified id is register in the container.
         */
        public function containsObjectDefinition( id:String ):Boolean 
        {
            return _map.containsKey( id ) ;
        }
        
        /**
         * Returns the IObjectDefinition object register in the container with the specified id.
         * @param id the id name of the ObjectDefinition to return. 
         * @return the IObjectDefinition object register in the container with the specified id.
         * @throws ArgumentError If the specified object definition don't exist in the container.
         */
        public function getObjectDefinition( id:String ):IObjectDefinition 
        {
            if ( containsObjectDefinition( id ) )
            {
                return _map.get( id ) ;
            }
            else
            {
                throw new ArgumentError( this + " getObjectDefinition failed, the specified object definition don't exist : " + id ) ;
            }
        }
        
        /**
         * Unregisters an object definition in the container.
         * @param id The id of the object definition to remove.
         * @throws ArgumentError If the specified object definition don't exist in the container.
         */
        public function removeObjectDefinition( id:String ):void 
        {
            if ( containsObjectDefinition( id ) )
            {
                _map.remove( id ) ;
            }
            else
            {
                throw new ArgumentError( this + " removeObjectDefinition failed, the specified object definition don't exist : " + id ) ;
            }
        }
        
        /**
         * Returns the numbers of object definitions registered in the container.
         * @return the numbers of object definitions registered in the container.
         */
        public function sizeObjectDefinition():uint 
        {
            return _map.size() ;
        }
        
        /**
         * @private
         */
        private var _map:HashMap ;
    }
}
