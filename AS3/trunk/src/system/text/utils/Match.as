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
	public class Match 
	{
		
  		/**
  		 * Tweak the relative importance (0.0 = accuracy, 1.0 = proximity)
  		 */
		public static var balance:Number = 0.5 ;		
		
        /**
         * How many bits in a number.
         */
        public static var maxBits:Number = getMaxBits() ;

        /**
         * The max cutoffs used when computing text lengths.
         */
        public static var maxLength:Number = 1000 ;		
		
	  	/**
	  	 * The min cutoffs used when computing text lengths.
	  	 */
		public static var minLength:Number = 100 ;
          
  		/**
  		 * At what point is no match declared (0.0 = perfection, 1.0 = very loose)
  		 */
		public static var threshold:Number = 0.5 ;

		/**
 		 * Initialise the alphabet for the Bitap algorithm.
 		 * @param {string} pattern The text to encode
 		 * @return {Object} Hash of character locations
 		 */
		public static function alphabet( pattern:String ):Object 
		{
  			var s:Object = {} ;
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
		 * Locate the best instance of 'pattern' in 'text' near 'loc' using the Bitap algorithm.
		 * @param text The text to search
		 * @param pattern The pattern to search for
		 * @param loc The location to search around
		 * @return The best match index or null
		 */
		public static function bitap( text:String, pattern:String, loc:Number ):Number 
		{
  			if ( pattern.length > maxBits ) 
  			{
	    		throw new Error( 'Pattern too long for this browser.' ) ;
  			}

  			// Initialise the alphabet.
  			var s:Object = alphabet( pattern );

  			var score_text_length:uint = text.length;
  			// Coerce the text length between reasonable maximums and minimums.
  			score_text_length = Math.max( score_text_length, minLength ) ;
  			score_text_length = Math.min( score_text_length, maxLength ) ;
			
	  		// Highest score beyond which we give up.
  			var score_threshold:Number = threshold ;
			  		
  			// Is there a nearby exact match? (speedup)
  			var best_loc:int = text.indexOf(pattern, loc);
  			if (best_loc != -1) 
  			{
	    		score_threshold = Math.min(bitapScore(0, best_loc, loc, pattern , score_text_length), score_threshold);
  			}
	  		
  			// What about in the other direction? (speedup)
  			best_loc = text.lastIndexOf(pattern, loc + pattern.length) ;
  			if (best_loc != -1) 
  			{
	    		score_threshold = Math.min(bitapScore(0, best_loc, loc, pattern , score_text_length), score_threshold);
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
    			var rd:Array = new Array( text.length ) ;
	
    			// Run a binary search to determine how far from 'loc' we can stray at this
    			// error level.
    			bin_min = loc;
    			bin_mid = bin_max;
    			
    			while (bin_min < bin_mid) 
    			{
	      			if (bitapScore(d, bin_mid, loc, pattern , score_text_length) < score_threshold) 
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
	        			var score:Number = bitapScore(d, j, loc, pattern , score_text_length);
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
    			if ( bitapScore(d + 1, loc, loc, pattern , score_text_length) > score_threshold ) 
	    		{
      				break;
    			}
    			
    			last_rd = rd ;
    			
  			}
  			
  			return best_loc ;
		
		}		

  		/**
		 * Computes and return the score for a match with e errors and x location.
   		 * Accesses loc, score_text_length and pattern through being a closure.
   		 * @param e Number of errors in match.
   		 * @param x Location of match.
   		 * @return Overall score for match.
   		 */
  		public static function bitapScore( e:Number, x:uint, loc:Number, pattern:String , scoreLength:Number ):Number
		{
    		var d:Number = Math.abs(loc - x) ;
    		return ( e / pattern.length / balance ) + ( d / scoreLength / ( 1.0 - balance ) ) ;
  		}
		
		/**
		 * Locates the best instance of 'pattern' in 'text' near 'loc'.
		 * @param text The text to search
		 * @param pattern The pattern to search for
		 * @param loc The location to search around
		 * @return Best match index or null
		 */
		public static function main( text:String, pattern:String, loc:Number ):Number 
		{
  			loc = Math.max(0, Math.min(loc, text.length - pattern.length));
  			if (text == pattern) 
  			{
    			return 0 ; // Shortcut (potentially not guaranteed by the algorithm)
  			} 
  			else if (text.length === 0) 
  			{
	   			return NaN ; // Nothing to match.
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

	}

}
