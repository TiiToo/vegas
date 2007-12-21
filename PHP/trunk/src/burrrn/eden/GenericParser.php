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

include_once( "config.php" );
include_once( "strings.php" );

class GenericParser
    {
    
    var $_callback;
    
    var $source;
    var $pos;
    var $ch;
    
    function GenericParser( /*String*/ $source, /*String*/ $callback=null )
        {
        global $config;
        global $strings;
        
        if( is_null($callback) )
            {
            $callback = "eden";
            }
        
        $this->_callback = $callback;
        
        $this->source = $source;
        $this->pos    = 0;
        $this->ch     = "";
        }
    
    function log( $message )
        {
        call_user_func_array( array( $this->_callback, "log" ), array( $message ) );
        }
    
    function onParsed()
        {
        call_user_func( array( $this->_callback, "onParsed" ) );
        }
    
    function getCharAt( /*int*/ $pos=null )
        {
        if( is_null($pos) )
            {
            $pos = $this->pos;
            }
        
        return $this->source{$pos};
        }
    
    function getChar()
        {
        if( strlen($this->source) <= $this->pos )
            {
            return "";
            }
        
        return $this->source{ $this->pos };
        }
    
    function next()
        {
        $this->ch = $this->getChar();
        $this->pos++;
        return $this->ch;
        }
    
    function hasMoreChar()
        {
        $len = strlen($this->source);
        $len -= 1;
        
        return $this->pos <= $len;
        }
    
    function runeval()
        {
        
        }
    
    function evaluate( /*String*/ $source )
        {
        $parser = new buRRRn_eden_GenericParser( $source );
        return $parser->runeval();
        }
    
    function isAlpha( /*Char*/ $c )
        {
        return( (("A" <= $c) && ($c <= "Z")) || (("a" <= $c) && ($c <= "z")) );
        }
    
    function isASCII( /*Char*/ $c )
        {
        return( ord($c) <= 255 );
        }
    
    function isdigit( /*Char*/ $c )
        {
        return( ("0" <= $c) && ($c <= "9") );
        }
    
    function isHexDigit( /*Char*/ $c )
        {
        return( $this->isDigit( $c ) || (("A" <= $c) && ($c <= "F")) || (("a" <= $c) && ($c <= "f")) );
        }
    
    function isOctalDigit( /*Char*/ $c )
        {
        return( ("0" <= $c) && ($c <= "7") );
        }
    
    function isUnicode( /*Char*/ $c )
        {
        return( utf8_encode( utf8_decode( $c ) ) != $c );
        }
    
    function toSource()
        {
        global $eden;
        $source = $eden->serialize( $this->source );
        $callback = $eden->serialize( $this->_callback );
        return "new buRRRn.eden.GenericParser( $source, $callback )";
        }
    
    }

?>