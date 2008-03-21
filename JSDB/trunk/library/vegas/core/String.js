/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Returns 0 if the passed string is lower case else 1.
 * @return 0 if the passed string is lower case else 1.
 */
String.prototype.caseValue = function() /*Number*/
{
	return ( this.toLowerCase().valueOf() == this.valueOf() ) ? 0 : 1 ;
}

/**
 * Compares the two caracteres passed in argument for order.
 * @return <p>
 * <li>-1 if charA is "lower" than (less than, before, etc.) charB ;</li>
 * <li> 1 if charA is "higher" than (greater than, after, etc.) charB ;</li>
 * <li> 0 if charA and charB are equal.</li>
 * </p>
 */
String.compareChars = function( charA /*String*/ , charB /*String*/ ) /*Number*/
{
	var a /*String*/ = charA.charAt(0) ;
	var b /*String*/ = charB.charAt(0) ;
	if ( a.caseValue() < b.caseValue() ) 
	{
		return -1;
	}
	if ( a.caseValue() > b.caseValue() ) 
	{
		return 1 ;
	}
	if ( a < b ) 
	{
		return -1;
	}
	if ( a > b ) 
	{
		return 1;
	}
	return 0 ;
}



/**
 * Returns the first char of a string.
 * @return the first char of a string.
 */
String.prototype.firstChar = function() /*String*/ 
{
	return this.charAt(0) ;
}

/**
 * This trim method used RegExp to apply the trim on the expression.
 */
String.prototype.trim2 = function () 
{
	var s = this ;
	s = s.replace(/^\s*/, "") ;
	s = s.replace(/\s*$/, "") ;
	s = s.replace(/\n/g,  "") ;
	s = s.replace(/\r/g,  "") ;
	s = s.replace(/\t/g,  "") ;
	return s ;
}


/**
 * Capitalize the first letter of a string, like the PHP function.
 */
String.prototype.ucFirst = function() /*String*/ 
{
	return this.charAt(0).toUpperCase() + this.substring(1) ;
}
	
/**
 * Capitalize each word in a string, like the PHP function.
 */
String.prototype.ucWords = function() /*String*/ 
{
	var ar /*Array*/ = this.split(" ") ;
	var l /*Number*/ = ar.length ;
	while(--l > -1) {
		ar[l] = ar[l].ucFirst() ;
	}
	return ar.join(" ") ;
}