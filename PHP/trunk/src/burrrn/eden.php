<?php

/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation PHP. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

/* notes:
   - we do not handdle these line terminators: \x2028, \x2029
   - UTF-8 in strings are always translated to this notation: \uFFFF
     (will be patched later with an option)
   - don't use the $ sign in strings (could be patched later)
   - about packages and classes
     the global $packagesRepository contain the root directory
     of the different packages and classes
     if you instanciate
     new hello.world( 1, 2, 3 )
     it correspond to
     $packagesRepository/hello/world.php
     
     world.php containing the class "world"
   - quotes
     in PHP we don't escape single quote inside double quotes...
     "\"hello world\"" would be noted "'hello world'"
     simple workaround is to only use double quotes
   - NAN is not so well handled in PHP ...
     don't use is_nan( num ) , use if( num === NAN )
   - $config->copyObjectByValue , passing by object ref does not work
     either true or false the object will be copied by value
     (need to be patched later)
   - if scope if different than $GLOBALS it can only be a single object
     for ex "toto", not an object path "toto.tutu"
     you have to pass the scope as string
  
  eden packets format:
  header   | [AuthKey] | data
                 |_ optional
  0xFFFFFF
    \|||||_ encoding
     ||||__ encryption
     |||___ version
     ||____ options
     |_____ protocol
  
  protocol: 0xFF
  id of the data exchange protocol
  for eden we use 0xed
  -> eden protocol is mean to work with an ECMAScript parser
     it could happen that another protocol would want to work
     with the same system with another parser
  
  options: 0xF
  we pack 4 binary options into a hex
   0000 (binary)
   ||||_ mode    0: global/local code  1: Remoting
   |||__ AuthKey 0: no AuthKey         1: need AuthKey
   \|___ n/a (reserved for futur use)
  
    1) mode:
       parsing/executing mode of the packet
       by default we interpret the data
       as global/local code (0)
       but later it is planed to have a remoting mode (1)
    2) AuthKey:  
       here we indicate if the packet need an AuthKey
       (Authorization key) to be interpreted
       -> if (1) (meaning need an AuthKey)
          we check after the header the optional [AuthKey]
  
  version: 0xF
  the version of the protocol
  from 0 to 16
  as it's the first implementation we start at 0x0
  (even if eden version is considered v0.9)
  
  encryption: 0xF
  the data encryption type
  0x0 -> no encryption
  0x1 -> Tea
  etc.
  
  encoding: 0xF
  the encoding type
  0x0 -> RAW
  0x1 -> BASE64
  etc.
  
  other notes:
  eden is a serializer/deserializer library using a subset of the ECMAScript notation
  when you use it to exchange data between a client and a server
  it become a kind of protocol, a messaging protocol.
  This messaging protocol is text based and use the Hypertext transfer Protocol (HTTP)
  as its vehicule on the application level and follow the standards
  of URI (Uniforme Resource Identifier), MIME (Multipurpose Internet mail Extensions), etc.
  By default this protocol use the "application/ecmascript" content-type
  and the UTF-8 character set as the default encoding scheme.
  
  application/ecmascript mimetype is defined here (as a working draft)
  http://www.ietf.org/internet-drafts/draft-hoehrmann-script-types-03.txt
  
  type conversion:
  
  ECMAScript type   |   PHP type   
  (JS, AS, etc..)   |              
  ---------------------------------
      undefined     |    NULL      
      null          |    NULL      
  ---------------------------------
      Number        |   integer    
      Number        |   double     
      Number        |   float      
  ---------------------------------
      Boolean       |   boolean    
  ---------------------------------
      Date          |     --       
  ---------------------------------
      Array         |   array      
  ---------------------------------
      Object        |   stdClass   
  ---------------------------------
      custom        |   custom     
    Constructor     |   Class      
  ---------------------------------

  
*/

include_once( "eden/config.php" );
include_once( "eden/strings.php" );
include_once( "eden/GenericParser.php" );
include_once( "eden/ECMAScript.php" );

