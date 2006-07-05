
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
*/

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
class buRRRn.eden.strings extends Object
    {
    
    /* StaticProperty: requirePairValue
       multiSerialize require pairs of values
    */
    static var requirePairValue:String = "multiSerialize require pairs of values";
    
    /* Property: pairIsIgnored
       name "{0}" is not a string, pair[{1},{2}] is ignored
    */
    static var pairIsIgnored:String = "name \"{0}\" is not a string, pair[{1},{2}] is ignored";
    
    /* Property: reservedKeyword
       "{0}" is a reserved keyword
    */
    static var reservedKeyword:String = "\"{0}\" is a reserved keyword";
    
    /* Property: futurReservedKeyword
       "{0}" is a future reserved keyword
    */
    static var futurReservedKeyword:String = "\"{0}\" is a future reserved keyword";
    
    /* Property: notValidPath
       "{0} is not a valid path
    */
    static var notValidPath:String = "\"{0}\" is not a valid path";
    
    /* Property: unterminatedComment
       unterminated comment
    */
    static var unterminatedComment:String = "unterminated comment";
    
    /* Property: errorComment
       syntax error (comment)
    */
    static var errorComment:String = "syntax error (comment)";
    
    /* Property: errorIdentifier
       bad identifier
    */
    static var errorIdentifier:String = "bad identifier";
    
    /* Property: notValidConstructor
       "{0}" is not a valid constructor
    */
    static var notValidConstructor:String = "\"{0}\" is not a valid constructor";
    
    /* Property: doesNotExist
       "{0}" does not exists
    */
    static var doesNotExist:String = "\"{0}\" does not exists";
    
    /* Property: errorConstructor
       bad constructor
    */
    static var errorConstructor:String = "bad constructor";
    
    /* Property: errorLineTerminator
       bad string (found line terminator in string)
    */
    static var errorLineTerminator:String = "bad string (found line terminator in string)";
    
    /* Property: errorString
       bad string (unterminated string)
    */
    static var errorString:String = "bad string (unterminated string)";
    
    /* Property: errorArray
       bad array (unterminated array)
    */
    static var errorArray:String = "bad array (unterminated array)";
    
    /* Property: errorObject
       bad object (unterminated object)
    */
    static var errorObject:String = "bad object (unterminated object)";
    
    /* Property: malformedHexadecimal
       bad number (malformed hexadecimal)
    */
    static var malformedHexadecimal:String = "bad number (malformed hexadecimal)";
    
    /* Property: errorNumber
       bad number (not finite)
    */
    static var errorNumber:String = "bad number (not finite)";
    
    /* Property: extRefDoesNotExist
       external reference "{0}" does not exists
    */
    static var extRefDoesNotExist:String = "external reference \"{0}\" does not exists";
    
    /* Property: errorKeyword
       syntax error
    */
    static var errorKeyword:String = "syntax error";
    
    /* Property: notAuthorizedConstructor
       "{0}" is not an authorized constructor
    */
    static var notAuthorizedConstructor:String = "\"{0}\" is not an authorized constructor";
    
    /* Property: notAuthorizedExternalReference
       "{0}" is not an authorized external reference
    */
    static var notAuthorizedExternalReference:String = "\"{0}\" is not an authorized external reference";
    
    /* Property: notAuthorizedPath
       "{0}" is not an authorized path
    */
    static var notAuthorizedPath:String = "\"{0}\" is not an authorized path";
    
    /* Property: notValidFunction
       "{0}" is not a valid function
    */
    static var notValidFunction:String = "\"{0}\" is not a valid function";
    
    /* Property: errorFunction
       bad function
    */
    static var errorFunction:String = "bad function";
    
    /* Property: notFunctionCallAllowed
       function call "{0}( {1} )"is not allowed
    */
    static var notFunctionCallAllowed:String = "function call \"{0}( {1} )\"is not allowed";
    
    /* Property: notAuthorizedFunction
       "{0}" is not an authorized function
    */
    static var notAuthorizedFunction:String = "\"{0}\" is not an authorized function";
    
    }

