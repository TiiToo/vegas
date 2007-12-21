<?php

/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is edenRR: eden Ridge Racer PHP. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

include_once( "ModeOption.php" );
include_once( "EncryptionType.php" );
include_once( "EncodingType.php" );

class Packet
    {
    
    var $_AuthKey;
    var $_SecureKey;
    
    var $separator;
    
    var $protocol;
    var $mode;
    var $authKey;
    var $version;
    var $encryption;
    var $encoding;
    var $data;
    
    function Packet( /*String*/ $data="", /*int*/ $encoding=null,
                     /*Boolean*/ $authKey=false, /*int*/ $encryption=null )
        {
        global $EncodingType, $EncryptionType, $ModeOption;
        
        $this->_AuthKey   = "";
        $this->_SecureKey = "";
        
        if( is_null($encoding) )
            {
            $encoding = $EncodingType->raw;
            }
        
        if( is_null($encryption) )
            {
            $encryption = $EncryptionType->none;
            }
        
        $this->separator = "|";
        
        $this->protocol   = "ed";
        $this->mode       = $ModeOption->code;
        $this->authKey    = $authKey;
        $this->version    = 0;
        $this->encryption = $encryption;
        $this->encoding   = $encoding;
        $this->data       = $data;
        }
    
    function getHeader()
        {
        $header  = "0x";
        $header .= $this->protocol;
        
        $options = (0 << 3) | (0 << 2) | ($this->authKey << 1) | ($this->mode);
        $header .= (string) $options;
        $header .= (string) $this->version;
        $header .= (string) $this->encryption;
        $header .= (string) $this->encoding;
        
        return $header;
        }
    
    function setAuthKey( $key )
        {
        $this->_AuthKey = $key;
        }
    
    function getAuthKey()
        {
        if( !is_null($this->_AuthKey) && !empty($this->_AuthKey) )
            {
            return $this->_AuthKey;
            }
        
        global $AuthKey;
        return $AuthKey;
        }
    
    function setSecureKey( $key )
        {
        $this->_SecureKey = $key;
        }
    
    function getSecureKey()
        {
        if( !is_null($this->_SecureKey) && !empty($this->_SecureKey) )
            {
            return $this->_SecureKey;
            }
        
        global $SecureKey;
        return $SecureKey;
        }
    
    function isEmpty()
        {
        return( strlen($this->data) == 0 );
        }
    
    function sendOnError( $callback=null, $message="" )
        {
        if( is_null($callback) )
            {
            return;
            }
        
        call_user_func_array( array( $callback, "onPacketError" ), array( $message ) );
        }
    
    function parse( $encodedPacket="", $callback=null, $extAuthKey=null, $extSecureKey=null )
        {
        global $EncodingType, $EncryptionType;
        $pos    = strpos( $encodedPacket, "|" );
        if( $pos == false )
            {
            //trace( "packet have no header" );
            Packet::sendOnError( $callback, "packet have no header" );
            return null;
            }
        
        $header = substr( $encodedPacket, 0, $pos );
        //trace( "header:" . $header );
        $header = 0 + $header;
        $protocol = (($header & 0xff0000) >> 16);
        //trace( "protocol:" . dechex($protocol) );
        $options  = (($header & 0x00f000) >> 12);
        $_mode    = ($options & 1);
        //trace( "mode:" . $_mode );
        $_authKey = ($options & 2) >> 1;
        //trace( "authKey:" . $_authKey );
        
        if( $_authKey )
            {
            $header2   = substr( $encodedPacket, $pos+1 );
            //echo "[".$header2."]";
            $pos       = strpos( $header2, "|" );
            $myAuthKey = substr( $header2, 0, $pos );
            $encodedPacket = $header2;
            //trace( "myAuthKey:" . $myAuthKey );
            }
        
        $version = (($header & 0x000f00) >> 8);
        //trace( "version:" . $version );
        $encryption = (($header & 0x0000f0) >> 4);
        //trace( "encryption:" . $encryption );
        $encoding = ($header & 0x00000f);
        //trace( "encoding:" . $encoding );
        
        $header3 = substr( $encodedPacket, $pos+1 );
        $pos     = strpos( $header3, "|" );
        $pdata   = substr( $header3, $pos );
        //trace( "data:" . $pdata );
        
        $edenPacket = new Packet();
        
        if( !is_null($extAuthKey) )
            {
            $edenPacket->setAuthKey( $extAuthKey );
            }
        
        if( !is_null($extSecureKey) )
            {
            $edenPacket->setSecureKey( $extSecureKey );
            }
        
        if( ($edenPacket->protocol == dechex($protocol)) &&
            ($edenPacket->version  == $version)
          )
            {
            //trace( "packet is valid" );
            
            if( $_authKey )
                {
                if( $myAuthKey == $edenPacket->getAuthKey() )
                    {
                    //trace( "packet authKey is valid" );
                    $packet->authKey = $_authKey;
                    }
                else
                    {
                    //trace( "packet authKey is NOT valid" );
                    Packet::sendOnError( $callback, "packet authKey is not valid" );
                    return null;
                    }
                }
            
            switch( $encoding )
                {
                case $EncodingType->raw:
                break;
                
                case $EncodingType->base64:
                $pdata = base64_decode( $pdata );
                break;
                }
            $edenPacket->encoding = $encoding;
            
            switch( $encryption )
                {
                case $EncryptionType->none:
                break;
                
                case $EncryptionType->tea:
                $tea = new TEA();
                $pdata = $tea->decrypt( $pdata, $edenPacket->getSecureKey() );
                if( strpos( $pdata, "TEA" ) === 0 )
                    {
                    //trace( "packet encryption is valid" );
                    $pdata = substr( $pdata, strlen("TEA") );
                    }
                else
                    {
                    //trace( "packet encryption is NOT valid" );
                    //trace( "invalid data:" . $pdata );
                    Packet::sendOnError( $callback, "packet TEA encryption is not valid" );
                    $pdata = "";
                    }
                break;
                }
            $edenPacket->encryption = $encryption;            
            
            //trace( "data:" . $pdata );
            $edenPacket->data = $pdata;
            return $edenPacket;
            }
        
        //trace( "packet is not valid" );
        Packet::sendOnError( $callback, "packet is not valid" );
        return null;
        }
    
    function toString()
        {
        global $EncryptionType, $EncodingType;
        $packet = array( $this->getHeader() );
        $data   = $this->data;
        
        if( $this->authKey )
            {
            array_push( $packet, $this->getAuthKey() );
            }
        
        switch( $this->encryption )
            {
            case $EncryptionType->none:
            break;
            
            case $EncryptionType->tea:
            $tea  = new TEA();
            $data = $tea->encrypt( "TEA" . $data, $this->getSecureKey() );
            break;
            }
        
        switch( $this->encoding )
            {
            case $EncodingType->raw:
            break;
            
            case $EncodingType->base64:
            $data = base64_encode( $data );
            break;
            }
        
        array_push( $packet, $data );
        return implode( $packet, $this->separator );
        }
    
    }
?>