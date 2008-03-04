/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PegAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Represents an immutable range of values.
 * <p><b>Example :</b></p>
 * {@code
 * Range = pegas.maths.Range ;
 * 
 * var r1 = new Range(10, 120) ;
 * var r2 = new Range(100, 150) ;
 * 
 * trace ("r1 : " + r1) ; // r1 : [Range<10,120>]
 * trace ("r2 : " + r2) ; // r2 : [Range<100,150>]
 * 
 * trace ("r2.toSource()     : " + r2.toSource()) ; // r2.toSource() : new pegas.maths.Range(100,150)
 * trace ("r1 contains 50    : " + r1.contains(50)) ; // r1 contains 50 : true
 * trace ("r1 isOutOfRange 5 : " + r1.isOutOfRange(5)) ; // r1 isOutOfRange 5 : true
 * trace ("r1 overlap r2     : " + r1.overlap(r2)) ; // r1 overlap r2 : true
 * trace ("r1 clamp 5        : " + r1.clamp(5)) ; // r1 clamp 5 : 10
 * trace ("r1 clamp 121      : " + r1.clamp(121)) ; // r1 clamp 121 : 120
 * }
 * @author eKameleon
 */
if (pegas.maths.Range == undefined) 
{
	
	/**
	 * Creates a new Range instance.
	 * use <pre>var r:Range = new Range(min, max) ;</pre>
	 */ 
	pegas.maths.Range = function( min /*Number*/ , max /*Number*/ ) 
	{
		if ( max < min) 
		{
			throw new vegas.errors.ArgumentOutOfBoundsError("Range constructor, 'max' argument is < of 'min' argument") ;
		}
		this.min = min ;
		this.max = max ;
	}

	/**
	 * @extends vegas.core.CoreObject
	 */
	proto = pegas.maths.Range.extend(vegas.core.CoreObject) ;

	/**
	 * Range between 0 and 100.
	 */
	pegas.maths.Range.PERCENT_RANGE /*Range*/ = new pegas.maths.Range(0, 100) ;

	/**
	 * Range between -255 and 255.
	 */
	pegas.maths.Range.COLOR_RANGE /*Range*/ = new pegas.maths.Range(-255, 255) ;
	
	/**
	 * Range between 0 and 1.
	 */
	pegas.maths.Range.UNITY_RANGE /*Range*/ = new pegas.maths.Range(0, 1) ;
	
	/**
	 * The max value of the range.
	 */	
	proto.max /*Number*/ = null ;

	/**
	 * The min value of the range.
	 */
	proto.min /*Number*/ = null ;
	
	/**
	 * Clamp a value in the current range.
	 */	
 	proto.clamp = function ( value /*Number*/ ) /*void*/ 
 	{
		return vegas.util.MathsUtil.clamp(value, this.min, this.max) ;
	}

	/**
	 * Returns a shallow copy of the object.
	 * @return a shallow copy of the object.
	 */
	proto.clone = function () 
	{
		return new pegas.maths.Range(this.min, this.max) ;
	}

	/**
	 * Creates a new range by combining two existing ranges.
	 * <li>either range can be {@code null}, in which case the other range is returned.</li>
     * <li>if both ranges are {@code null} the return value is {@code null}.</li>
	 * 
	 * @param range1 the first range, {@code null} permitted.
	 * @param range2 the second range, {@code null} permitted.
	 */
	/*static*/ pegas.maths.Range.combine = function ( range1 /*Range*/, range2 /*Range*/ ) /*Range*/
	{
		if (range1 == null)
		{
			return range2 || null ;	
		}
		else
		{
			if (range2 == null)
			{
				return range1 || null ;	
			}	
			else
			{
				var lower = Math.min( range1.min , range2.min ) ;
				var upper = Math.max( range1.max , range2.max ) ;
				return new pegas.maths.Range(lower, upper) ;	
			}
		}
	}

	/**
	 * Returns {@code true} if the Range instance contains the value passed in argument.
	 * @return {@code true} if the Range instance contains the value passed in argument.
	 */
	proto.contains = function (value /*Number*/) /*Boolean*/ 
	{
		return !this.isOutOfRange(value) ;
	}

	/**
	 * Indicates whether some other object is "equal to" this one.
	 */
	proto.equals = function (o) /*Boolean*/ 
	{
		return (o instanceof pegas.maths.Range) && (o.min == this.min) && (o.max == this.max) ; 
	}

	/**
	 * Creates a new range by adding margins to an existing range.
	 * @param range the range {@code null} not permitted.
	 * @param lowerMargin the lower margin (expressed as a percentage of the range length).
	 * @param upperMargin the upper margin (expressed as a percentage of the range length).
	 * @return The expanded range.
	 * @throws IllegalArgumentError if the range argument is {@code null}
	 */
	/*static*/ pegas.maths.Range.expand = function ( range /*Range*/, lowerMargin /*Number*/, upperMargin/*Number*/ ) /*Range*/
	{
		if (range == null)
		{
			throw new vegas.errors.IllegalArgumentError("Range.expand method failed, the range argument not must be 'null' or 'undefined'.");  
		}
		var size  /*Number*/ = range.size() ;
		var lower /*Number*/ = size * lowerMargin ;
		var upper /*Number*/ = size * upperMargin ;
		return new pegas.maths.Range( range.min - lower , range.max + upper ) ;
	}
	
	/**
	 * Returns the central value for the range.
	 * @return The central value.
	 */
	proto.getCentralValue = function() /*Number*/
	{
		return (this.min + this.max) / 2 ;
	}

	/**
	 * Returns {@code true} if the value is out of the range.
	 * @return {@code true} if the value is out of the range.
	 */
	proto.isOutOfRange = function (value /*Number*/) 
	{
		return (value > this.max ) || (value < this.min) ;
	}

	/**
	 * Returns {@code true} if the range in argument overlap the current range.
	 * @return {@code true} if the range in argument overlap the current range.
	 */
	proto.overlap = function ( r /*Range*/ ) /*Boolean*/ 
	{
		return (this.max > r.min) && (r.max > this.min) ;
	}

	/**
	 * Returns the length of the range.
	 * @return the length of the range.
	 */
	proto.size = function() /*Number*/
	{
		return this.max - this.min ;	
	}

	/**
	 * Returns the Eden reprensation of the object.
	 * @return a string representing the source code of the object.
	 */
	proto.toSource = function (indent/*Number*/, indentor/*String*/)/*String*/ 
	{
		return "new " + this.getConstructorPath() + "(" + this.min + "," + this.max + ")";
	}

	/**
	 * Returns the string representation of this instance.
	 * @return the string representation of this instance.
	 */
	proto.toString = function () /*String*/ 
	{
		return "[Range<" + this.min + "," + this.max + ">]";
	}


	delete proto ;
	
}
