/*

 Diff Match and Patch
 
 The Initial Developer of the Original Code is Neil Fraser <fraser@google.com>
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
 
 Contributors : AS3 version author Alcaraz Marc (aka eKameleon) <ekameleon@gmail.com> (2007-2008).

*/
package system.text.diff 
{

	/**
	 * Creates a patch with the difference between two texts. 
	 * Applies the patch onto another text, allowing for errors.
	 * @author eKameleon
	 */
	public class Patch 
	{
		
		/**
		 * Chunk size for context length.
		 */
		public static var margin:Number = 4 ;		

		/**
		 * Increases the context until it is unique, but don't let the pattern expand beyond matchMaxBits.
		 * @param patch The patch to grow.
		 * @param text Source text.
		 */
		public static function addContext(patch:PatchObject, text:String):void 
		{
  			var pattern:String = text.substring(patch.start2, patch.start2 + patch.length1);
  			var padding:uint = 0;
  			while (text.indexOf(pattern) != text.lastIndexOf(pattern) && pattern.length < Match.maxBits - margin - margin ) 
  			{
    			padding += margin ;
    			pattern = text.substring(patch.start2 - padding, patch.start2 + patch.length1 + padding);
  			}
  			// Add one chunk for good luck.
  			padding += margin ;
  			// Add the prefix.
  			var prefix:String = text.substring(patch.start2 - padding, patch.start2);
  			if (prefix !== '') 
  			{
    			patch.diffs.unshift([ Difference.EQUAL, prefix]);
  			}
  			// Add the suffix.
  			var suffix:String = text.substring(patch.start2 + patch.length1, patch.start2 + patch.length1 + padding);
  			if (suffix !== '') 
  			{
    			patch.diffs.push([ Difference.EQUAL, suffix]) ;
  			}
			
  			// Roll back the start points.
  			patch.start1 -= prefix.length;
  			patch.start2 -= prefix.length;
  			
  			// Extend the lengths.
  			patch.length1 += prefix.length + suffix.length;
  			patch.length2 += prefix.length + suffix.length;
		}

		/**
		 * Parse a textual representation of patches and return a list of patch objects.
		 * @param textline Text representation of patches
		 * @return Array of patch objects {Array.<patch_obj>} .
		 * @throws Error If invalid input.
		 */
		public static function fromText( textline:String ):Array 
		{
  			var patches:Array    = [] ;
  			var text:Array       = textline.split('\n') ;
  			var textPointer:uint = 0 ;
  			while (textPointer < text.length) 
  			{
	    		var m:Boolean = text[textPointer].match(/^@@ -(\d+),?(\d*) \+(\d+),?(\d*) @@$/) ;
    			if ( !m ) 
    			{
	      			throw new Error('Invalid patch string: ' + text[textPointer]) ;
    			}
    			var patch:PatchObject = new PatchObject() ; 
    			patches.push(patch) ;
    			patch.start1 = parseInt(m[1], 10) ;
    			if (m[2] === '') 
    			{
	      			patch.start1-- ;
      				patch.length1 = 1 ;
    			} 
    			else if (m[2] == '0') 
    			{
	      			patch.length1 = 0 ;
    			} 
    			else 
    			{
	      			patch.start1-- ;
      				patch.length1 = parseInt(m[2], 10) ;
    			}
				patch.start2 = parseInt(m[3], 10) ;
    			if (m[4] === '') 
    			{
	      			patch.start2-- ;
      				patch.length2 = 1 ;
    			} 
    			else if (m[4] == '0') 
    			{
	      			patch.length2 = 0;
    			}
    			else 
    			{
	      			patch.start2-- ;
      				patch.length2 = parseInt(m[4], 10) ; 
    			}
    			textPointer++;
					
    			while (textPointer < text.length) 
    			{
	      			var sign:String = text[textPointer].charAt(0);
      				try 
      				{
	        			var line:String = decodeURIComponent(text[textPointer].substring(1));
      				} 
      				catch ( ex:Error ) 
      				{
	        			throw new Error( 'Illegal escape in patch_fromText: ' + line );// Malformed URI sequence.
      				}
      				if (sign == '-') 
      				{
		        		// Deletion.
        				patch.diffs.push([ Difference.DELETE , line ] );
      				} 
      				else if (sign == '+') 
      				{
	        			// Insertion.
        				patch.diffs.push([ Difference.INSERT , line ] );
      				} 
      				else if (sign == ' ') 
      				{
	        			// Minor equality.
        				patch.diffs.push([ Difference.EQUAL , line ] ) ;
      				} 
      				else if (sign == '@') 
      				{
	        			// Start of next patch.
        				break;
      				} 
      				else if (sign === '') 
      				{
	        			// Blank line ?  Whatever.
      				} 
      				else 
      				{
        				throw new Error('Invalid patch mode "' + sign + '" in: ' + line) ; // WTF?
      				}
      				textPointer ++ ;
   			 	}
  			}
  			return patches;
		}

		/**
		 * Look through the patches and break up any which are longer than the maximum limit of the match algorithm.
		 * @param patches Array of patch objects {Array.<PatchObject>}.
		 */
		public static function splitMax( patches:Array ):void 
		{
			var len:uint = patches.length ;
  			for (var x:uint = 0 ; x < len ; x++ ) 
  			{
    			if (patches[x].length1 > Match.maxBits ) 
    			{
      				
      				var bigpatch:PatchObject = patches[x] as PatchObject ;
      				
      				// Remove the big old patch.
			      	patches.splice(x, 1) ;
      				
      				var patch_size:uint    = Match.maxBits ;
      				var start1:uint        = bigpatch.start1;
     				var start2:uint        = bigpatch.start2;
      				var precontext:String  = '' ;
      				
      				while ( bigpatch.diffs.length !== 0 ) 
      				{
			        
			        	// Create one of several smaller patches.
        				var patch:PatchObject = new PatchObject() ;
        				var empty:Boolean     = true ;
        				
        				patch.start1 = start1 - precontext.length;
        				patch.start2 = start2 - precontext.length;
        				
        				if ( precontext !== '' ) 
        				{
          					patch.length1 = patch.length2 = precontext.length ;
          					patch.diffs.push([Difference.EQUAL, precontext]) ;
        				}
        				while (bigpatch.diffs.length !== 0 && patch.length1 < patch_size - Patch.margin ) 
        				{
          					var diff_type:int    = bigpatch.diffs[0][0];
          					var diff_text:String = bigpatch.diffs[0][1];
          					if ( diff_type === Difference.INSERT ) 
          					{
            					patch.length2 += diff_text.length ; // Insertions are harmless.
					            start2 += diff_text.length  ;
            					patch.diffs.push(bigpatch.diffs.shift()) ;
            					empty = false ;
          					} 
          					else 
          					{
            					// Deletion or equality.  Only take as much as we can stomach.
            					diff_text = diff_text.substring(0, patch_size - patch.length1 - Patch.margin ) ;
            					patch.length1 += diff_text.length ;
            					start1        += diff_text.length ;
            					if (diff_type === Difference.EQUAL ) 
            					{
              						patch.length2 += diff_text.length;
              						start2 += diff_text.length;
            					} 
            					else 
            					{
              						empty = false;
            					}
            					patch.diffs.push([diff_type, diff_text]);
            					if (diff_text == bigpatch.diffs[0][1]) 
            					{
              						bigpatch.diffs.shift() ;
            					} 
            					else 
            					{
              						bigpatch.diffs[0][1] = bigpatch.diffs[0][1].substring(diff_text.length) ;
            					}
          					}
        				}
        				
        				// Computes the head context for the next patch.
        				
        				precontext = Difference.text2( patch.diffs ) ;
        				precontext = precontext.substring(precontext.length - Patch.margin) ;
        				
        				// Appends the end context for this patch.
        				var postcontext:String = Difference.text1( bigpatch.diffs ).substring(0, Patch.margin) ;
        				if (postcontext !== '') 
        				{
          					patch.length1 += postcontext.length ;
          					patch.length2 += postcontext.length ;
          					if (patch.diffs.length !== 0 && patch.diffs[patch.diffs.length - 1][0] === Difference.EQUAL)           					if (patch.diffs.length !== 0 && patch.diffs[patch.diffs.length - 1][0] === Difference.EQUAL) 
          					{
            					patch.diffs[patch.diffs.length - 1][1] += postcontext ;
          					} 
          					else 
          					{
            					patch.diffs.push([Difference.EQUAL, postcontext]) ;
          					}
        				}
        				if (!empty) 
        				{
          					patches.splice(x++, 0, patch);
        				}
      				}
    			}
  			}
		}		

		/**
		 * Take a list of patches and return a textual representation.
		 * @param {Array.<patch_obj>} patches Array of patch objects
		 * @return {string} Text representation of patches
		 */
		public static function toText( patches:Array ):String 
		{
  			var text:Array = [] ;
  			var len:uint = patches.length ;
  			for (var x:uint = 0; x < len ; x++ ) 
  			{
    			text[x] = patches[x];
  			}
  			return text.join('');
		}


	}

}