class eden
    {
    
    var $logs;
    var $rootpath;
    
    function eden( $rootpath="" )
        {
        $this->logs = array();
        $this->rootpath = $rootpath;
        }
    
    function _trace( /*String*/ $message )
        {
        echo $message;
        }
    
    function getRoot()
        {
        return $this->rootpath;
        }
    
    function getRepository()
        {
        global $config;
        return $this->getRoot() . $config->packagesRepository . $config->directorySeparator;
        }
    
    function log( /*String*/ $message )
        {
        global $config;
        array_push( $this->logs, $message );
        
        if( $config->verbose )
            {
            $this->_trace( $message );
            }
        
        }
    
    function onParsed()
        {
        //echo "eden.onParsed()<br />";
        }
    
    function serialize( $reference )
        {
        
        switch( gettype($reference) )
            {
            case "NULL":
            return "null";
            
            case "boolean":
            return $reference ? "true" : "false";
            
            case "integer":
            return (int) $reference;
            
            case "double":
            if( $reference === NAN )
                {
                return NAN;
                }
            
            return (double) $reference;
            
            case "float":
            return (float) $reference;
            
            case "string":
            return $this->_serializeString( utf8_encode( $reference ) );
            
            case "array":
            if( is_array($reference) && count($reference) &&
                (array_keys($reference) !== range(0, sizeof($reference)-1)) )
                {
                return $this->_serializeObject( $reference );
                }
            
            return $this->_serializeArray( $reference );
            
            case "object":
            $classname = get_class( $reference );
            
            if( $classname != "stdClass" )
                {
                return $this->_serializeClass( $reference );
                }
            
            return $this->_serializeObject( $reference );
            
            default:
            return "[[unknown]]";
            }
        
        }
    
    function _UTF16toUTF8( /*Char*/ $utf16 )
        {
                //mask       0x 00000000 - 00000000
        $bytes = ( ord($utf16{0}) << 8 ) | ord($utf16{1});
        
        switch( true )
            {
            
            //U-00000000 - U-0000007F
            case ( (0x7F & $bytes) == $bytes ):
            return chr(0x7F & $bytes);
            
            //U-00000080 - U-000007FF
            case ( (0x07FF & $bytes) == $bytes );
            $byte1 = chr( 0xC0 | ( ($bytes >> 6) & 0x1F ) );
            $byte2 = chr( 0x80 | (  $bytes  & 0x3F  ) );
            return $byte1 . $byte2;
            
            //U-00000800 - U-0000FFFF
            case ( (0xFFFF & $bytes) == $bytes );
            $byte1 = chr( 0xE0 | ( ($bytes >> 12) & 0x0F ) );
            $byte2 = chr( 0x80 | ( ($bytes >> 6)  & 0x3F ) );
            $byte3 = chr( 0x80 | (  $bytes  & 0x3F  ) );
            return $byte1 . $byte2 . $byte3;
            
            }
        
        return "?";
        }
    
    function _UTF8toUTF16( /*Char*/ $utf8 )
        {
        
        switch( strlen($utf8) )
            {
            
            case 1:
            return $utf8;
            
            case 2:
            $byte1 = chr(  0x07 & (ord($utf8{0}) >> 2) );
            $byte2 = chr( (0xC0 & (ord($utf8{0}) << 6)) | (0x3F & (ord($utf8{1}))) );
            return $byte1 . $byte2;
            
            case 3:
            $byte1 = chr( (0xF0 & (ord($utf8{0}) << 4)) | (0x0F & (ord($utf8{1}) >> 2)) );
            $byte2 = chr( (0xC0 & (ord($utf8{1}) << 6)) | (0x7F & (ord($utf8{2}))) );
            return $byte1 . $byte2;
            }
        
        return "?";
        }
    
    function _serializeString( /*String*/ $utf8 )
        {
        $ascii = "";
        
        for( $c = 0; $c < strlen($utf8); ++$c )
            {
            $ord_c = ord( $utf8{$c} );
            
            switch( true )
                {
                case ($ord_c == 0x08):  //backspace
                $ascii .= "\\b";
                break;
                
                case ($ord_c == 0x09):  //horizontal tab
                $ascii .= "\\t";
                break;            
                
                case ($ord_c == 0x0A):  //line feed
                $ascii .= "\\n";
                break;
                
                case ($ord_c == 0x0B):  //vertical tab
                $ascii .= "\\v";
                break;
                
                case ($ord_c == 0x0C):  //form feed
                $ascii .= "\\f";
                break;
                
                case ($ord_c == 0x0D):  //carriage return
                $ascii .= "\\r";
                break;
                
                case ($ord_c == 0x22):  //double quote
                $ascii .= "\\\"";
                break;
                
                case ($ord_c == 0x27):  //single quote
                $ascii .= "\\'";
                break;
                
                case ($ord_c == 0x5c):  //backslash
                $ascii .= "\\\\";
                break;
                
                // U-00000000 - U-0000007F
                case (($ord_c >= 0x20) && ($ord_c <= 0x7F)):
                $ascii .= $utf8{$c};
                break;
                
                // U-00000080 - U-000007FF
                case (($ord_c & 0xE0) == 0xC0):
                $bin    = pack( "C*",
                                $ord_c,
                                ord( $utf8{ $c + 1 } )
                              );
                $c     += 1;
                $utf16  = $this->_UTF8toUTF16( $bin );
                $ascii .= sprintf( "\u%04s", bin2hex($utf16) );
                break;
                
                // U-00000800 - U-0000FFFF
                case (($ord_c & 0xF0) == 0xE0):
                $bin    = pack( "C*",
                                $ord_c,
                                ord( $utf8{ $c + 1 } ),
                                ord( $utf8{ $c + 2 } )
                              );
                $c     += 2;
                $utf16  = $this->_UTF8toUTF16( $bin );
                $ascii .= sprintf( "\u%04s", bin2hex($utf16) );
                break;
                
                // U-00010000 - U-001FFFFF
                case (($ord_c & 0xF8) == 0xF0):
                $bin    = pack( "C*",
                                $ord_c,
                                ord( $utf8{ $c + 1 } ),
                                ord( $utf8{ $c + 2 } ),
                                ord( $utf8{ $c + 3 } )
                              );
                $c     += 3;
                $utf16  = $this->_UTF8toUTF16( $bin );
                $ascii .= sprintf( "\u%04s", bin2hex($utf16) );
                break;
                
                // U-00200000 - U-03FFFFFF
                case (($ord_c & 0xFC) == 0xF8):
                $bin    = pack( "C*",
                                $ord_c,
                                ord( $utf8{ $c + 1 } ),
                                ord( $utf8{ $c + 2 } ),
                                ord( $utf8{ $c + 3 } ),
                                ord( $utf8{ $c + 4 } )
                              );
                $c     += 4;
                $utf16  = $this->_UTF8toUTF16( $bin );
                $ascii .= sprintf( "\u%04s", bin2hex($utf16) );
                break;
                
                // U-04000000 - U-7FFFFFFF
                case (($ord_c & 0xFC) == 0xF8):
                $bin    = pack( "C*",
                                $ord_c,
                                ord( $utf8{ $c + 1 } ),
                                ord( $utf8{ $c + 2 } ),
                                ord( $utf8{ $c + 3 } ),
                                ord( $utf8{ $c + 4 } ),
                                ord( $utf8{ $c + 5 } )
                              );
                $c     += 5;
                $utf16  = $this->_UTF8toUTF16( $bin );
                $ascii .= sprintf( "\u%04s", bin2hex($utf16) );
                break;
                }
            
            }
        
        return '"'.$ascii.'"';
        }
    
    function _toNameValuePair( $name, $value )
        {
        $serialized = $this->serialize( $value );
        return $name.":".$serialized;
        }
    
    function _serializeObject( $reference )
        {
        $obj = get_object_vars( $reference );
        $elements = array_map( array( $this, "_toNameValuePair" ),
                               array_keys( $obj ),
                               array_values( $obj ) );
        
        return "{".join( ",", $elements )."}";
        }
    
    function _serializeClass( $reference )
        {
        global $config;
        
        $classname = get_class( $reference );
        
        if( method_exists( $reference, "toSource" ) )
            {
            return $reference->toSource();
            }
        
        if( $config->serializeUnserializableClass )
            {
            return $this->_serializeObject( $reference );
            }
        else
            {
            return $this->serialize( $config->undefineable );
            }
        }
    
    function _serializeArray( $reference )
        {
        $elements = array_map( array($this, "serialize"), $reference );
        return "[".join( ",", $elements )."]";
        }
    
    function &deserialize( /*String*/ $source, /*String*/ $scope=null, $callback=null )
        {
        return ECMAScript::evaluate( $source, $scope, $callback );
        }
    
    }

?>