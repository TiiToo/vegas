
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
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.eden
    {
    import system.Version;
    import system.Console;
     
    /* Function: info
       basic eden info
    */
    public function info( verbose:Boolean = false, showConfig:Boolean = false ):void
        {
        var separator:String = "----------------------------------------------------------------";
        var CRLF:String      = "\n";
        var name:String      = "eden";
        var fullname:String  = "ECMASCript data exchange notation";
        var version:Version  = new Version( 0, 1 );
            version.revision = parseInt( "$Rev: 32 $".split( " " )[1] );
        
        var str:String = "";
            if( !verbose && config.verbose )
                {
                verbose = true;
                }
            
            if( verbose ) {
            str += "{sep}{crlf}";
            str += "{name}: {fullname} v{version}{crlf}";
            str += "{sep}";
            } else {
            str += "{name} v{version}"; }
            
            if( showConfig ) {
            str += "{crlf}config:";
            str += "{config}{crlf}";
            str += "{sep}";
            }
            
        Console.writeLine( str,
                           {
                           sep:separator,
                           crlf:CRLF,
                           name:name,
                           fullname:fullname,
                           version:version,
                           config: eden.serialize( config )
                           }
                         );
        
        }
    
    }
