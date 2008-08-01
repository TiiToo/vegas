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

package system.evaluators
{
    import buRRRn.eden;    

    /**
     * Evaluates eden expression.
     */
    public class EdenEvaluator implements Evaluable
        {

        /**
         * @private
         */        
        private var _serialized:Boolean;

        /**
         * Creates a new EdenEvaluator instance.
         * @param serialized An optional flag who indicates if the result of the eval must be serialized or not.
         */
        public function EdenEvaluator( serialized:Boolean = true )
            {
            _serialized = serialized;
            }
        
        /**
         * Evaluates the specified object.
         */
        public function eval(o:*):*
            {
            var result:* = eden.deserialize( o );
            
            if( _serialized )
                {
                return eden.serialize( result );
                }
            else
                {
                return result;
                }
            }
        
        }
    }

