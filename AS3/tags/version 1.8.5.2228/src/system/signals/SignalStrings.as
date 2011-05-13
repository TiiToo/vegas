﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.signals 
{
    /**
     * The enumeration of all string expressions in the Signal engine.
     */
    public class SignalStrings 
    {
        /**
         * This pattern is used in the signals to notify an invalid type.
         */
        public static var INVALID_PARAMETER_TYPE:String = "The parameter with the index {0} in the emit method isn't valid, must be an instance of the {1} class but is an instance of the {2} class." ;
        
        /**
         * This pattern is used in the signals to notify an invalid number of parameters.
         */
        public static var INVALID_PARAMETERS_LENGTH:String = "The number of arguments in the emit method is not valid, must be invoked with {0} argument(s) and you call it with {1} argument(s)." ;
        
        /**
         * This pattern is used to indicates if the types argument is not valid (must contains only Class references).
         */
        public static var INVALID_TYPES:String = "Invalid types representation, the Array of types failed at index {0} should be a Class but was:\"{1}\"." ;
    }
}
