/*
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
    import system.Enum;
    
    /* Enumerate the different switch states.
    */
    public class SwitchStatus extends Enum
        {
        
        public function SwitchStatus( value:int, name:String )
            {
            super( value, name );
            }
        
        public static const noError:SwitchStatus   = new SwitchStatus( 0, "noError" );
        public static const error:SwitchStatus     = new SwitchStatus( 1, "error" );
        public static const showUsage:SwitchStatus = new SwitchStatus( 2, "showUsage" );
        
        }
    
    }

