﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.draw
{

	/**
	 * This interface defines a graphic object or component with a direction.
	 */
	public interface Directionable 
    {

        /**
         * Indicates the direction value of this object ("horizontal" or "vertical").
         * @see pegas.draw.Direction
         */
        function get direction():String ;
        
        /**
         * @private
         */
        function set direction( value:String ):void ;
        
    }
}
