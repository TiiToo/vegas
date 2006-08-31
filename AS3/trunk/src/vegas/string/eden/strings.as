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
		static public var requirePairValue:String = "multiSerialize require pairs of values";
		
	    /* Property: pairIsIgnored
			name "{0}" is not a string, pair[{1},{2}] is ignored
		*/
	    static public var pairIsIgnored:String = "name \"{0}\" is not a string, pair[{1},{2}] is ignored";
	    
	    /* Property: reservedKeyword
	       "{0}" is a reserved keyword
	    */
	    static public var reservedKeyword:String = "\"{0}\" is a reserved keyword";
	    
	    /* Property: futurReservedKeyword
	       "{0}" is a future reserved keyword
	    */
	    static public var futurReservedKeyword:String = "\"{0}\" is a future reserved keyword";
	    
	    /* Property: notValidPath
	       "{0} is not a valid path
	    */
	    static public var notValidPath:String = "\"{0}\" is not a valid path";
	    
	    /* Property: unterminatedComment
	       unterminated comment
	    */
	    static public var unterminatedComment:String = "unterminated comment";
	    
	    /* Property: errorComment
	       syntax error (comment)
	    */
	    static public var errorComment:String = "syntax error (comment)";
	    
	    /* Property: errorIdentifier
	       bad identifier
	    */
	    static public var errorIdentifier:String = "bad identifier";
	    
	    /* Property: notValidConstructor
	       "{0}" is not a valid constructor
	    */
	    static public var notValidConstructor:String = "\"{0}\" is not a valid constructor";
	    
	    /* Property: doesNotExist
	       "{0}" does not exists
	    */
	    static public var doesNotExist:String = "\"{0}\" does not exists";
	    
	    /* Property: errorConstructor
	       bad constructor
	    */
	    static public var errorConstructor:String = "bad constructor";
	    
	    /* Property: errorLineTerminator
	       bad string (found line terminator in string)
	    */
	    static public var errorLineTerminator:String = "bad string (found line terminator in string)";
	    
	    /* Property: errorString
	       bad string (unterminated string)
	    */
	    static public var errorString:String = "bad string (unterminated string)";
	    
	    /* Property: errorArray
	       bad array (unterminated array)
	    */
	    static public var errorArray:String = "bad array (unterminated array)";
	    
	    /* Property: errorObject
	       bad object (unterminated object)
	    */
	    static public var errorObject:String = "bad object (unterminated object)";
	    
	    /* Property: malformedHexadecimal
	       bad number (malformed hexadecimal)
	    */
	    static public var malformedHexadecimal:String = "bad number (malformed hexadecimal)";
	    
	    /* Property: errorNumber
	       bad number (not finite)
	    */
	    static public var errorNumber:String = "bad number (not finite)";
	    
	    /* Property: extRefDoesNotExist
	       external reference "{0}" does not exists
	    */
	    static public var extRefDoesNotExist:String = "external reference \"{0}\" does not exists";
	    
	    /* Property: errorKeyword
		       syntax error
	    */
	    static public var errorKeyword:String = "syntax error";
	    
	    /* Property: notAuthorizedConstructor
	       "{0}" is not an authorized constructor
	    */
	    static public var notAuthorizedConstructor:String = "\"{0}\" is not an authorized constructor";
	    
	    /* Property: notAuthorizedExternalReference
	       "{0}" is not an authorized external reference
	    */
	    static public var notAuthorizedExternalReference:String = "\"{0}\" is not an authorized external reference";
	    
	    /* Property: notAuthorizedPath
	       "{0}" is not an authorized path
	    */
	    static public var notAuthorizedPath:String = "\"{0}\" is not an authorized path";
    	
	    /* Property: notValidFunction
	       "{0}" is not a valid function
	    */
	    static public var notValidFunction:String = "\"{0}\" is not a valid function";
	    
	    /* Property: errorFunction
	       bad function
	    */
	    static public var errorFunction:String = "bad function";
	    
	    /* Property: notFunctionCallAllowed
	       function call "{0}( {1} )"is not allowed
	    */
	    static public var notFunctionCallAllowed:String = "function call \"{0}( {1} )\"is not allowed";
	    
	    /* Property: notAuthorizedFunction
	       "{0}" is not an authorized function
	    */
	    static public var notAuthorizedFunction:String = "\"{0}\" is not an authorized function";
	    
	}
}