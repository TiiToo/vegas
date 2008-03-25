/*

 Diff Match and Patch
 
 The Initial Developer of the Original Code is Neil Fraser <fraser@google.com>
 AS3 version author Alcaraz Marc (aka eKameleon) <ekameleon@gmail.com> (2007-2008).

 Copyright 2006 Google Inc.
 http://code.google.com/p/google-diff-match-patch/
 
 This library is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public
 License along with this library; if not, write to the Free Software
 Foundation, Inc, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA
  
*/
package system.text.utils 
	{

	/**
	 * Class representing one patch operation.
	 * @author eKameleon
	 */
	public class PatchObject 
	{
		
		/**
		 * Creates a new PatchObject instance.
		 */
		public function PatchObject()
		{
			//
		}
		
		/**
		 * The diff Array of this patch object.
		 */
		public var diffs:Array = [];
  		
  		/**
  		 * The first length value.
  		 */
  		public var length1:uint = 0 ;

  		/**
  		 * The second length value.
  		 */
  		public var length2:uint = 0 ;

  		/**
  		 * The first start value.
  		 */
  		public var start1:uint ;

  		/**
  		 * The second start value.
  		 */
  		public var start2:uint ;
		
		/**
 		 * Emmulate GNU diff's format.
 		 * Header: @@ -382,8 +481,9 @@
 		 * Indicies are printed as 1-based, not 0-based.
 		 * @return {string} The GNU diff string
 		 */
		public function toString():String 
		{
  			
  			var coords1:String, coords2:String ;
  			
  			if ( length1 === 0 ) 
  			{
    			coords1 = String(start1) + ',0';
  			} 
  			else if ( length1 == 1 ) 
  			{
    			coords1 = String(start1) + 1 ;
  			} 
  			else 
  			{
    			coords1 = ( start1 + 1 ) + ',' + length1 ;
  			}
  			
  			if ( length2 === 0 ) 
  			{
    			coords2 = String(start2) + ',0' ;
  			} 
  			else if ( length2 == 1 ) 
  			{
    			coords2 = String(start2) + 1;
  			} 
  			else 
  			{
    			coords2 = (start2 + 1) + ',' + length2 ;
  			}
  			
  			var txt:Array = ['@@ -' + coords1 + ' +' + coords2 + ' @@\n'] ;
  			var op:String ;
  			
  			// Escape the body of the patch with %xx notation.
  			
  			var len:uint = diffs.length ;
  			for (var x:uint = 0; x < len ; x++ ) 
  			{
    			switch ( this.diffs[x][0] ) 
    			{
    				case Difference.INSERT :
    				{
      					op = '+';
      					break;
    				}
    				case Difference.DELETE :
    				{
      					op = '-' ;
      					break ;
    				}
    				case Difference.EQUAL :
    				{
      					op = ' ';
      					break;
    				}
    			}
    			txt[x + 1] = op + encodeURI(this.diffs[x][1]) + '\n' ;
  			}
  			
  			return txt.join('').replace(/%20/g, ' ') ;
  			
		}
	}
}
