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
package system.text.utils 
{

	/**
	 * Computes the difference between two texts to create a patch. 
	 * Applies the patch onto another text, allowing for errors.
	 * @author eKameleon
	 */
	public class DifferenceMatchPatch 
	{
		
		/**
		 * Creates a new DifferenceMatchPatch instance.
		 */
		public function DifferenceMatchPatch()
		{
			matchMaxBits = getMaxBits();
		}

		/**
		 * The <code class="prettyprint">DIFF_DELETE</code> constante (0).
 		 * <p>The data structure representing a diff is an array of tuples :</p>
 		 * <pre class="prettyprint">
 		 * [[DIFF_DELETE, 'Hello'], [DIFF_INSERT, 'Goodbye'], [DIFF_EQUAL, ' world.']]
 		 * </pre>
 		 * <p>Which means : delete <b>'Hello'</b>, add <b>'Goodbye'</b> and keep </b>' world.'</b>.</p>
 		 */
		public static const DIFF_DELETE:int = -1 ;

		/**
		 * The <code class="prettyprint">DIFF_EQUAL</code> constante (0).
 		 * <p>The data structure representing a diff is an array of tuples :</p>
 		 * <pre class="prettyprint">
 		 * [[DIFF_DELETE, 'Hello'], [DIFF_INSERT, 'Goodbye'], [DIFF_EQUAL, ' world.']]
 		 * </pre>
 		 * <p>Which means : delete <b>'Hello'</b>, add <b>'Goodbye'</b> and keep </b>' world.'</b>.</p>
 		 */
		public static const DIFF_EQUAL:int = 0 ;

		/**
		 * The <code class="prettyprint">DIFF_INSERT</code> constante (0).
 		 * <p>The data structure representing a diff is an array of tuples :</p>
 		 * <pre class="prettyprint">
 		 * [[DIFF_DELETE, 'Hello'], [DIFF_INSERT, 'Goodbye'], [DIFF_EQUAL, ' world.']]
 		 * </pre>
 		 * <p>Which means : delete <b>'Hello'</b>, add <b>'Goodbye'</b> and keep </b>' world.'</b>.</p>
 		 */
		public static const DIFF_INSERT:int = 1 ;

		/**
		 *  The size beyond which the double-ended diff activates.
		 *  Double-ending is twice as fast, but less accurate.
		 */
		public var diffDualThreshold:Number = 32 ;
				
		/**
		 * Cost of an empty edit operation in terms of edit characters.
		 */
		public var diffEditCost:Number = 4 ;
		
		/**
		 * The number of seconds to map a diff before giving up. (0 for infinity)
		 */
		public var diffTimeout:Number = 1.0 ;
  
  		/**
  		 * Tweak the relative importance (0.0 = accuracy, 1.0 = proximity)
  		 */
		public var matchBalance:Number = 0.5 ;

	  	/**
	  	 * The min cutoffs used when computing text lengths.
	  	 */
		public var matchMinLength:Number = 100 ;

		/**
		 * How many bits in a number.
		 */
		public var matchMaxBits:Number ;

	  	/**
	  	 * The max cutoffs used when computing text lengths.
	  	 */
		public var matchMaxLength:Number = 1000 ;
  
  		/**
  		 * At what point is no match declared (0.0 = perfection, 1.0 = very loose)
  		 */
		public var matchThreshold:Number = 0.5 ;
		
		/**
		 * Chunk size for context length.
		 */
		public var patchMargin:Number = 4 ;		

		/**
		 * Increases the context until it is unique, but don't let the pattern expand beyond matchMaxBits.
		 * @param patch The patch to grow.
		 * @param text Source text.
		 */
		public function addContext(patch:PatchObject, text:String):void 
		{
  			var pattern:String = text.substring(patch.start2, patch.start2 + patch.length1);
  			var padding:uint = 0;
  			while (text.indexOf(pattern) != text.lastIndexOf(pattern) && pattern.length < matchMaxBits - patchMargin - patchMargin ) 
  			{
    			padding += patchMargin ;
    			pattern = text.substring(patch.start2 - padding, patch.start2 + patch.length1 + padding);
  			}
  			// Add one chunk for good luck.
  			padding += patchMargin ;
  			// Add the prefix.
  			var prefix:String = text.substring(patch.start2 - padding, patch.start2);
  			if (prefix !== '') 
  			{
    			patch.diffs.unshift([DIFF_EQUAL, prefix]);
  			}
  			// Add the suffix.
  			var suffix:String = text.substring(patch.start2 + patch.length1, patch.start2 + patch.length1 + padding);
  			if (suffix !== '') 
  			{
    			patch.diffs.push([DIFF_EQUAL, suffix]) ;
  			}
			
  			// Roll back the start points.
  			patch.start1 -= prefix.length;
  			patch.start2 -= prefix.length;
  			
  			// Extend the lengths.
  			patch.length1 += prefix.length + suffix.length;
  			patch.length2 += prefix.length + suffix.length;
		}

		/**
 		 * Adds an index to each tuple, represents where the tuple is located in text2.
 		 * e.g. [[DIFF_DELETE, 'h', 0], [DIFF_INSERT, 'c', 0], [DIFF_EQUAL, 'at', 1]]
 		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
 		 */
		public function addIndex( diffs:Array ):void 
		{
  			var i:uint = 0 ;
  			var l:uint = diffs.length ;
  			for (var x:uint = 0; x < l ; x++) 
  			{
    			diffs[x][2] = i;
			    if (diffs[x][0] !== DIFF_DELETE) 
			    {
	      			i += diffs[x][1].length;
			    }
  			}
		}
		
		/**
		 * Locate the best instance of 'pattern' in 'text' near 'loc' using the Bitap algorithm.
		 * @param {string} text The text to search
		 * @param {string} pattern The pattern to search for
		 * @param {number} loc The location to search around
		 * @return {number?} Best match index or null
		 */
		public function bitap( text:String, pattern:String, loc:Number ):Number 
		{
  			if ( pattern.length > matchMaxBits ) 
  			{
	    		throw new Error('Pattern too long for this browser.');
  			}

  			// Initialise the alphabet.
  			var s:Object = alphabet( pattern );

  			var score_text_length:uint = text.length;
  			// Coerce the text length between reasonable maximums and minimums.
  			score_text_length = Math.max( score_text_length, matchMinLength ) ;
  			score_text_length = Math.min( score_text_length, matchMaxLength ) ;
			
  			var dmp:* = this ;  // 'this' becomes 'window' in a closure.

  			/**
		     * Computes and return the score for a match with e errors and x location.
   			 * Accesses loc, score_text_length and pattern through being a closure.
   			 * @param e Number of errors in match.
   			 * @param x Location of match.
   			 * @return Overall score for match.
   			 */
  			function bitapScore(e:Number, x:uint):Number
  			{
    			var d:Number = Math.abs(loc - x);
    			return ( e / pattern.length / dmp.matchBalance ) + ( d / score_text_length / ( 1.0 - dmp.matchBalance ) ) ;
  			}

	  		// Highest score beyond which we give up.
  			var score_threshold:Number = matchThreshold ;
			  		
  			// Is there a nearby exact match? (speedup)
  			var best_loc:int = text.indexOf(pattern, loc);
  			if (best_loc != -1) 
  			{
	    		score_threshold = Math.min(bitapScore(0, best_loc), score_threshold);
  			}
	  		
  			// What about in the other direction? (speedup)
  			best_loc = text.lastIndexOf(pattern, loc + pattern.length) ;
  			if (best_loc != -1) 
  			{
	    		score_threshold = Math.min(bitapScore(0, best_loc), score_threshold);
  			}
	
			// Initialise the bit arrays.
  			var matchmask:int = 1 << (pattern.length - 1) ;
 			best_loc = NaN ;
	
  			var bin_min:int , bin_mid:int ;
  			var bin_max:int = Math.max(loc + loc, text.length) ;
  			var last_rd:Array ;
  			for (var d:int = 0; d < pattern.length ; d++) 
  			{
	    		// Scan for the best match; each iteration allows for one more error.
    			var rd:Array = Array( text.length ) ;
	
    			// Run a binary search to determine how far from 'loc' we can stray at this
    			// error level.
    			bin_min = loc;
    			bin_mid = bin_max;
    			while (bin_min < bin_mid) 
    			{
	      			if (bitapScore(d, bin_mid) < score_threshold) 
      				{
			       		bin_min = bin_mid;
      				} 
      				else 
      				{
	        			bin_max = bin_mid;
      				}
      				bin_mid = Math.floor((bin_max - bin_min) / 2 + bin_min);
    			}
    			// Use the result from this iteration as the maximum for the next.
    			bin_max        = bin_mid ;
    			var start:int  = Math.max(0, loc - (bin_mid - loc) - 1);
    			var finish:int = Math.min(text.length - 1, pattern.length + bin_mid);
    			if ( text.charAt(finish) == pattern.charAt(pattern.length - 1) ) 
    			{
      				rd[finish] = (1 << (d + 1)) - 1;
    			} 
    			else 
    			{
      				rd[finish] = (1 << d) - 1;
    			}
    			for (var j:int = finish - 1; j >= start; j-- ) 
	    		{
    	  			// The alphabet (s) is a sparse hash, so the following lines generate
      				// warnings.
      				if (d === 0) 
      				{  
	      				// First pass: exact match.
	        			rd[j] = ((rd[j + 1] << 1) | 1) & s[text.charAt(j)];
	        		} 
	        		else 
	        		{  
		        		// Subsequent passes: fuzzy match.
        				rd[j] = ((rd[j + 1] << 1) | 1) & s[text.charAt(j)] | ((last_rd[j + 1] << 1) | 1) | ((last_rd[j] << 1) | 1) | last_rd[j + 1] ;
      				}
      				if (rd[j] & matchmask) 
      				{
	        			var score:Number = bitapScore(d, j);
        				// This match will almost certainly be better than any existing match. But check anyway.
        				if (score <= score_threshold) 
        				{
          					score_threshold = score ; // Told you so.
          					best_loc = j ;
          					if (j > loc) 
          					{
            					start = Math.max(0, loc - (j - loc)) ; // When passing loc, don't exceed our current distance from loc.
          					} 
          					else 
          					{
            					break ; // Already passed loc, downhill from here on in.
          					}
        				}
        			}
      			}

    			// No hope for a (better) match at greater error levels.
    			if ( bitapScore(d + 1, loc) > score_threshold ) 
	    		{
      				break;
    			}
    			last_rd = rd ;
  			}
  			return best_loc ;
		}		

		/**
		 * Reduces the number of edits by eliminating operationally trivial equalities.
		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
		 */
		public function cleanupEfficiency( diffs:Array ):void 
		{
  			var changes:Boolean       = false ;
  			var equalities:Array      = []    ; // Stacks of indices where equalities are found.
  			var equalitiesLength:uint = 0     ; // Keeping our own length var is faster in JS.
  			var lastequality:String   = ''    ; // Always equal to equalities[equalitiesLength-1][1]
  			var pointer:uint          = 0     ; // Index of current position.
  			var pre_ins:Boolean       = false ; // Is there an insertion operation before the last equality.
  			var pre_del:Boolean       = false ; // Is there a deletion operation before the last equality.
  			var post_ins:Boolean      = false ; // Is there an insertion operation after the last equality.
  			var post_del:Boolean      = false ; // Is there a deletion operation after the last equality.
  			while ( pointer < diffs.length ) 
  			{
    			if (diffs[pointer][0] == DIFF_EQUAL) 
    			{  // equality found
      				if (diffs[pointer][1].length < this.diffEditCost && (post_ins || post_del)) 
      				{
        				equalities[equalitiesLength++] = pointer; // Candidate found.
				        pre_ins      = post_ins ;
        				pre_del      = post_del ;
        				lastequality = diffs[pointer][1] ;
      				} 
      				else 
      				{
        				// Not a candidate, and can never become one.
        				equalitiesLength = 0;
        				lastequality = '';
      				}
      				post_ins = post_del = false;
    			} 
    			else 
    			{  
      				if (diffs[pointer][0] == DIFF_DELETE) // an insertion or deletion 
      				{
        				post_del = true ;
      				} 
      				else 
      				{
        				post_ins = true ;
      				}
      				/*
       				 * Five types to be split:
       				 * <ins>A</ins><del>B</del>XY<ins>C</ins><del>D</del>
       				 * <ins>A</ins>X<ins>C</ins><del>D</del>
       				 * <ins>A</ins><del>B</del>X<ins>C</ins>
       				 * <ins>A</del>X<ins>C</ins><del>D</del>
       				 * <ins>A</ins><del>B</del>X<del>C</del>
       				 */
      				if 
      				( 
      					lastequality && ((pre_ins && pre_del && post_ins && post_del) || 
                           ((lastequality.length < diffEditCost / 2) &&
                           	( Number(pre_ins) + Number(pre_del) + Number(post_ins) + Number(post_del) ) == 3))
                    ) 
					{
        				// Duplicate record
        				diffs.splice(equalities[equalitiesLength - 1], 0, [DIFF_DELETE, lastequality]);
        				// Change second copy to insert.
        				diffs[equalities[equalitiesLength - 1] + 1][0] = DIFF_INSERT ;
        				equalitiesLength-- ;  // Throw away the equality we just deleted;
        				lastequality = '' ;
        				if (pre_ins && pre_del) 
        				{
          					// No changes made which could affect previous entry, keep going.
          					post_ins = post_del = true ;
          					equalitiesLength = 0;
        				} 
        				else 
        				{
          					equalitiesLength--;  // Throw away the previous equality;
          					pointer = equalitiesLength ? equalities[equalitiesLength - 1] : -1;
          					post_ins = post_del = false;
        				}
        				changes = true;
      				}
    			}
    			pointer++;
  			}

  			if (changes) 
  			{
    			cleanupMerge(diffs) ;
			}
		}


		/**
		 * Rehydrate the text in a diff from a string of line hashes to real lines of text.
 		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
 		 * @param lineArray Array of unique strings {Array.<string>}.
 		 */
		public function charsToLines( diffs:Array , lineArray:Array ):void
		{
			var l:uint = diffs.length ;
  			for ( var x:uint = 0 ; x < l ; x++ ) 
  			{
    			var chars:Array = diffs[x][1] ;
    			var text:Array  = [] ;
    			var n:uint = chars.length ;
    			for ( var y:uint = 0 ; y < n ; y++ ) 
    			{
      				text[y] = lineArray[chars.charCodeAt(y)];
    			}
    			diffs[x][1] = text.join('');
  			}
		}

		/**
		 * Reorder and merge like edit sections.  Merge equalities.
		 * Any edit section can move as long as it doesn't cross an equality.
		 * @param diffs Array of diff tuples {Array.<Array.<*>>}
		 */
		public function cleanupMerge( diffs:Array ):void 
		{
  			diffs.push( [DIFF_EQUAL, ''] ) ; // Add a dummy entry at the end.
  			var pointer:int = 0;
  			var count_delete:uint  = 0  ;
  			var count_insert:uint  = 0  ;
  			var text_delete:String = '' ;
  			var text_insert:String = '' ;
  			var commonlength:uint ;
  			while (pointer < diffs.length) 
  			{
    			switch (diffs[pointer][0]) 
    			{
    				case DIFF_INSERT :
    				{
      					count_insert++ ;
      					text_insert += diffs[pointer][1] ;
      		 			pointer++ ;
      					break ;
    				}
    				case DIFF_DELETE :
    				{
      					count_delete++ ;
      					text_delete += diffs[pointer][1] ;
      					pointer++ ;
      					break ;
    				}
    				case DIFF_EQUAL :
    				{
      					// Upon reaching an equality, check for prior redundancies.
      					if (count_delete !== 0 || count_insert !== 0) 
      					{
        						if (count_delete !== 0 && count_insert !== 0) 
        						{
          							// Factor out any common prefixies.
          							commonlength = commonPrefix(text_insert, text_delete) ;
          							if (commonlength !== 0) 
          							{
            							if ((pointer - count_delete - count_insert) > 0 && diffs[pointer - count_delete - count_insert - 1][0] == DIFF_EQUAL) 
            							{
              								diffs[pointer - count_delete - count_insert - 1][1] += text_insert.substring(0, commonlength) ;
            							}
            							else 
            							{
              								diffs.splice(0, 0, [ DIFF_EQUAL, text_insert.substring(0, commonlength)] ) ;
              								pointer++;
            							}
            							text_insert = text_insert.substring(commonlength);
            							text_delete = text_delete.substring(commonlength);
          							}
          							// Factor out any common suffixies.
          							commonlength = commonSuffix(text_insert, text_delete);
          							if (commonlength !== 0) 
          							{
            							diffs[pointer][1] = text_insert.substring(text_insert.length - commonlength) + diffs[pointer][1] ;
            							text_insert       = text_insert.substring(0, text_insert.length - commonlength ) ;
            							text_delete       = text_delete.substring(0, text_delete.length - commonlength ) ;
          							}
        						}
        						// Delete the offending records and add the merged ones.
        						if (count_delete === 0) 
        						{
          							diffs.splice(pointer - count_delete - count_insert, count_delete + count_insert, [DIFF_INSERT, text_insert]);
        						} 
        						else if (count_insert === 0) 
        						{
          							diffs.splice(pointer - count_delete - count_insert, count_delete + count_insert, [DIFF_DELETE, text_delete]);
        						} 
        						else 
        						{
          							diffs.splice(pointer - count_delete - count_insert, count_delete + count_insert, [DIFF_DELETE, text_delete], [DIFF_INSERT, text_insert]);
						        }
        						pointer = pointer - count_delete - count_insert + (count_delete ? 1 : 0) + (count_insert ? 1 : 0) + 1 ;
      						}
      						else if (pointer !== 0 && diffs[pointer - 1][0] == DIFF_EQUAL) 
      						{
      							// Merge this equality with the previous one.
        						diffs[pointer - 1][1] += diffs[pointer][1] ;
        						diffs.splice(pointer, 1) ;
      						} 
      						else 
      						{
        						pointer++ ;
      						}
      						count_insert = 0 ;
      						count_delete = 0 ;
      						text_delete = '' ;
      						text_insert = '' ;
      						break;
    				}
    			}
  			}
  			if (diffs[diffs.length - 1][1] === '') 
  			{
    			diffs.pop();  // Remove the dummy entry at the end.
  			}
		
  			// Second pass: look for single edits surrounded on both sides by equalities
  			// which can be shifted sideways to eliminate an equality.
  			// e.g: A<ins>BA</ins>C -> <ins>AB</ins>AC
  			var changes:Boolean = false;
  			pointer = 1 ;
  			// Intentionally ignore the first and last element (don't need checking).
  			while (pointer < diffs.length - 1) 
  			{
    			if (diffs[pointer - 1][0] == DIFF_EQUAL && diffs[pointer + 1][0] == DIFF_EQUAL) 
    			{
      				// This is a single edit surrounded by equalities.
      				if (diffs[pointer][1].substring(diffs[pointer][1].length - diffs[pointer - 1][1].length) == diffs[pointer - 1][1]) 
      				{
        				// Shift the edit over the previous equality.
        				diffs[pointer][1]     = diffs[pointer - 1][1] +	diffs[pointer][1].substring(0, diffs[pointer][1].length - diffs[pointer - 1][1].length);
        				diffs[pointer + 1][1] = diffs[pointer - 1][1] + diffs[pointer + 1][1];
				        diffs.splice(pointer - 1, 1);
        				changes = true ;
      				} 
      				else if (diffs[pointer][1].substring(0, diffs[pointer + 1][1].length) == diffs[pointer + 1][1]) 
      				{
        				// Shift the edit over the next equality.
        				diffs[pointer - 1][1] += diffs[pointer + 1][1] ;
        				diffs[pointer][1] = diffs[pointer][1].substring(diffs[pointer + 1][1].length) +
            			diffs[pointer + 1][1] ;
        				diffs.splice(pointer + 1, 1) ;
        				changes = true ;
      				}
    			}
    			pointer++;
  			}
  			// If shifts were made, the diff needs reordering and another shift sweep.
  			if ( changes ) 
  			{
    			cleanupMerge(diffs);
  			}
		}

		/**
		 * Reduce the number of edits by eliminating semantically trivial equalities.
		 * @param {Array.<Array.<*>>} diffs Array of diff tuples
		 */
		public function cleanupSemantic( diffs:Array ):void
		{
  			var changes:Boolean       = false ;
  			var equalities:Array      = []    ; // Stack of indices where equalities are found.
  			var equalitiesLength:uint = 0     ; // Keeping our own length var is faster in JS.
  			var lastequality:*        = null  ; // Always equal to equalities[equalitiesLength-1][1]
  			var pointer:uint          = 0     ; // Index of current position.
  			var length_changes1:uint  = 0     ; // Number of characters that changed prior to the equality.
  			var length_changes2:uint  = 0     ; // Number of characters that changed after the equality.
  			while (pointer < diffs.length) 
  			{
    			if ( diffs[pointer][0] == DIFF_EQUAL ) // equality found 
    			{  
      				equalities[equalitiesLength++] = pointer ;
      				length_changes1 = length_changes2 ;
      				length_changes2 = 0 ;
      				lastequality    = diffs[pointer][1] ;
    			} 
    			else // an insertion or deletion 
    			{  
      				length_changes2 += diffs[pointer][1].length ;
      				if (lastequality !== null && (lastequality.length <= length_changes1) && (lastequality.length <= length_changes2)) 
      				{
        				diffs.splice(equalities[equalitiesLength - 1], 0, [DIFF_DELETE , lastequality]); // Duplicate record
        				diffs[equalities[equalitiesLength - 1] + 1][0] = DIFF_INSERT ; // Change second copy to insert.
				        equalitiesLength--; // Throw away the equality we just deleted.
        				equalitiesLength--; // Throw away the previous equality (it needs to be reevaluated).
        				pointer         = equalitiesLength ? equalities[equalitiesLength - 1] : -1 ;
        				length_changes1 = 0 ;  // Reset the counters.
        				length_changes2 = 0 ;
        				lastequality = null ;
        				changes = true;
      				}
    			}
    			pointer++;
  			}
  			if (changes) 
  			{
    			cleanupMerge(diffs);
  			}
  			cleanupSemanticLossless(diffs) ;
		}

		/**
		 * Look for single edits surrounded on both sides by equalities which can be shifted sideways to align the edit to a word boundary.
		 * e.g: The c<ins>at c</ins>ame. -> The <ins>cat </ins>came.
		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
		 */
		public function cleanupSemanticLossless( diffs:Array ):void 
		{
  			var pointer:int = 1;
			// Intentionally ignore the first and last element (don't need checking).
  			while (pointer < diffs.length - 1) 
  			{
    			if (diffs[pointer - 1][0] == DIFF_EQUAL && diffs[pointer + 1][0] == DIFF_EQUAL) 
    			{
      				// This is a single edit surrounded by equalities.
      				var equality1:String = diffs[pointer - 1][1] ;
      				var edit:String      = diffs[pointer][1];
      				var equality2:String = diffs[pointer + 1][1];

      				// First, shift the edit as far left as possible.
      				var commonOffset:uint = commonSuffix(equality1, edit) ;
      				if (commonOffset) 
      				{
        				var commonString:String = edit.substring(edit.length - commonOffset) ;
        				equality1 = equality1.substring(0, equality1.length - commonOffset) ;
        				edit      = commonString + edit.substring(0, edit.length - commonOffset) ;
        				equality2 = commonString + equality2 ;
      				}

			      	// Second, step character by character right, looking for the best fit.
      				
      				var bestEquality1:String = equality1;
      				var bestEdit:String      = edit;
      				var bestEquality2:String = equality2;
      				var bestScore:uint       = cleanupSemanticScore(equality1, edit, equality2) ;
      				
      				while (edit.charAt(0) === equality2.charAt(0)) 
      				{
	        			equality1 += edit.charAt(0);
        				edit = edit.substring(1) + equality2.charAt(0);
        				equality2 = equality2.substring(1);
        				var score:uint = cleanupSemanticScore(equality1, edit, equality2);
        				if (score >= bestScore) 
        				{
	          				bestScore     = score ;
          					bestEquality1 = equality1 ;
          					bestEdit      = edit ;
          					bestEquality2 = equality2 ;
        				}
     			 	}
	
    	  			if ( diffs[pointer - 1][1] != bestEquality1 ) // We have an improvement, save it back to the diff.
      				{
        				diffs[pointer - 1][1] = bestEquality1 ;
        				diffs[pointer][1]     = bestEdit ;
        				diffs[pointer + 1][1] = bestEquality2 ;
      				}
    			}
    			pointer++;
  			}
		}

  		/**
		 * Given three strings, compute a score representing whether the two internal
		 * boundaries fall on word boundaries.
		 * Closure, but does not reference any external variables.
   		 * @param one First string
		 * @param two Second string
		 * @param {string} three Third string
		 * @return {number} The score.
		 */
		public function cleanupSemanticScore(one:String, two:String, three:String):uint 
		{
    		var whitespace:RegExp = /\s/ ;
    		var score:uint = 0;
    		if (one.charAt(one.length - 1).match(whitespace) || two.charAt(0).match(whitespace)) 
    		{
      			score++;
    		}
    		if (two.charAt(two.length - 1).match(whitespace) || three.charAt(0).match(whitespace)) 
    		{
      			score++ ;
    		}
    		return score;
  		}

		/**
	 	 * Determines the common prefix of two strings.
 		 * @param text1 First string
 		 * @param text2 Second string
 		 * @return The number of characters common to the start of each string.
 		 */
		public function commonPrefix( text1:String , text2:String ):uint 
		{
  			// Quick check for common null cases.
  			if (!text1 || !text2 || text1.charCodeAt(0) !== text2.charCodeAt(0)) 
  			{
    			return 0;
  			}
  			// Binary search. 
  			// Performance analysis: http://neil.fraser.name/news/2007/10/09/
  			var pointermin:uint   = 0;
  			var pointermax:uint   = Math.min(text1.length, text2.length);
  			var pointermid:uint   = pointermax;
	 		var pointerstart:uint = 0 ;
  			while (pointermin < pointermid) 
  			{
    			if (text1.substring(pointerstart, pointermid) == text2.substring(pointerstart, pointermid)) 
    			{
      				pointermin   = pointermid ;
      				pointerstart = pointermin ;
    			} 
    			else 
    			{
      				pointermax = pointermid ;
    			}
    			pointermid = Math.floor((pointermax - pointermin) / 2 + pointermin);
  			}
  			return pointermid ;
		}
		
		/**
		 * Determines the common suffix of two strings.
		 * @param text1 First string
		 * @param text2 Second string
		 * @return The number of characters common to the end of each string.
 		 */
		public function commonSuffix( text1:String , text2:String ):uint
		{
  			// Quick check for common null cases.
  			if ( !text1 || !text2 || text1.charCodeAt(text1.length - 1) !== text2.charCodeAt(text2.length - 1)) 
  			{
    			return 0;
  			}
  			// Binary search.
  			// Performance analysis: http://neil.fraser.name/news/2007/10/09/
  			var pointermin:uint   = 0;
  			var pointermax:uint   = Math.min(text1.length, text2.length);
  			var pointermid:uint   = pointermax;
	 		var pointerend:uint   = 0 ;
		  	while (pointermin < pointermid) 
		  	{
    			if (text1.substring(text1.length - pointermid, text1.length - pointerend) == text2.substring(text2.length - pointermid, text2.length - pointerend)) 
    			{
      				pointermin = pointermid ;
      				pointerend = pointermin ;
    			} 
    			else 
    			{
      				pointermax = pointermid ;
    			}
    			pointermid = Math.floor((pointermax - pointermin) / 2 + pointermin) ;
  			}
  			return pointermid;
		}



		/**
		 * Finds the differences between two texts.
		 * @param text1 Old string to be diffed
		 * @param text2 New string to be diffed
		 * @param checklines Speedup flag. If <code class="prettyprint">false</code>, then don't run a line-level diff first to identify the changed areas.
		 * If <code class="prettyPrint">true</code>, then run a faster, slightly less optimal diff.
		 * @return Array of diff tuples {Array.<Array.<*>>}.
		 */
		public function compute( text1:String, text2:String, checklines:Boolean ):Array
		{
			if (!text1) 
  			{
    			return [[DIFF_INSERT, text2]] ; // Just add some text (speedup)
  			}
  			if (!text2) 
  			{
    			return [[DIFF_DELETE, text1]] ; // Just delete some text (speedup)
			}
			var diffs:Array ;
			var longtext:String  = ( text1.length > text2.length ) ? text1 : text2 ;
			var shorttext:String = ( text1.length > text2.length ) ? text2 : text1 ;
  			var i:int = longtext.indexOf( shorttext ) ;
  			if (i != -1) 
  			{
    			// Shorter text is inside the longer text (speedup)
    			diffs = 
    			[
    				[ DIFF_INSERT , longtext.substring(0, i) ] ,
             		[ DIFF_EQUAL  , shorttext ] ,
             		[ DIFF_INSERT , longtext.substring(i + shorttext.length) ]
             	];
    			// Swap insertions for deletions if diff is reversed.
    			if (text1.length > text2.length) 
    			{
      				diffs[0][0] = diffs[2][0] = DIFF_DELETE ;
    			}
    			return diffs ;
  			}
  			longtext = shorttext = null;  // Garbage collect

			// Check to see if the problem can be split in two.
  			var hm:Array = halfMatch(text1, text2);
  			if (hm) 
  			{
    			// A half-match was found, sort out the return data.
    			var text1_a:String   = hm[0] ;
    			var text1_b:String   = hm[1] ;
    			var text2_a:String   = hm[2] ;
    			var text2_b:String   = hm[3] ;
    			var midCommon:String = hm[4];
    			
    			// Send both pairs off for separate processing.
    			var diffs_a:Array = difference(text1_a, text2_a, checklines) ;
    			var diffs_b:Array = difference(text1_b, text2_b, checklines);
    			
    			// Merge the results.
    			diffs_a.concat( [ [ DIFF_EQUAL, midCommon ] ] , diffs_b ) ;
  			}

  			// Perform a real diff.
  			if (checklines && (text1.length < 100 || text2.length < 100)) 
  			{
    			// Too trivial for the overhead.
    			checklines = false;
  			}
  			var linearray:Array ;
  			if (checklines) 
  			{
    			var a1:Array = linesToChars(text1, text2) ; // Scan the text on a line-by-line basis first.
    			text1        = a1[0] ;
    			text2        = a1[1] ;
    			linearray    = a1[2] ;
  			}
  			diffs = map(text1, text2) ;
  			if (!diffs) 
  			{
    			diffs = [[DIFF_DELETE, text1], [DIFF_INSERT, text2]] ; // No acceptable result.
  			}
  			if (checklines) 
  			{
    			charsToLines(diffs, linearray) ; // Converts the diff back to original text.
    			cleanupSemantic(diffs) ; // Eliminates freak matches (e.g. blank lines)
				
    			// Rediff any replacement blocks, this time character-by-character.
    			// Add a dummy entry at the end.
    			
    			diffs.push( [DIFF_EQUAL, ''] ) ;
    			var pointer:uint       = 0  ;
    			var count_delete:uint  = 0  ;
    			var count_insert:uint  = 0  ;
    			var text_delete:String = '' ;
    			var text_insert:String = '' ;
    			while (pointer < diffs.length) 
    			{
      				switch (diffs[pointer][0]) 
      				{
      					case DIFF_INSERT :
      					{
        					count_insert++ ;
        					text_insert += diffs[pointer][1] ;
        					break ;
      					}
      					case DIFF_DELETE :
      					{
        					count_delete++ ;
        					text_delete += diffs[pointer][1] ;
        					break ;
      					}
      					case DIFF_EQUAL :
      					{
        					// Upon reaching an equality, check for prior redundancies.
        					if (count_delete >= 1 && count_insert >= 1) 
        					{
          						// Delete the offending records and add the merged ones.
          						var a2:Array = difference(text_delete, text_insert, false) ;
          						diffs.splice(pointer - count_delete - count_insert, count_delete + count_insert) ;
          						pointer = pointer - count_delete - count_insert ;
          						for (var j:int = a2.length - 1; j >= 0; j--) 
          						{
            						diffs.splice(pointer, 0, a2[j]);
          						}
          						pointer += a2.length ;
        					}
        					count_insert = 0  ;
        					count_delete = 0  ;
        					text_delete  = '' ;
        					text_insert  = '' ;
        					break ;
      					}
      				}
     				pointer++;
    			}
    			diffs.pop() ;  // Remove the dummy entry at the end.
			}
  			return diffs;
		}

  		/**
		 * Find the differences between two texts. 
		 * Simplifies the problem by stripping any common prefix or suffix off the texts before diffing.
		 * @param {string} text1 Old string to be diffed
		 * @param {string} text2 New string to be diffed
		 * @param {boolean} opt_checklines Optional speedup flag. 
		 * If present and false, then don't run a line-level diff first to identify the changed areas. 
		 * Defaults to true, which does a faster, slightly less optimal diff
		 * @return Array of diff tuples {Array.<Array.<*>>}.
		 */
		public function difference( text1:String, text2:String, checklines:Boolean=true ):Array 
		{
  			// Check for equality (speedup)
  			if (text1 == text2) 
  			{
    			return [ [DIFF_EQUAL , text1 ] ] ;
  			}

			// Trim off common prefix (speedup)
  			
  			var commonlength:uint   = commonPrefix(text1, text2) ;
  			var commonprefix:String = text1.substring(0, commonlength)     ;
  			
  			text1 = text1.substring( commonlength ) ;
  			text2 = text2.substring( commonlength ) ;

  			// Trim off common suffix (speedup)
  			commonlength = commonSuffix(text1, text2);
  			
  			var commonsuffix:String = text1.substring(text1.length - commonlength);
  			
  			text1 = text1.substring(0, text1.length - commonlength);
  			text2 = text2.substring(0, text2.length - commonlength);

  			// Compute the diff on the middle block
  			var diffs:Array = compute(text1, text2, checklines) ; 

  			// Restore the prefix and suffix
  			if (commonprefix) 
  			{
    			diffs.unshift([DIFF_EQUAL, commonprefix]);
  			}
  			if (commonsuffix) 
  			{
    			diffs.push([DIFF_EQUAL, commonsuffix]);
  			}
  			
  			cleanupMerge(diffs);
  			
  			return diffs ;
		}

		/**
		 * Given the original text1, and an encoded string which describes the operations required to transform text1 into text2, compute the full diff.
		 * @param text1 Source string for the diff.
		 * @param delta Delta text.
		 * @return Array of diff tuples {Array.<Array.<*>>}.
		 * @throws Error If invalid input.
		 */
		public function fromDelta(text1:String, delta:String):Array 
		{
  			var diffs:Array      = [] ;
  			var diffsLength:uint = 0  ;  // Keeping our own length var is faster in JS.
  			var pointer:uint     = 0  ;  // Cursor in text1
  			var tokens:Array     = delta.split(/\t/g);
  			var len:uint         = tokens.length ;
  			for (var x:uint = 0 ; x < len ; x++ ) 
  			{
    			// Each token begins with a one character parameter which specifies the operation of this token (delete, insert, equality).
    			var param:String = tokens[x].substring(1);
    			switch (tokens[x].charAt(0)) 
    			{
    				case '+' :
    				{
      					try 
      					{
        					diffs[diffsLength++] = [ DIFF_INSERT , decodeURI(param) ] ;
      					}
      					catch (ex:Error) 
      					{
        					// Malformed URI sequence.
        					throw new Error('Illegal escape in fromDelta: ' + param);
      					}
      					break ;
    				}
    				case '-' :
    				{
      					// Fall through.
    				}
    				case '=' :
    				{
      					var n:int = parseInt(param, 10);
      					if (isNaN(n) || n < 0) 
      					{
        					throw new Error('Invalid number in fromDelta : ' + param) ;
      					}
     					var text:String = text1.substring(pointer, pointer += n);
       					diffs[diffsLength++] = (tokens[x].charAt(0) == '=') ? [DIFF_EQUAL, text] : [DIFF_DELETE, text] ; 
						break;
    				}
    				default :
    				{
      					// Blank tokens are ok (from a trailing \t). Anything else is an error.
      					if (tokens[x]) 
      					{
        					throw new Error('Invalid diff operation in fromDelta : ' + tokens[x]) ;
      					}
    				}
    			}
  			}
  			if (pointer != text1.length) 
  			{
    			throw new Error('Delta length (' + pointer + ') does not equal source text length (' + text1.length + ').') ;
  			}
  			return diffs ;
		}		

		/**
		 * Parse a textual representation of patches and return a list of patch objects.
		 * @param textline Text representation of patches
		 * @return Array of patch objects {Array.<patch_obj>} .
		 * @throws Error If invalid input.
		 */
		public function fromText( textline:String ):Array 
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
	        			throw new Error('Illegal escape in patch_fromText: ' + line);// Malformed URI sequence.
      				}
      				if (sign == '-') 
      				{
		        		// Deletion.
        				patch.diffs.push([DIFF_DELETE, line]);
      				} 
      				else if (sign == '+') 
      				{
	        			// Insertion.
        				patch.diffs.push([DIFF_INSERT, line]);
      				} 
      				else if (sign == ' ') 
      				{
	        			// Minor equality.
        				patch.diffs.push([DIFF_EQUAL, line]);
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
      				textPointer++ ;
   			 	}
  			}
  			return patches;
		};

		/**
		 * Compute the number of bits in an int. The  normal answer for JavaScript is 32.
	     * @return {number} Max bits.
   		 */
  		public static function getMaxBits():Number 
  		{
    		var maxbits:int = 0;
    		var oldi:int    = 1;
    		var newi:int    = 2;
    		while (oldi != newi) 
    		{
      			maxbits++ ;
      			oldi = newi;
      			newi = newi << 1;
    		}
    		return maxbits;
  		}

		/**
		 * Do the two texts share a substring which is at least half the length of the longer text ?
		 * @param text1 First string.
		 * @param text2 Second string.
		 * @return Five element Array, containing the prefix of text1, the suffix of text1, the prefix of text2, 
		 * the suffix of text2 and the common middle.  Or null if there was no match. {Array.<string>?}
	     */
		public function halfMatch( text1:String, text2:String ):Array 
		{
			var longtext:String  = ( text1.length > text2.length ) ? text1 : text2 ;
			var shorttext:String = ( text1.length > text2.length ) ? text2 : text1 ;
  			
  			if (longtext.length < 10 || shorttext.length < 1) 
  			{
    			return null ; // Pointless.
  			}
			
			// First check if the second quarter is the seed for a half-match.
  			var hm1:Array = halfMatchI(longtext, shorttext, Math.ceil(longtext.length / 4) ) ;
  			
  			// Check again based on the third quarter.
  			var hm2:Array = halfMatchI(longtext, shorttext, Math.ceil(longtext.length / 2) ) ;
  			
  			var hm:Array ;
  			if (!hm1 && !hm2) 
  			{
    			return null ;
  			} 
  			else if (!hm2) 
  			{
    			hm = hm1 ;
  			} 
  			else if (!hm1) 
  			{
    			hm = hm2 ;
  			} 
  			else 
  			{
    			// Both matched.  Select the longest.
    			hm = hm1[4].length > hm2[4].length ? hm1 : hm2 ;
			}
			// A half-match was found, sort out the return data.
  			var text1_a:String, text1_b:String, text2_a:String, text2_b:String ;
  			if (text1.length > text2.length) 
  			{
  				text1_a = hm[0] ;
    			text1_b = hm[1] ;
    			text2_a = hm[2] ;
    			text2_b = hm[3] ;
			} 
			else 
			{
    			text2_a = hm[0]	;
    			text2_b = hm[1] ;
    			text1_a = hm[2] ; 
    			text1_b = hm[3] ;
  			}
			return [text1_a, text1_b, text2_a, text2_b, hm[4] ]; // hm[4] = midCommon value
		}

		/**
		 * Split two texts into an array of strings.  Reduce the texts to a string of hashes where each Unicode character represents one line.
		 * @param text1 First string
		 * @param text2 Second string
		 * @return Three element Array, containing the encoded text1, the encoded text2 and the array of unique strings. 
		 * The zeroth element of the array of unique strings is intentionally blank. {Array.<string|Array.<string>>} 
 		 */
		public function linesToChars( text1:String, text2:String):Array 
		{
  			var lineArray:Array = [] ;  // e.g. lineArray[4] == 'Hello\n'
  			var lineHash:Object = {} ;  // e.g. lineHash['Hello\n'] == 4
  			lineArray[0]        = '' ; // '\x00' is a valid character, but various debuggers don't like it.So we'll insert a junk entry to avoid generating a null character.
  			var chars1:String   = linesToCharsMunge(text1, lineArray, lineHash) ;
  			var chars2:String   = linesToCharsMunge(text2, lineArray, lineHash) ;
  			return [chars1, chars2, lineArray];
		}

		/**
 		 * Explores the intersection points between the two texts.
		 * @param text1 Old string to be diffed
		 * @param text2 New string to be diffed
		 * @return Array of diff tuples or null if no diff available. {Array.<Array.<*>>?} 
 		 */
		public function map( text1:String, text2:String ):Array 
		{
  			// Don't run for too long.
  			var k:uint ;
  			var ms_end:int        = (new Date()).getTime() + diffTimeout * 1000 ;
  			var max_d:int         = text1.length + text2.length - 1;
  			var doubleEnd:Boolean = diffDualThreshold * 2 < max_d ;
  			var v_map1:Array      = [] ;
  			var v_map2:Array      = [] ;
  			var v1:Object         = {} ;
  			var v2:Object         = {} ;
  			v1[1] = 0 ;
  			v2[1] = 0 ;
  			var x:Number, y:Number ;
  			var footstep:String  ; // Used to track overlapping paths.
  			var footsteps:Object = {};
  			var done:Boolean = false;
  			//FIXME Safari 1.x doesn't have hasOwnProperty
  			var hasOwnProperty:Boolean = !!(footsteps.hasOwnProperty);
  			// If the total number of characters is odd, then the front path will collide with the reverse path.
	  		var front:uint = (text1.length + text2.length) % 2;
  			for (var d:uint = 0; d < max_d; d++) 
  			{
    			// Bail out if timeout reached.
    			if ( diffTimeout > 0 && (new Date()).getTime() > ms_end) 
    			{
      				return null;
    			}
			
    			// Walk the front path one step.
    			v_map1[d] = {} ;
    			for (k = -d; k <= d; k += 2) 
    			{
      				if (k == -d || k != d && v1[k - 1] < v1[k + 1]) 
      				{
        				x = v1[k + 1] ;
      				} 
      				else 
      				{
        				x = v1[k - 1] + 1 ;
      				}
      				y = x - k ;
      				if (doubleEnd) 
      				{
        				footstep = x + ',' + y ;
        				if (front && (hasOwnProperty ? footsteps.hasOwnProperty(footstep) : (footsteps[footstep] !== undefined))) 
        				{
          					done = true ;
        				}
        				if (!front)
        				{
        				  	footsteps[footstep] = d ;
        				}
      				}
      				while (!done && x < text1.length && y < text2.length && text1.charAt(x) == text2.charAt(y)) 
      				{
        				x++ ;
        				y++ ;
        				if (doubleEnd) 
        				{
          					footstep = x + ',' + y ;
          					if (front && (hasOwnProperty ? footsteps.hasOwnProperty(footstep) : (footsteps[footstep] !== undefined))) 
          					{
            					done = true ;
          					}
          					if (!front) 
          					{
            					footsteps[footstep] = d ;
          					}
        				}
      				}
      				v1[k] = x ;
      				v_map1[d][x + ',' + y] = true ;
      				if (x == text1.length && y == text2.length) 
      				{
        				// Reached the end in single-path mode.
        				return path1(v_map1, text1, text2);
      				} 
      				else if ( done ) 
      				{
        				// Front path ran over reverse path.
        				v_map2 = v_map2.slice(0, footsteps[footstep] + 1) ;
        				var a2:Array = path1(v_map1, text1.substring(0, x),
                        text2.substring(0, y));
        				return a2.concat( path2(v_map2, text1.substring(x), text2.substring(y)) ) ;
      				}
    			}

   				if (doubleEnd) 
   				{
      				// Walk the reverse path one step.
      				v_map2[d] = {} ;
      				for (k = -d; k <= d; k += 2) 
      				{
        				if (k == -d || k != d && v2[k - 1] < v2[k + 1]) 
        				{
          					x = v2[k + 1] ;
        				} 
        				else 
        				{
          					x = v2[k - 1] + 1;
        				}
        				y = x - k ;
        				footstep = (text1.length - x) + ',' + (text2.length - y) ;
        				if (!front && (hasOwnProperty ? footsteps.hasOwnProperty(footstep) : (footsteps[footstep] !== undefined))) 
        				{
          					done = true ;
        				}
        				if (front) 
        				{
          					footsteps[footstep] = d ; 
        				}	
        				while (!done && x < text1.length && y < text2.length && text1.charAt(text1.length - x - 1) == text2.charAt(text2.length - y - 1)) 
        				{
          					x++ ;
          					y++ ;
          					footstep = (text1.length - x) + ',' + (text2.length - y) ;
          					if (!front && (hasOwnProperty ? footsteps.hasOwnProperty(footstep) : (footsteps[footstep] !== undefined))) 
          					{
            					done = true ;
							}
          					if (front) 
          					{
            					footsteps[footstep] = d ;
					        }
        				}
        				v2[k] = x ;
        				v_map2[d][x + ',' + y] = true ;
        				if (done) 
        				{
          					// Reverse path ran over front path.
          					v_map1 = v_map1.slice(0, footsteps[footstep] + 1) ;
          					var a:Array = path1(v_map1, text1.substring(0, text1.length - x), text2.substring(0, text2.length - y));
          					return a.concat( path2(v_map2, text1.substring(text1.length - x), text2.substring(text2.length - y))) ;
        				}
      				}
    			}
  			}
  			return null ; // Number of diffs equals number of characters, no commonality at all.
		}
		
		/**
		 * Locates the best instance of 'pattern' in 'text' near 'loc'.
		 * @param text The text to search
		 * @param pattern The pattern to search for
		 * @param loc The location to search around
		 * @return Best match index or null
		 */
		public function match(text:String, pattern:String, loc:Number):Number 
		{
  			loc = Math.max(0, Math.min(loc, text.length - pattern.length));
  			if (text == pattern) 
  			{
    			return 0 ; // Shortcut (potentially not guaranteed by the algorithm)
  			} 
  			else if (text.length === 0) 
  			{
	   			return null ; // Nothing to match.
  			} 
  			else if (text.substring(loc, loc + pattern.length) == pattern) 
  			{
    			return loc; // Perfect match at the perfect spot!  (Includes case of null pattern)
  			} 
  			else 
  			{
		    	return bitap(text, pattern, loc); // Do a fuzzy compare.
  			}
		}
		
		/**
		 * Converts a diff array into a pretty HTML report.
 		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
		 * @return The HTML representation.
		 */
		public function prettyHtml( diffs:Array ):String 
		{
  			addIndex(diffs) ;
  			var html:Array = [] ;
  			var len:uint = diffs.length ;
  			for (var x:uint = 0; x < len ; x++ ) 
  			{
    			var m:uint   = diffs[x][0]; // Mode (delete, equal, insert)
    			var t:String = diffs[x][1]; // Text of change.
    			var i:*      = diffs[x][2]; // Index of change.
    			t            = t.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    			t            = t.replace(/\n/g, '&para;<BR>');
    			switch (m) 
    			{
    				case DIFF_INSERT :
    				{
	      				html[x] = '<INS STYLE="background:#E6FFE6;" TITLE="i=' + i + '">' + t + '</INS>' ;
      					break;
    				}
	    			case DIFF_DELETE :
    				{
	      				html[x] = '<DEL STYLE="background:#FFE6E6;" TITLE="i=' + i + '">' + t + '</DEL>' ;
      					break ;
    				}
    				case DIFF_EQUAL :
    				{
	      				html[x] = '<SPAN TITLE="i=' + i + '">' + t + '</SPAN>' ;
      					break;
  				  	}
  				}
  			}
  			return html.join('');
		}

		/**
		 * Computes and returns the source text (all equalities and deletions).
		 * @param diffs Array of diff tuples {Array.<Array.<*>>} 
		 * @return Source text.
		 */
		public function text1( diffs:Array ):String 
		{
  			var txt:Array = [];
  			var l:uint = diffs.length ;
  			for ( var x:uint = 0 ; x < l ; x++ ) 
    		{
    			if ( diffs[x][0] !== DIFF_INSERT ) 
    			{
      				txt[x] = diffs[x][1];
    			}
  			}
  			return txt.join('');
		}

		/**
		 * Compute and return the destination text (all equalities and insertions).
		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
		 * @return Destination text.
		 */
		public function text2( diffs:Array ):String 
		{
  			var txt:Array = [] ;
  			var l:uint = diffs.length ;
  			for ( var x:uint = 0 ; x < l ; x++ ) 
  			{
    			if ( diffs[x][0] !== DIFF_DELETE ) 
    			{
      				txt[x] = diffs[x][1];
    			}
  			}
  			return txt.join('');
		}

		/**
		 * Crushs the diff into an encoded string which describes the operations required to transform text1 into text2.
		 * <p>E.g. =3\t-2\t+ing  -> Keep 3 chars, delete 2 chars, insert 'ing'.</p>
		 * <p>Operations are tab-separated. Inserted text is escaped using %xx notation.</p>
		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
		 * @return The delta text.
		 */
		public function toDelta( diffs:Array ):String 
		{
  			var txt:Array = [];
  			var l:uint = diffs.length ;
  			for (var x:uint = 0; x < l ; x++) 
    		switch (diffs[x][0]) 
    		{
    			case DIFF_INSERT :
    			{
      				txt[x] = '+' + encodeURI(diffs[x][1]);
      				break;
    			}
    			case DIFF_DELETE :
    			{
      				txt[x] = '-' + diffs[x][1].length ;
      				break;
    			}
    			case DIFF_EQUAL :
    			{
      				txt[x] = '=' + diffs[x][1].length;
					break;
    			}
  			}
			return txt.join('\t').replace( /%20/g , ' ' ) ;
		}

		/**
		 * Take a list of patches and return a textual representation.
		 * @param {Array.<patch_obj>} patches Array of patch objects
		 * @return {string} Text representation of patches
		 */
		public function toText( patches:Array ):String 
		{
  			var text:Array = [] ;
  			var len:uint = patches.length ;
  			for (var x:uint = 0; x < len ; x++ ) 
  			{
    			text[x] = patches[x];
  			}
  			return text.join('');
		}

		/**
		 * loc is a location in text1, compute and return the equivalent location in text2. e.g. 'The cat' vs 'The big cat', 1->1, 5->8
 		 * @param diffs Array of diff tuples {Array.<Array.<*>>}.
		 * @param loc Location within text1.
		 * @return Location within text2.
		 */
		public function xIndex(diffs:Array, loc:Number):Number 
		{
  			var chars1:uint      = 0 ;
  			var chars2:uint      = 0 ;
  			var last_chars1:uint = 0 ;
  			var last_chars2:uint = 0 ;
  			var x:uint ;
  			var l:uint = diffs.length ;
  			for (x = 0; x < l; x++) 
  			{
    			if (diffs[x][0] !== DIFF_INSERT) 
    			{
      				chars1 += diffs[x][1].length;   // Equality or deletion.
    			}
    			if (diffs[x][0] !== DIFF_DELETE) 
    			{  
      				chars2 += diffs[x][1].length; // Equality or insertion.
    			}
    			if (chars1 > loc) 
    			{
    				break ;  // Overshot the location.
    			}
    			last_chars1 = chars1;
    			last_chars2 = chars2;
  			}
  			// Was the location was deleted ?
  			if ( diffs.length != x && diffs[x][0] === DIFF_DELETE ) 
  			{
    			return last_chars2 ;
  			}
  			// Add the remaining character length.
  			return last_chars2 + (loc - last_chars1) ;
		}

		/**
 		 * Initialise the alphabet for the Bitap algorithm.
 		 * @param {string} pattern The text to encode
 		 * @return {Object} Hash of character locations
 		 */
		private function alphabet( pattern:String ):Object 
		{
  			var s:Object = Object() ;
  			var l:uint   = pattern.length ;
  			var i:uint ;
  			for ( i = 0 ; i < l ; i++ ) 
  			{
    			s[pattern.charAt(i)] = 0;
  			}
  			for ( i = 0 ; i < pattern.length; i++ ) 
  			{
    			s[pattern.charAt(i)] |= 1 << (pattern.length - i - 1 ) ;
  			}
	  		return s;
		}

		/**
		 * Does a substring of shorttext exist within longtext such that the substring is at least half the length of longtext ?
		 * Closure, but does not reference any external variables.
		 * @param {string} longtext Longer string.
		 * @param {string} shorttext Shorter string.
		 * @param {number} i Start index of quarter length substring within longtext.
		 * @return Five element Array, containing the prefix of longtext, the suffix of longtext, the prefix of shorttext, the suffix
		 * of shorttext and the common middle.  Or null if there was no match. {Array.<string>?}
		 */
		private function halfMatchI( longtext:String , shorttext:String , i:uint ):Array 
		{
    		// Start with a 1/4 length substring at position i as a seed.
    		var seed:String = longtext.substring(i, i + Math.floor(longtext.length / 4));
		    var j:int = -1;
    		var best_common:String = '';
    		var best_longtext_a:String , best_longtext_b:String, best_shorttext_a:String, best_shorttext_b:String ;
    		while ((j = shorttext.indexOf(seed, j + 1)) != -1) 
    		{
      			var prefixLength:uint = commonPrefix(longtext.substring(i)    , shorttext.substring(j) ) ;
      			var suffixLength:uint = commonSuffix(longtext.substring(0, i) , shorttext.substring(0, j) ) ;
      			if ( best_common.length < suffixLength + prefixLength ) 
      			{
        			best_common = shorttext.substring(j - suffixLength, j) + shorttext.substring(j, j + prefixLength ) ;
        			best_longtext_a = longtext.substring(0, i - suffixLength);
        			best_longtext_b = longtext.substring(i + prefixLength);
        			best_shorttext_a = shorttext.substring(0, j - suffixLength);
        			best_shorttext_b = shorttext.substring(j + prefixLength);
      			}
    		}
    		if (best_common.length >= longtext.length / 2) 
    		{
      			return [ best_longtext_a, best_longtext_b, best_shorttext_a, best_shorttext_b, best_common ] ;
    		}
    		else 
    		{
      			return null;
  			}
  		}
 		
 		/**
		 * Split a text into an array of strings.  Reduce the texts to a string of
   		 * hashes where each Unicode character represents one line.
   		 * Modifies linearray and linehash through being a closure.
   		 * @param {string} text String to encode
   		 * @return {string} Encoded string
		 */
		private function linesToCharsMunge( text:String, lineArray:Array, lineHash:Object ):String 
		{
    		var chars:String = '';
		    // Walk the text, pulling out a substring for each line.
    		// text.split('\n') would would temporarily double our memory footprint.
    		// Modifying text would create many large strings to garbage collect.
    		var lineStart:uint = 0;
    		var lineEnd:int    = -1;
    		// Keeping our own length variable is faster than looking it up.
    		var lineArrayLength:uint = lineArray.length;
    		while (lineEnd < text.length - 1) 
    		{
      			lineEnd = text.indexOf('\n', lineStart);
      			if (lineEnd == -1) 
      			{
        			lineEnd = text.length - 1;
      			}
      			var line:String = text.substring(lineStart, lineEnd + 1) ;
      			lineStart       = lineEnd + 1 ;
				
				if ( lineHash.hasOwnProperty ? lineHash.hasOwnProperty(line) : (lineHash[line] !== undefined)) 
				{
        			chars += String.fromCharCode(lineHash[line]);
      			} 
      			else 
      			{
        			chars                        += String.fromCharCode(lineArrayLength) ;
        			lineHash[line]                = lineArrayLength ;
        			lineArray[lineArrayLength++]  = line ;
      			}
    		}
    		return chars;
  		}


		/**
		 * Work from the middle back to the start to determine the path.
		 * @param {Array.<Object>} v_map Array of paths.
		 * @param text1 Old string fragment to be diffed.
		 * @param text2 New string fragment to be diffed.
		 * @return Array of diff tuples {Array.<Array.<*>>}.
 		 */
		private function path1( v_map:Array , text1:String, text2:String):Array 
		{
  			var path:Array  = [];
  			var x:uint      = text1.length ;
  			var y:uint      = text2.length ;
  			var last_op:int = NaN ;
  			for (var d:int = v_map.length - 2 ; d >= 0 ; d-- ) 
  			{
    			while (1) 
    			{
      				if (v_map[d].hasOwnProperty ? v_map[d].hasOwnProperty((x - 1) + ',' + y) : (v_map[d][(x - 1) + ',' + y] !== undefined)) 
      				{
        				x-- ;
        				if (last_op === DIFF_DELETE) 
        				{
          					path[0][1] = text1.charAt(x) + path[0][1] ;
        				}
        				else 
        				{
          					path.unshift([DIFF_DELETE, text1.charAt(x)]) ;
        				}
        				last_op = DIFF_DELETE;
        				break ;
      				} 
      				else if (v_map[d].hasOwnProperty ? v_map[d].hasOwnProperty(x + ',' + (y - 1)) : (v_map[d][x + ',' + (y - 1)] !== undefined)) 
      				{
        				y-- ;
        				if (last_op === DIFF_INSERT) 
        				{
          					path[0][1] = text2.charAt(y) + path[0][1] ;
        				} 
        				else 
        				{
          					path.unshift([DIFF_INSERT, text2.charAt(y)]) ;
        				}
        				last_op = DIFF_INSERT ;
        				break ;
      				} 
      				else 
      				{
        				x-- ;
        				y-- ;
        				//if (text1.charAt(x) != text2.charAt(y)) 
        				//{
        				//    throw new Error('No diagonal.  Can\'t happen. (diff_path1)');
        				//}
        				if (last_op === DIFF_EQUAL) 
        				{
          					path[0][1] = text1.charAt(x) + path[0][1] ;
        				} 
        				else 
        				{
          					path.unshift([DIFF_EQUAL, text1.charAt(x)]);
        				}
        				last_op = DIFF_EQUAL;
      				}
    			}
  			}
  			return path;
		}

		/**
		 * Works from the middle back to the end to determine the path.
		 * @param v_map Array of paths. {Array.<Object>} 
		 * @param text1 Old string fragment to be diffed
		 * @param text2 New string fragment to be diffed
		 * @return Array of diff tuples {Array.<Array.<*>>} 
		 */
		private function path2(v_map:Array, text1:String, text2:String):Array 
		{
  			var path:Array      = [] ;
  			var pathLength:uint = 0  ;
  			var x:uint          = text1.length ;
  			var y:uint          = text2.length ;
  			var last_op:uint    = NaN ;
  			for (var d:uint = v_map.length - 2; d >= 0; d--) 
  			{
    			while (1) 
    			{
      				if (v_map[d].hasOwnProperty ? v_map[d].hasOwnProperty((x - 1) + ',' + y) : (v_map[d][(x - 1) + ',' + y] !== undefined)) 
      				{
        				x-- ;
        				if (last_op === DIFF_DELETE) 
        				{
          					path[pathLength - 1][1] += text1.charAt(text1.length - x - 1) ;
        				} 
        				else 
        				{
          					path[pathLength++] = [DIFF_DELETE, text1.charAt(text1.length - x - 1)] ;
        				}
        				last_op = DIFF_DELETE ; 
      				    break ;
      				} 
      				else if (v_map[d].hasOwnProperty ? v_map[d].hasOwnProperty(x + ',' + (y - 1)) : (v_map[d][x + ',' + (y - 1)] !== undefined)) 
      				{
        				y-- ;
        				if (last_op === DIFF_INSERT) 
        				{
          					path[pathLength - 1][1] += text2.charAt(text2.length - y - 1) ;
        				} 
        				else 
        				{
          					path[pathLength++] = [DIFF_INSERT, text2.charAt(text2.length - y - 1)] ;
        				}
        				last_op = DIFF_INSERT ;
        				break;
      				} 
      				else 
      				{
        				x-- ;
        				y-- ;
        				// if (text1.charAt(text1.length - x - 1) != text2.charAt(text2.length - y - 1)) 
        				// {
        				//     throw new Error('No diagonal.  Can\'t happen. (diff_path2)');
        				// }
        				if (last_op === DIFF_EQUAL) 
        				{
          					path[pathLength - 1][1] += text1.charAt(text1.length - x - 1) ;
        				}
        				else 
        				{
          					path[pathLength++] = [DIFF_EQUAL, text1.charAt(text1.length - x - 1)];
        				}
        				last_op = DIFF_EQUAL;
      				}
    			}
  			}
  			return path;
		}
		


	}

}
