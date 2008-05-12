﻿/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  Marc Alcaraz <ekameleon@gmail.com>

*/
package system.reflection
    {
    import flash.utils.describeType;
    
    import system.Reflection;
    
    [ExcludeClass]
    
    /**
     * The concrete class of the ClassInfo interface.
     */
    public class _ClassInfo extends _TypeInfo implements ClassInfo
        {
        
        /**
         * @private
         */
        private var _class:XML;
        
        /**
         * Creates a new _ClassInfo instance.
         */
        public function _ClassInfo( o:* )
            {
            super( o );
            _class = describeType( o );
            /*
            trace( _class );
            
            if( _class.hasOwnProperty( "extendsClass" ) )
                {
                trace( "Super: " + _class.extendsClass[0].@type );
                }
            else
                {
                trace( "no super" );
                }
            trace( "--------" );
            */
            }
        
        /**
         * @private
         */
        private function _normalize( value:String ):String
            {
            return value.replace( "::", "." );
            }
                
        /**
         * Indicates the name of the class.
         */
        public function get name():String
            {
            var path:String = _class.@name;
            
            if( config.normalizePath )
                {
                path = _normalize( path );
                }
            
            return path;
            }
                
        /**
         * Indicates the Array representation of all members in the class.
         */
        public function get members():Array
            {
            return null;
            }
        
        /**
         * Indicates the Array representation of all methods in the class.
         */
        public function get methods():Array
            {
            return null;
            }
            
        /**
         * Indicates the Array representation of all static member informations.
         */   
        public function get staticMembers():Array
            {
            return null;
            }            
        
        public function get staticMethods():Array
            {
            return null;
            }
            
        /**
         * Indicates the ClassInfo object of the super class.
         */
        public function get superClass():ClassInfo
            {
            var path:String = "";
            var c:Class;
            
            if( isInstance() &&  _class.hasOwnProperty( "extendsClass" ) )
                {
                path = _class.extendsClass[0].@type;
                }
            else if( !isInstance() && _class.factory.hasOwnProperty( "extendsClass" ) )
                {
                path = _class.factory.extendsClass[0].@type;
                }
            
            if( path != "" )
                {
                c = Reflection.getClassByName( path );
                return new _ClassInfo( c );
                }
            else
                {
                return null;
                }
            }            
        
        /**
         * Indicates if the specified object is dynamic.
         */        
        public function isDynamic():Boolean
            {
            return _class.@isDynamic == "true";
            }
        
        /**
         * Indicates if the specified object is final.
         */        
        public function isFinal():Boolean
            {
            return _class.@isFinal == "true";
            }
        
        /**
         * Indicates if the specified object is instance.
         */        
        public function isInstance():Boolean
            {
            return _class.@base != "Class";
            }        
        
        /**
         * Indicates if the specified object is static.
         */
        public function isStatic():Boolean
            {
            return _class.@isStatic == "true";
            }
        

        }
    }

