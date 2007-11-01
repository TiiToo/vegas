/*
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

package vegas.string.eden
{
	
	/* NameSpace: strings
	   Configure the eden library messages.
   
  		 exemple:
		   (code)
		   trace( String.format( buRRRn.eden.strings.pairIsIgnored, "toto", 5, 10 ) );
		   (end)
   
		   attention:
		   Don't use eden to load its own resources message
		   this will cause an infinite loop.
	*/
	
	public class strings
	{
		
		/* StaticProperty: requirePairValue
		   multiSerialize require pairs of values
		*/	
		public static var requirePairValue:String = "multiSerialize require pairs of values";
		
	    /* Property: pairIsIgnored
			name "{0}" is not a string, pair[{1},{2}] is ignored
		*/
	    public static var pairIsIgnored:String = "name \"{0}\" is not a string, pair[{1},{2}] is ignored";
	    
	    /* Property: reservedKeyword
	       "{0}" is a reserved keyword
	    */
	    public static var reservedKeyword:String = "\"{0}\" is a reserved keyword";
	    
	    /* Property: futurReservedKeyword
	       "{0}" is a future reserved keyword
	    */
	    public static var futurReservedKeyword:String = "\"{0}\" is a future reserved keyword";
	    
	    /* Property: notValidPath
	       "{0} is not a valid path
	    */
	    public static var notValidPath:String = "\"{0}\" is not a valid path";
	    
	    /* Property: unterminatedComment
	       unterminated comment
	    */
	    public static var unterminatedComment:String = "unterminated comment";
	    
	    /* Property: errorComment
	       syntax error (comment)
	    */
	    public static var errorComment:String = "syntax error (comment)";
	    
	    /* Property: errorIdentifier
	       bad identifier
	    */
	    public static var errorIdentifier:String = "bad identifier";
	    
	    /* Property: notValidConstructor
	       "{0}" is not a valid constructor
	    */
	    public static var notValidConstructor:String = "\"{0}\" is not a valid constructor";
	    
	    /* Property: doesNotExist
	       "{0}" does not exists
	    */
	    public static var doesNotExist:String = "\"{0}\" does not exists";
	    
	    /* Property: errorConstructor
	       bad constructor
	    */
	    public static var errorConstructor:String = "bad constructor";
	    
	    /* Property: errorLineTerminator
	       bad string (found line terminator in string)
	    */
	    public static var errorLineTerminator:String = "bad string (found line terminator in string)";
	    
	    /* Property: errorString
	       bad string (unterminated string)
	    */
	    public static var errorString:String = "bad string (unterminated string)";
	    
	    /* Property: errorArray
	       bad array (unterminated array)
	    */
	    public static var errorArray:String = "bad array (unterminated array)";
	    
	    /* Property: errorObject
	       bad object (unterminated object)
	    */
	    public static var errorObject:String = "bad object (unterminated object)";
	    
	    /* Property: malformedHexadecimal
	       bad number (malformed hexadecimal)
	    */
	    public static var malformedHexadecimal:String = "bad number (malformed hexadecimal)";
	    
	    /* Property: errorNumber
	       bad number (not finite)
	    */
	    public static var errorNumber:String = "bad number (not finite)";
	    
	    /* Property: extRefDoesNotExist
	       external reference "{0}" does not exists
	    */
	    public static var extRefDoesNotExist:String = "external reference \"{0}\" does not exists";
	    
	    /* Property: errorKeyword
		       syntax error
	    */
	    public static var errorKeyword:String = "syntax error";
	    
	    /* Property: notAuthorizedConstructor
	       "{0}" is not an authorized constructor
	    */
	    public static var notAuthorizedConstructor:String = "\"{0}\" is not an authorized constructor";
	    
	    /* Property: notAuthorizedExternalReference
	       "{0}" is not an authorized external reference
	    */
	    public static var notAuthorizedExternalReference:String = "\"{0}\" is not an authorized external reference";
	    
	    /* Property: notAuthorizedPath
	       "{0}" is not an authorized path
	    */
	    public static var notAuthorizedPath:String = "\"{0}\" is not an authorized path";
    	
	    /* Property: notValidFunction
	       "{0}" is not a valid function
	    */
	    public static var notValidFunction:String = "\"{0}\" is not a valid function";
	    
	    /* Property: errorFunction
	       bad function
	    */
	    public static var errorFunction:String = "bad function";
	    
	    /* Property: notFunctionCallAllowed
	       function call "{0}( {1} )"is not allowed
	    */
	    public static var notFunctionCallAllowed:String = "function call \"{0}( {1} )\"is not allowed";
	    
	    /* Property: notAuthorizedFunction
	       "{0}" is not an authorized function
	    */
	    public static var notAuthorizedFunction:String = "\"{0}\" is not an authorized function";
	    
	}
}