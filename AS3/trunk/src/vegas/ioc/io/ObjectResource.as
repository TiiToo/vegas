/*

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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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
    import core.reflect.getClassName;
    
    import system.data.SimpleValueObject;
    import system.process.CoreActionLoader;
    
    /**
     * Convenience base class for resource implementations in the IoC factory loader.
     */
    public class ObjectResource extends SimpleValueObject 
    {
        
        /**
         * Creates a new ObjectResource instance.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
         */
        public function ObjectResource( init:Object=null )
        {
            super(init) ;
        }
        
        /**
         * The cache flag of this resource (default is true).
         */
        public var cache:Boolean ;
        
        /**
         * The data object of this resource.
         */
        public var data:* ;
        
        /**
         * A enabled flag of this resource.
         */
        public var enabled:Boolean ;
        
        /**
         * The resource value.
         */
        public var resource:String ;
        
        /**
         * The owner reference of this resource.
         */
        public var owner:* ;
        
        /**
         * The type of the resource.
         */
        public var type:String ;
        
        /**
         * Indicates the verbose mode of the resource.
         */
        public var verbose:Boolean ;
        
        /**
         * Creates a new ActionURLLoader object with the resource.
         * Overrides this method.
         */
        public function create():CoreActionLoader
        {
            return null ;
        }
        
        /**
         * The optional method invoked when the resource is loading.
         * Overrides this method.
         */
        public function initialize( ...args:Array ):void
        {
            //
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            return formatToString( getClassName(this) , "id" , "resource" ) ;
        }
    }
}
