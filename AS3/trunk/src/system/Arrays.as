﻿/*
  
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
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2006)
	  Use this version only with Vegas AS3 Framework Please.

*/
package system
{
	
    /**
	 * Array static tool class.
	 */
	public dynamic class Arrays extends Array
	{
		
		/**
		 * Creates a new Arrays instance.
		 * @param numElements The number of elements in the specified Array.
		 */
		public function Arrays( numElements:int = 0 )
		{
			super( numElements );
		}

		/**
		 * Initializes a new Array with an arbitrary number of elements (index), 
		 * with every element containing the passed parameter value or by default the null value.
		 * <p><b>Example :</b></p>
		 * {@code
		 * var test:Array  = Arrays.initialize( 3 ); //define [null,null,null]
		 * var test1:Array = Arrays.initialize( 3, 0 ); //define [0,0,0]
		 * var test2:Array = Arrays.initialize( 3, true ); //define [true,true,true]
		 * var test3:Array = Arrays.initialize( 3, "" ); //define ["","",""]
		 * }
		 */
		public static function initialize( elements:int = 0, value:* = null ):Array
		{
			var arr:Array = [];
			for( var i:int = 0; i < elements ; i++ )
			{
				arr.push( value );
			}
            
			return arr;
		}
        
        _dontEnumPrototype( prototype );

	}

}

