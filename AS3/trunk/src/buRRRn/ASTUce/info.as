
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.ASTUce
    {
    import system.Version;
    import system.Console;
    import system.Serializer;
     
    /* Function: info
       basic system info
    */
    public function info( verbose:Boolean = false, showConfig:Boolean = false ):void
        {
        var separator:String = "----------------------------------------------------------------";
        var CRLF:String      = "\n";
        var name:String      = "ASTUce";
        var fullname:String  = "ActionScript Test Unit compact edition AS3";
        var version:Version  = new Version( 0, 8 );
            version.revision = parseInt( "$Rev: 12 $".split( " " )[1] );
        
        var copyright:String = "Copyright © 2006-2007 Zwetan Kjukov, All right reserved.";
        var origin:String    = "Made in the EU.";
        
        /*
        if( config.verbose )
            {
            str += name + ": " + fullName + " " + ext + " v" + version;
            }
        else
            {
            str += name + " " + ext + " v" + version;
            }
        
        if( config.verbose )
            {
            str += CRLF;
            str += "Copyright © 2006-2007 Zwetan Kjukov, All right reserved." + CRLF;
            str += "Made in the EU.";
            }
        
        return str;
        */
        
        var str:String = "";
            if( !verbose && config.verbose )
                {
                verbose = true;
                }
            
            if( verbose ) {
            str += "{sep}{crlf}";
            str += "{name}: {fullname} v{version}{crlf}";
            str += "{copyright}{crlf}";
            str += "{origin}{crlf}";
            str += "{sep}";
            } else {
            str += "{name} v{version}{crlf}";
            str += "{sep}";
             }
            
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
                           copyright:copyright,
                           origin:origin,
                           config: Serializer.serialize( config )
                           }
                         );
        
        }
    
    }

