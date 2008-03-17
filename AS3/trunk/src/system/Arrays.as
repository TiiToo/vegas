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
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)
	  Use this version only with Vegas AS3 Framework Please (add spliceArrayInto() method).

*/	 

package system
{
	
    /**
	 * Array static tool class.
	 */
	public class Arrays
	{
		
		/**
		 * Initializes a new Array with an arbitrary number of elements (index), 
		 * with every element containing the passed parameter value or by default the null value.
		 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var test:Array  = Arrays.initialize( 3 ); //define [null,null,null]
		 * var test1:Array = Arrays.initialize( 3, 0 ); //define [0,0,0]
		 * var test2:Array = Arrays.initialize( 3, true ); //define [true,true,true]
		 * var test3:Array = Arrays.initialize( 3, "" ); //define ["","",""]
		 * </pre>
		 * @return a new Array with an arbitrary number of elements (index), 
		 * with every element containing the passed parameter value or by default the null value.
		 */
		public static function initialize( elements:int = 0, value:* = null ):Array
		{
			var arr:Array = [];
			for( var i:int = 0; i < elements ; i++ )
			{
				arr[i] = value ;
			}
			return arr;
		}

		/** 
		 * Splice one array into another.
		 * Like the python 
		 * <pre class="prettyprint">
  		 * container[containerPosition:containerPosition + countReplaced] = inserted
  		 * </pre>
  		 * @example
		 * <pre class="prettyprint">
  		 * import system.Arrays ;
  		 * 
  		 * var inserted:Array  ;
  		 * var container:Array ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * trace( "inserted  : " + inserted  ) ;
  		 * trace( "container : " + container ) ;
  		 * 
  		 * trace("---") ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 0 ) : " + container ) ; // 1,2,3,4,5,6,7,8
  		 * 
  		 * trace("---") ;
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container, 0 , 4 ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4
  		 * 
  		 * trace("---") ;
  		 * 
  		 * inserted  = [1, 2, 3, 4] ;
  		 * container = [5, 6, 7, 8] ;
  		 * 
  		 * Arrays.spliceInto( inserted, container, 0 , 2 ) ;
  		 * trace( "Arrays.spliceInto( inserted, container, 0 , 4 ) : " + container ) ; // 1,2,3,4,7,8
  		 * </pre>
  		 * @param inserted The Array of char inserted in the Array container.
  		 * @param container The container modified in place.
  		 * @param containerPosition The position in the container to inserted the Array of chars.
  		 * @param countReplaced The count value to replaced values.
  		 */
		public static function spliceInto( inserted:Array, container:Array, containerPosition:Number=0 , countReplaced:Number=0 ):void
		{
  			inserted.unshift( containerPosition, isNaN( countReplaced ) ? 0 : countReplaced );
  			try 
  			{
    			container.splice.apply( container, inserted ) ;
  			} 
  			finally 
  			{
    			inserted.splice(0, 2) ;
  			}
		}	

	}

}

