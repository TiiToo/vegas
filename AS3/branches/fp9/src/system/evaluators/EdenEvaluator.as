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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package system.evaluators
{
    import system.eden;
    
    /**
     * Evaluates an eden expression.
     * <pre class="prettyprint">
     * import system.evaluators.* ;
     * var e:EdenEvaluator = new EdenEvaluator(false) ;
     * var result:* = e.eval("new Date(2007,5,12,22,10,5)") ;
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) : Tue Jun 12 22:10:05 GMT+0200 2007
     * </pre>
     */
    public class EdenEvaluator implements Evaluable
    {
        /**
         * @private
         */
        private var _serialized:Boolean;
        
        /**
         * Creates a new EdenEvaluator instance.
         * @param serialized This Boolean flag indicates if the object must be evaluates with a final serialized or not value.
         */
        public function EdenEvaluator( serialized:Boolean = true )
        {
            _serialized = serialized;
        }
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            var result:* = eden.deserialize( o ) ;
            if( _serialized )
            {
                return eden.serialize( result ) ;
            }
            else
            {
                return result;
            }
        }
    }
}