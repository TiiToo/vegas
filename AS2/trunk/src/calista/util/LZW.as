/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is CalistA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/**
 * Compresses and decompresses text with the LZW algorithm.
 * @author eKameleon
 */
class calista.util.LZW 
{

	/**
	 * Compresses the specified text.
 	 * <p><b>Example :</b></p>
 	 * {@code
 	 * import calista.util.LZW ;
 	 * 
 	 * var source:String = "hello world with LZW algorithm" ;
 	 * 
 	 * var compress:String = LZW.compress( source ) ;
 	 * trace("compress : " + compress) ;
 	 * }
	 */
	public static function compress( str:String ):String
	{
		var i:Number    ;
		var size:Number ;
		var xstr:String;
		var chars:Number = 256;
		var original:String = new String(str) ;
		var dict:Array = new Array();
		for ( i = 0 ; i<chars ; i++ ) 
		{
			dict[String(i)] = i;
		}
		var current:String ;
		var result:String = new String("");
		var splitted:Array = original.split("");
		var buffer:Array = new Array();
		size = splitted.length ;
		for ( i = 0 ; i<=splitted.length ; i++) 
		{
			current = new String(splitted[i]) ;
			xstr = (buffer.length == 0) ? String(current.charCodeAt(0)) : buffer.join("-")+"-"+String(current.charCodeAt(0));
			if (dict[xstr] !== undefined)
			{
				buffer.push(current.charCodeAt(0));
			} 
			else 
			{
				result += String.fromCharCode(dict[buffer.join("-")]);
				dict[xstr] = chars;
				chars++;
				buffer = new Array();
				buffer.push(current.charCodeAt(0));
			}
		}
		return result;
	}

	/**
	 * Decompresses the specified text with the LZW algorithm.
 	 * <p><b>Example :</b></p>
 	 * {@code
 	 * import calista.util.LZW ;
 	 * 
 	 * var source:String = "hello world with LZW algorithm" ;
 	 * 
 	 * var compress:String = LZW.compress( source ) ;
 	 * trace("compress : " + compress) ;
 	 * 
 	 * var decompress:String = LZW.decompress( compress ) ;
 	 * trace("decompress : " + decompress) ;
 	 * }
	 */
	public static function decompress( str:String ):String
	{
		var i:Number ;
		var chars:Number = 256;
		var dict:Array = new Array();
		for (i = 0; i<chars; i++) 
		{
			dict[i] = String.fromCharCode(i);
		}
		var original:String = new String(str) ;
		var splitted:Array  = original.split("");
		var size:Number     = splitted.length ;
		var buffer:String   = new String("");
		var chain:String    = new String("");
		var result:String   = new String("");
		for ( i = 0; i<size ; i++ ) 
		{
			var code:Number    = original.charCodeAt(i);
			var current:String = dict[code];
			if (buffer == "") 
			{
				buffer = current;
				result += current;
			}
			else 
			{
				if (code<=255) 
				{
					result += current ;
					chain   = buffer + current ;
					dict[chars] = chain ;
					chars++ ;
					buffer = current ;
				} 
				else 
				{
					chain = dict[code];
					if (chain == undefined) 
					{
						chain = buffer + buffer.slice(0,1) ;
					}
					result += chain;
					dict[chars] = buffer + chain.slice(0,1);
					chars++;
					buffer = chain;
				}
			}
		}
		return result;
	}
	
}
