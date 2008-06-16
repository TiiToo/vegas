﻿
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [eden: ECMASCript data exchange notation for AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  Marc Alcaraz <ekameleon@gmail.com>.

*/

package buRRRn.eden
{
	import system.ISerializable;
	import system.ISerializer;    

	/**
     * The eden Serializer class
     */    
    public class EdenSerializer implements ISerializer, ISerializable
        {
        	
		/**
		 * @private
		 */
        private var _prettyIndent:int = 0;     //default
        
		/**
		 * @private
		 */
        private var _prettyPrinting:Boolean = false; //default
        
		/**
		 * @private
		 */
        private var _indentor:String = "    ";//default
        
        /**
         * Creates a new EdenSerializer instance.
         */
        public function EdenSerializer()
            {
            /* note:
               later we may want to configure the instanciation of the serializer
               ex: custom config, custom authorized etc.
            */
            }
        
		/**
		 * Indicates the pretty indent value.
		 */        
        public function get prettyIndent():int
            {
            return _prettyIndent;
            }
        
		/**
		 * Indicates the indentor string representation.
		 */        
        public function get indentor():String
            {
            return _indentor;
            }
		
		/**
		 * @private
		 */
        public function set indentor( value:String ):void
            {
            _indentor = value;
            }
        
		/**
		 * @private
		 */
        public function set prettyIndent( value:int ):void
            {
            _prettyIndent = value;
            }
        
		/**
		 * Indicates the pretty printing flag value.
		 */
        public function get prettyPrinting():Boolean
            {
            return _prettyPrinting;
            }
        
		/**
		 * @private
		 */
        public function set prettyPrinting( value:Boolean ):void
            {
            _prettyPrinting = value;
            }
        
		/**
		 * Parse a string and interpret the source code to the correct ECMAScript construct.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * "undefined" --> undefined
		 * "0xFF"      --> 255
		 * "{a:1,b:2}" --> {a:1,b:2}
		 * </pre>
         * @return a string representing the data.
		 */    
        public function deserialize( source:String ):*
            {
            return ECMAScript.evaluate( source );
            }
        
		/**
		 * Serialize the specified value object passed-in argument.
		 */    
        public function serialize( value:* ):String
            {
            if( value === undefined )
                {
                return "undefined";
                }
            
            if( value === null )
                {
                return "null";
                }
            
            if( value is ISerializable )
                {
                return value.toSource( prettyIndent );
                }
            
            if( value is String )
                {
                return Serializer.emitString( value );
                }
            
            if( value is Boolean )
                {
                return value ? "true": "false";
                }
            
            if( value is Number )
                {
                return value.toString();
                }
            
            if( value is Date )
                {
                return Serializer.emitDate( value );
                }
            
            /* TODO:
               - add RegExp serializer
                 cf: new RegExp( "abc", "i" );
               - add XML serializer
                 cf: new XML( "<data><node>xyz</node></data>" );
            */
            
            if( value is Array )
                {
                return Serializer.emitArray( value );
                }
            
            if( value is Object )
                {
                return Serializer.emitObject( value );
                }            
            
            return "<unknown>";
            }

        
		/**
		 * Returns the source code string representation of the object.
		 * @return the source code string representation of the object.
		 */
        public function toSource( indent:int = 0 ):String
            {
            return info(false,false);
            }
        
        }
    }

