/*
  
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)

*/
package buRRRn.eden
{
	import buRRRn.eden;
	import buRRRn.eden.config;
	
	import system.Strings;
	import system.Version;    
    
    /**
     * Basic eden info.
     */
    public function info( verbose:Boolean = false, showConfig:Boolean = false ):String
        {
        var separator:String = "----------------------------------------------------------------";
        var CRLF:String      = "\n";
        var name:String      = "eden";
        var fullname:String  = "ECMASCript data exchange notation";
        var version:Version  = new Version( 0, 1 );
            version.revision = parseInt( "$Rev: 87 $".split( " " )[1] );
         
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
            
        return Strings.format( str,
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

