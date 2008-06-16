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
  Marc Alcaraz <ekameleon@gmail.com>.

*/

package system.reflection
    {
    
    /**
     * This interface defines all method who defines the informations about a Type object (Class).
     */
    public interface TypeInfo
        {
        
        /**
         * Indicates if the specified Class object can be convert to an other with the "as" keyword.
         */        
        function canConvertTo( o:Class ):Boolean;
        
        /**
         * Indicates if the specified Class object be used with the "is" keyword.
         */        
        function isSubtypeOf( o:Class ):Boolean;
        
        }
    
    
    }

