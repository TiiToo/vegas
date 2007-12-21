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
include_once( "GenericParser.php" );

class ECMAScript extends GenericParser
    {
    
    var $_ORC;
    var $inAssignement;
    var $source;
    var $scope;
    
    function ECMAScript( /*String*/ $source, /*String*/ $scope=null, /*String*/ $callback=null )
        {
        parent::GenericParser( $source, $callback );
        
        if( is_null( $scope ) )
            {
            $scope =& $GLOBALS;
            }
        else
            {
            $scope =& $GLOBALS[ $scope ];
            }
        
        $this->_ORC          = $this->_UTF16toUTF8( chr(hexdec("FF")) . chr(hexdec("FC")) );;
        $this->scope         =& $scope;
        $this->inAssignement = false;
        }
    
    function runeval()
        {
        global $config;
        
        $value = $config->undefineable;
        
        while( $this->hasMoreChar() )
            {
            $this->next();
            $this->scanSeparators();
            
            $tmp = $this->scanValue();
            
            if( $tmp !== $this->_UTF8toUTF16( $this->_ORC ) )
                {
                $value = $tmp;
                }
            
            /* note: poor man semicolon auto-insertion */
            if( $this->ch == " ")
                {
                $this->ch = ";";
                }
            }
        
        $this->onParsed();
        
        if( $value === $this->_ORC )
            {
            return $config->undefineable;
            }
        
        return $value;
        }
    
    function evaluate( /*String*/ $source, /*Object*/ $scope=null, /*String*/ $callback=null )
        {
        $parser = new ECMAScript( $source, $scope, $callback );
        return $parser->runeval();
        }
    
    function isOctalNumber( /*String*/ $num )
        {
        
        if( strpos( $num, "." ) ||
            strpos( $num, "e" ) ||
            strpos( $num, "E" ) )
            {
            return false;
            }
        
        for( $i=0; $i<strlen($num); $i++ )
            {
            if( !$this->isOctalDigit( $num{$i} ) )
                {
                return false;
                }
            }
        
        return true;
        }
    
    function isIdentifierStart( /*Char*/ $c )
        {
        if( $this->isAlpha( $c ) || ($c == "_") || ($c == "\$" ) )
            {
            return true;
            }
        
        if( chr($c) < 128 )
            {
            return false;
            }
        
        return false;
        }
    
    function isIdentifierPart( /*Char*/ $c )
        {
        if( $this->isIdentifierStart( $c ) )
            {
            return true;
            }
        
        if( $this->isDigit( $c ) )
            {
            return true;
            }
        
        if( chr( $c ) < 128 )
            {
            return false;
            }
        
        return false;
        }
    
    function isLineTerminator( /*Char*/ $c )
        {
        //trace( "isLineTerminator( $c )" );
        switch( $c )
            {
            case "\x0A": case "\x0D":
            return true;
            
            default:
            return false;
            }
        
        }
    
    function isReservedKeyword( /*String*/ $identifier )
        {
        //trace( "isReservedKeyword( $identifier )" );
        global $config, $strings;
        
        if( !$config->strictMode )
            {
            $identifier = strtolower( $identifier );
            }
        
        switch( $identifier )
            {
            case "break":
            case "case": case "catch": case "continue":
            case "default": case "delete": case "do":
            case "else":
            case "finally": case "for": case "function":
            case "if": case "in": case "instanceof":
            case "new":
            case "return":
            case "switch":
            case "this": case "throw": case "try": case "typeof":
            case "var": case "void":
            case "while": case "with":
            $this->log( sprintf( $strings->reservedKeyword, $identifier ) );
            return true;
            
            default:
            return false;
            }
        }
    
    function isFutureReservedKeyword( /*String*/ $identifier )
        {
        //trace( "isFutureReservedKeyword( $identifier )" );
        global $config, $strings;
        
        if( !$config->strictMode )
            {
            $identifier = strtolower( $identifier );
            }
        
        switch( $identifier )
            {
            case "abstract":
            case "boolean": case "byte":
            case "char": case "class": case "const":
            case "debugger": case "double":
            case "enum": case "export": case "extends":
            case "final": case "float":
            case "goto":
            case "implements": case "import": case "int": case "interface":
            case "long":
            case "native":
            case "package": case "private": case "protected": case "public":
            case "short": case "static": case "super": case "synchronized":
            case "throws": case "transient":
            case "volatile":
            $this->log( sprintf( $strings->futurReservedKeyword, $identifier ) );
            return true;
            
            default:
            return false;
            }
        }
    
    function isValidPath( /*String*/ $path )
        {
        //trace( "isValidPath( $path )" );
        global $strings;
        
        if( strpos( $path, "." ) )
            {
            $paths = explode( ".", $path );
            }
        else
            {
            $paths = array( $path );
            }
        
        for( $i=0; $i<count($paths); $i++ )
            {
            $subpath = $paths[$i];
            
            if( $this->isReservedKeyword( $subpath ) ||
                $this->isFutureReservedKeyword( $subpath ) )
                {
                $this->log( sprintf( $strings->notValidPath, $path ) );
                return false;
                }
            }
        
        return true;
        }
    
    function doesExistInGlobal( /*String*/ $path )
        {
        //trace( "doesExistInGlobal( $path )" );
        $scope = $GLOBALS;
        
        if( strpos( $path, "." ) )
            {
            $paths = explode( ".", $path );
            }
        else
            {
            $paths = array( $path );
            }
        
        for( $i=0; $i<count($paths); $i++ )
            {
            $subpath = $paths[$i];
            
            if( is_array($scope))
                {
                if( !isset( $scope[$subpath] ) )
                    {
                    return false;
                    }
                
                $scope = $scope[$subpath];
                }
             else if( is_object($scope) )
                {
                if( !isset( $scope->$subpath ) )
                    {
                    return false;
                    }
                
                $scope = $scope->$subpath;
                }
            
            }
        
        return true;
        }
    
    function createPath( /*String*/ $path )
        {
        //trace( "createPath( $path )" );
        $scope =& $this->scope;
        
        if( strpos( $path, "." ) )
            {
            $paths = explode( ".", $path );
            }
        else
            {
            $paths = array( $path );
            }
        
        //trace( "path = [".implode( $paths, "," )."]" );
        
        for( $i=0; $i<count($paths); $i++ )
            {
            $path = $paths[$i];
            //trace( gettype($scope) );
            
            if( is_array($scope) )
                {
                //trace( "scope is arr" );
                if( !isset( $scope[$path] ) )
                    {
                    $scope[ $path ] = new stdClass();
                    }
                
                $scope =& $scope[$path];
                }
            else if( is_object($scope) )
                {
                //trace( "scope is obj" );
                if( !isset( $scope->$path ) )
                    {
                    //trace( "scope->".$path );
                    $scope->$path = new stdClass();
                    }
                
                $scope =& $scope->$path;
                }
            
            }
        
        }
    
    function scanComments()
        {
        //trace( "scanComments()" );
        global $strings;
        
        $this->next();
        
        switch( $this->ch )
            {
            case "/":
            while( !$this->isLineTerminator( $this->ch ) )
                {
                $this->next();
                }
            break;
            
            case "*":
            $ch_ = $this->next();
            
            
            while( ($ch_ != "*") && ($this->ch != "/") )
                {
                $ch_ = $this->ch;
                $this->next();
                
                if( $this->ch == "" )
                    {
                    $this->log( $strings->unterminatedComment );
                    break;
                    }
                }
            
            $this->next();
            unset( $ch_ );
            break;
            
            case "":
            default:
            $this->log( $strings->errorComment );
            }
        }
    
    function scanWhiteSpace()
        {
        //trace( "scanWhiteSpace()" );
        $scan = true;
        
        while( $scan )
            {
            switch( $this->ch )
                {
                case "\x09": case "\x0B": case "\x0C": case "\x20": case "\xA0":
                $this->next();
                break;
                
                case "/":
                $this->scanComments();
                break;
                
                default:
                $scan = false;
                }
            }
        }
    
    function scanSeparators()
        {
        //trace( "scanSeparators()" );
        $scan = true;
        
        while( $scan )
            {
            switch( $this->ch )
                {
                case "\x09": case "\x0B": case "\x0C": case "\x20": case "\xA0":
                $this->next();
                break;
                
                case "\x0A": case "\x0D":
                $this->next();
                break;
                
                case "/":
                $this->scanComments();
                break;
                
                default:
                $scan = false;
                }
            }
        }
    
    function scanIdentifier()
        {
        //trace( "scanIdentifier()" );
        global $strings;
        $id = "";
        
        if( $this->isIdentifierStart( $this->ch ) )
            {
            $id .= $this->ch;
            $this->next();
            
            while( $this->isIdentifierPart( $this->ch ) )
                {
                $id .= $this->ch;
                $this->next();
                }
            }
        else
            {
            $this->log( $strings->errorIdentifier );
            }
        
        return $id;
        }
    
    function scanPath()
        {
        //trace( "scanPath()" );
        $path = "";
        
        if( $this->isIdentifierStart( $this->ch ) )
            {
            $path .= $this->ch;
            $this->next();
            
            while( $this->isIdentifierPart( $this->ch ) || ($this->ch == ".") )
                {
                $path .= $this->ch;
                $this->next();
                }
            }
        
        if( strpos( $path, "_global." ) === 0 )
            {
            $path = substr( $path, strlen("_global.") );
            }
        
        return $path;
        }
    
    function _getClassName( $path )
        {
        if( strpos( $path, "." ) )
            {
            $names     = explode( ".", $path );
            $classname = array_pop( $names );
            }
        else
            {
            $classname = $path;
            }
        
        return $classname;
        }
    
    function _loadClass( $path )
        {
        global $eden, $config;
        $packagesRepository = $eden->getRepository();
        $classname = $this->_getClassName( $path );
        $sep = $config->directorySeparator;
        $ext = $config->classFileExtensions;
        
        if( strpos( $path, "." ) )
            {
            $path = str_replace( ".", $sep, $path );
            }
        
        $fullpath = $packagesRepository.$path.$ext;
        
        if( file_exists( $fullpath ) )
            {
            include_once( $fullpath );
            }
        
        return in_array( $classname, get_declared_classes() );
        }
    
    function scanConstructor()
        {
        //trace( "scanConstructor()" );
        global $config;
        global $strings;
        
        $this->scanWhiteSpace();
        
        $ctor = $this->scanPath();
        $args = array();
        
        if( $this->ch == "(" )
            {
            $this->next();
            $this->scanSeparators();
            
            while( $this->ch != "" )
                {
                
                if( $this->ch == ")" )
                    {
                    $this->next();
                    break;
                    }
                
                array_push( $args, $this->scanValue() );
                $this->scanSeparators();
                
                if( $this->ch == "," )
                    {
                    $this->next();
                    $this->scanSeparators();
                    }
                }
            }
        
        if( !$this->isReservedKeyword( $ctor ) &&
            !$this->isFutureReservedKeyword( $ctor ) )
            {
            $ctorObj = $this->_loadClass( $ctor );
            
            if( $ctorObj )
                {
                $ctorName = $this->_getClassName( $ctor );
                global $$ctorName;
                }
            
            }
        else
            {
            $this->log( sprintf( $strings->notValidConstructor, $ctor ) );
            return $config->undefineable;
            }
        
        if( !$ctorObj )
            {
            $this->log( sprintf( $strings->doesNotExist, $ctor ) );
            return $config->undefineable;
            }
        else
            {
            switch( count($args) )
                {
                case 9:
                return new $ctorName( $args[0], $args[1], $args[2], $args[3], $args[4], $args[5], $args[6], $args[7], $args[8] );
                case 8:
                return new $ctorName( $args[0], $args[1], $args[2], $args[3], $args[4], $args[5], $args[6], $args[7] );
                case 7:
                return new $ctorName( $args[0], $args[1], $args[2], $args[3], $args[4], $args[5], $args[6] );
                case 6:
                return new $ctorName( $args[0], $args[1], $args[2], $args[3], $args[4], $args[5] );
                case 5:
                return new $ctorName( $args[0], $args[1], $args[2], $args[3], $args[4] );
                case 4:
                return new $ctorName( $args[0], $args[1], $args[2], $args[3] );
                case 3:
                return new $ctorName( $args[0], $args[1], $args[2] );
                case 2:
                return new $ctorName( $args[0], $args[1] );
                case 1:
                return new $ctorName( $args[0] );
                case 0:
                default:
                return new $ctorName();
                }
            }
        
        $this->log( $strings->errorConstructor );
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
    
    function scanString( /*String*/ $quote )
        {
        //trace( "scanString( $quote )" );
        global $strings;
        
        $str = "";
        
        if( $this->ch == $quote )
            {
            while( !is_null($this->next()) )
                {
                
                switch( $this->ch )
                    {
                    case $quote:
                    $this->next();
                    return $str;
                    
                    case "\\":
                    
                    switch( $this->next() )
                        {
                        case "b": //backspace       - \u0008
                        $str .= "\b";
                        break;
                        
                        case "t": //horizontal tab  - \u0009
                        $str .= "\t";
                        break;
                        
                        case "n": //line feed       - \u000A
                        $str .= "\n";
                        break;
                        
                        /* TODO: check \v bug */
                        case "v": //vertical tab    - \u000B
                        $str .= "\v";
                        break;
                        
                        case "f": //form feed       - \u000C
                        $str .= "\f";
                        break;
                        
                        case "r": //carriage return - \u000D
                        $str .= "\r";
                        break;
                        
                        case "\"": //double quote   - \u0022
                        $str .= "\"";
                        break;
                        
                        case "\'": //single quote   - \u0027
                        $str .= "\'";
                        break;
                        
                        case "\\": //backslash      - \u005c
                        $str .= "\\";
                        break;
                        
                        case "u": //unicode escape sequence \uFFFF
                        $ucode      = substr( $this->source, $this->pos+1, 4 );
                        $utf16a     = chr( hexdec( substr( $ucode, 0, 2) ) );
                        $utf16b     = chr( hexdec( substr( $ucode, 2, 2) ) );
                        
                        $str       .= $this->_UTF16toUTF8( $utf16a . $utf16b );
                        $this->pos += 4;
                        break;
                        
                        case "x": //hexadecimal escape sequence \xFF
                        $xcode      = substr( $this->source, $this->pos+1, 2 );
                        $utf8       = chr( hexdec( $xcode ) );
                        
                        $str       .= $utf8;
                        $this->pos += 2;
                        break;
                        
                        default:
                        $str .= $this->ch;
                        }
                    break;
                    
                    default:
                    if( !$this->isLineTerminator( $this->ch ) )
                        {
                        $str .= $this->ch;
                        }
                    else
                        {
                        $this->log( $strings->errorLineTerminator );
                        }
                    }
                
                }
            }
        
        $this->log( $strings->errorString );
        }
    
    function scanArray()
        {
        //trace( "scanArray()" );
        global $strings;
        
        $arr = array();
        
        if( $this->ch == "[" )
            {
            $this->next();
            $this->scanSeparators();
            
            if( $this->ch == "]" )
                {
                $this->next();
                return $arr;
                }
            
            while( $this->ch != "" )
                {
                array_push( $arr, $this->scanValue() );
                $this->scanSeparators();
                
                if( $this->ch == "]" )
                    {
                    $this->next();
                    return $arr;
                    }
                else if( $this->ch != "," )
                    {
                    break;
                    }
                
                $this->next();
                $this->scanSeparators();
                }
            }
        
        $this->log( $strings->errorArray );
        }
    
    function scanObject()
        {
        //trace( "scanObject()" );
        global $strings;
        
        $obj = new stdClass();
        
        if( $this->ch == "{" )
            {
            $this->next();
            $this->scanSeparators();
            
            if( $this->ch == "}" )
                {
                $this->next();
                return $obj;
                }
            
            while( $this->ch != "" )
                {
                $member = $this->scanIdentifier();
                $this->scanWhiteSpace();
                
                if( $this->ch != ":" )
                    {
                    break;
                    }
                
                $this->next();
                $value =& $this->scanValue();
                
                if( !$this->isReservedKeyword( $member ) &&
                    !$this->isFutureReservedKeyword( $member ) )
                    {
                    $obj->$member = $value;
                    }
                
                $this->scanSeparators();
                
                if( $this->ch == "}" )
                    {
                    $this->next();
                    return $obj;
                    }
                else if( $this->ch != "," )
                    {
                    break;
                    }
                
                $this->next();
                $this->scanSeparators();
                }
            }
        
        $this->log( $strings->errorObject );
        }
    
    function scanNumber()
        {
        //trace( "scanNumber()" );
        global $strings;
        
        $num  = "";
        $oct  = "";
        $hex  = "";
        $sign = "";
        
        if( $this->ch == "-" )
            {
            $sign = "-";
            $this->next();
            }
        
        if( $this->ch == "0" )
            {
            $this->next();
            
            if( ($this->ch == "x") || ($this->ch == "X") )
                {
                $this->next();
                
                while( $this->isHexDigit( $this->ch ) )
                    {
                    $hex .= $this->ch;
                    $this->next();
                    }
                
                if( $hex == "" )
                    {
                    $this->log( $strings->malformedHexadecimal );
                    return NAN;
                    }
                else
                    {
                    $value = 0 + ("0x".$hex);
                    
                    if( $sign == "-" )
                        {
                        return -$value;
                        }
                    else
                        {
                        return $value;
                        }
                    }
                }
            else
                {
                $num += "0";
                }
            }
        
        while( $this->isDigit( $this->ch ) )
            {
            $num .= $this->ch;
            $this->next();
            }
        
        if( $this->ch == "." )
            {
            $num .= ".";
            
            while( ( (boolean) $this->next() ) && ( $this->isDigit( $this->ch ) ) )
                {
                $num .= $this->ch;
                $this->next();
                }
            }
    
        if( $this->ch == "e" )
            {
            $num .= "e";
            
            while( ( (boolean) $this->next() ) && ( $this->isDigit( $this->ch ) ) )
                {
                $num .= $this->ch;
                $this->next();
                }
            }
        
        if( ($num{0} == "0") && $this->isOctalNumber( $num ) )
            {
            $value = octdec($num);
            }
        else
            {
            $value = 0 + $num;
            }
        
        if( !is_finite( $value ) )
            {
            $this->log( $strings->errorNumber );
            return NAN;
            }
        else
            {
            if( $sign == "-" )
                {
                return -$value;
                }
            else
                {
                return $value;
                }
            }
        }
    
    function scanAssignement( /*String*/ $path )
        {
        //trace( "scanAssignement( $path )" );
        global $strings;
        
        $basescope  =& $this->scope;
        $scope      =& $this->scope;
        
        if( strpos( $path, "." ) )
            {
            $objPath = explode( ".", $path );
            
            for( $i=0; $i<count($objPath); $i++ )
                {
                $path = $objPath[$i];
                
                if( $i == count($objPath)-1 )
                    {
                    break;
                    }
                
                //trace( gettype($scope) );
                
                if( is_array($scope) )
                    {
                    //trace( "scope is arr" );
                    if( !isset( $scope[$path] ) )
                        {
                        $scope[ $path ] = new stdClass();
                        }
                    
                    $scope =& $scope[$path];
                    }
                else if( is_object($scope) )
                    {
                    //trace( "scope is obj" );
                    if( !isset( $scope->$path ) )
                        {
                        $scope->$path = new stdClass();
                        }
                    
                    $scope =& $scope->$path;
                    }
                
                }
            }
        
        $this->scanWhiteSpace();
        
        if( $this->ch == "=" )
            {
            $this->inAssignement = true;
            $this->next();
            $this->scanWhiteSpace();
            
            if( $this->isLineTerminator( $this->ch ) )
                {
                /* TODO: check if undefineable value is not preferable here */
                return;
                }
            
            $value = $this->scanValue();
            if( is_array($scope) )
                {
                //trace( "scope is arr2" );
                $scope[$path] = $value;
                }
            else if( is_object($scope) )
                {
                //trace( "scope is obj2" );
                $scope->$path = $value;
                }
            
            $this->inAssignement = false;
            }
        
        //global $eden;
        //trace( $eden->serialize( $scope ) );
        
        $this->scope =& $basescope;
        //trace( $eden->serialize( $this->scope ) );
        }
    
    function scanExternalReference( /*String*/ $path )
        {
        //trace( "scanExternalReference( $path )" );
        global $strings;
        global $config;
        
        $check = false;
        $sign  = "";
        
        switch( $path{ 0 } )
            {
            case "-":
            $sign = "-";
            $path = substr( $path, 1 );
            break;
            
            case "+":
            $path = substr( $path, 1 );
            break;
            }
        
        $check = $this->doesExistInGlobal( $path );
        
        if( $check )
            {
            $paths = explode( ".", $path );
            
            for( $i=0; $i<count($paths); $i++ )
                {
                $cpath = $paths[$i];
                
                if( $i == 0 )
                    {
                    if( $config->copyObjectByValue )
                        {
                        $valueTest = $GLOBALS[ $cpath ];
                        //global $$cpath;
                        }
                    else
                        {
                        $valueTest = $GLOBALS[ $cpath ];
                        //$valueTest =& $$cpath;
                        }
                    
                    continue;
                    }
                
                if( $config->copyObjectByValue )
                    {
                    $valueTest = $valueTest->$cpath;
                    }
                else
                    {
                    $valueTest = $valueTest->$cpath;
                    }
                }
            
            //echo "valueTest = ".$valueTest;
            //$valueTest = eval( "_global." + $path );
            
            if( isset($valueTest) )
                {
//                 if( $config->copyObjectByValue && (gettype( $valueTest ) == "object") )
//                     {
//                     $valueTest = valueTest.copy();
//                     }
                
                if( $sign == "-" )
                    {
                    return -$valueTest;
                    }
                
                return $valueTest;
                }
            }
        
        $this->log( sprintf( $strings->extRefDoesNotExist, $path ) );
        return $config->undefineable;
        }
    
    function scanKeyword( /*String*/ $pre="" )
        {
        //trace( "scanKeyword()" );
        global $strings;
        global $config;
        
        $baseword = $this->scanPath();
            $word = $pre . $baseword;
        
        if( empty($word) )
            {
            return $this->_ORC;
            }
        
        switch( $word )
            {
            case "":
            case "_global":
            case "undefined":
            return $config->undefineable;
            
            // Null literal
            case "null":
            return null;
            
            // Boolean literals
            case "true":
            return true;
            
            case "false":
            return false;
            
            // Number literals
            case "NaN":
            return NAN;
            
            case "new":
            return $this->scanConstructor();
            
            default:
            $value = $this->_ORC;
            
            /* coded in the train listening RUN-DMC "It's Tricky" ;) */
            if( !$this->doesExistInGlobal( $baseword ) )
                {
                if( $this->isValidPath( $baseword ) )
                    {
                    $this->createPath( $baseword );
                    }
                else
                    {
                    return $config->undefineable;
                    }
                }
            else
                {
                if( $config->copyObjectByValue )
                    {
                    $externalReference = $this->scanExternalReference( $word );
                    }
                else
                    {
                    $externalReference = $this->scanExternalReference( $word );
                    }
                
                if( ($externalReference != $config->undefineable) && $this->inAssignement )
                    {
                    return $externalReference;
                    }
                }
            
            if( !$this->inAssignement )
                {
                $this->scanAssignement( $baseword );
                }
            
            return $config->undefineable;
            }
        
        $this->log( $strings->errorKeyword );
        }
    
    function scanValue()
        {
        //trace( "scanValue()" );
        $this->scanWhiteSpace();
        
        switch( $this->ch )
            {
            case "{":
            return $this->scanObject();
            
            case "[":
            return $this->scanArray();
            
            case "\"": case "'":
            return $this->scanString( $this->ch );
            
            case "-": case "+":
            if( $this->isDigit( $this->source{ $this->pos } ) )
                {
                return $this->scanNumber();
                }
            else
                {
                $ch_ = $this->ch;
                $this->next();
                return $this->scanKeyword( $ch_ );
                }
            
            default:
            return $this->isDigit( $this->ch ) ? $this->scanNumber() : $this->scanKeyword();
            }
        }
    
    }

?>