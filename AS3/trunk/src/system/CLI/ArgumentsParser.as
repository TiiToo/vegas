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
  
*/

package system.CLI
    {
    
    /* Parse command line arguments.
       
       ex:
       my.exe -h
       my.exe /?
       my.exe -s -T:hello myfile.txt
       my.exe myfile1.txt myfile2.txt
       
       note:
       we don't want to use events for Tamarin compatibility.
    */
    public class ArgumentsParser
        {
        
        private var _switchSymbols:Array;
        private var _caseSensitive:Boolean;
        private var _switchChars:Array = [ "/", "-" ];
        
        public function ArgumentsParser( switchSymbols:Array,
                                         caseSensitive:Boolean = false,
                                         switchChars:Array = null )
            {
            _switchSymbols = switchSymbols;
            _caseSensitive = caseSensitive;
            
            if( switchChars != null )
                {
                _switchChars   = switchChars ;
                }
            }
        
        /* Method: onUsage
           Used to display the usage string when an error occurs.
           Need to be overrided.
        */
        public function onUsage( errorInfo:String = "" ):void
            {
            
            }
        
        /* Method: onSwitch
           Need to be overrided.
        */
        public function onSwitch( symbol:String, value:String ):SwitchStatus
            {
            return SwitchStatus.error;
            }
        
        /* Method: onNonSwitch
           Need to be overrided.
        */
        public function onNonSwitch( value:String ):SwitchStatus
            {
            return SwitchStatus.error;
            }
        
        /* Method: onParsed
           Need to be overrided.
        */
        public function onParsed():SwitchStatus
            {
            return SwitchStatus.error;
            }
        
        /* Method: parse
        */
        public function parse( args:Array ):Boolean
            {
            var slots:Array         = args;
            var status:SwitchStatus = SwitchStatus.noError;
            
            var num:int;
            var isSwitch:Boolean = false;
            var isLegal:Boolean  = false;
            var switchIndex:int;
            var symbol:String;
            var value:String;
            
            var containSwitch:Function = function( element:String, index:int, array:Array ):Boolean
                {
                if( element == slots[num].charAt( 0 ) )
                    {
                    return true;
                    }
                
                return false;
                };
            
            var containLegalSwitch:Function = function( element:String, index:int, array:Array ):Boolean
                {
                var value:String = slots[num].charAt( 1 );
                
                if( !_caseSensitive )
                    {
                    element = element.toLowerCase();
                    value   = value.toLowerCase();
                    }
                
                if( element == value )
                    {
                    switchIndex = index;
                    return true;
                    }
                
                return false;
                };
            
            
            for( num = 0; (status == SwitchStatus.noError) && (num < slots.length); num++ )
                {
                isSwitch = _switchChars.some( containSwitch );
                
                if( isSwitch )
                    {
                    isLegal = _switchSymbols.some( containLegalSwitch );
                    
                    if( !isLegal )
                        {
                        status = SwitchStatus.error;
                        break;
                        }
                    else
                        {
                        symbol = _switchSymbols[switchIndex];
                        value  = slots[num].substring( 1 + symbol.length );
                        status = this.onSwitch( _caseSensitive ? symbol: symbol.toLowerCase() , value );
                        }
                    
                    }
                else
                    {
                    status = this.onNonSwitch( slots[num] );
                    }
                
                }
            
            
            if( status == SwitchStatus.noError )
                {
                status = this.onParsed();
                }
            
            if( status == SwitchStatus.showUsage )
                {
                this.onUsage();
                }
            
            if( status == SwitchStatus.error )
                {
                this.onUsage( (num == slots.length) ? "": slots[num] );
                }
            
            return status == SwitchStatus.noError;
            }
        
        }
    
    }

