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

// TODO unit tests

/**
 * Encrypt a string with the MD5 algorithm.
 * <p><b>Example :</b></p>
 * {@code
 * MD5 = calista.hash.MD5 ;
 *
 * var hash  = MD5.encrypt("calista") ;
 * var equal = hash == '93fc1e28bc17af6420552b746af10f4f' ;
 *
 * trace("'calista' MD5 result : " + hash + " : " + equal ) ;
 * }
 * <p>Original Javascript implementation :</p>
 * RSA Data Security, Inc. MD5 Message Digest Algorithm, as defined in RFC 1321.
 * Version 2.1 Copyright Paul Johnston 1999 - 2002
 * Other contributors: Greg Holt, Andrew Kepert, Ydnar, Lostinet
 * See http://pajhome.org.uk/crypt/md5 for more info.
 * @author eKameleon
 */
if ( calista.hash.MD5 == undefined ) 
{

	/**
	 * Creates the MD5 singleton.
	 */
	calista.hash.MD5 = {} ;
	
	/**
	 * Encrypt the specified text with the MD5 algorithm.
 	 * <p><b>Example :</b></p>
 	 * {
 	 * MD5 = calista.hash.MD5 ;
 	 * 
 	 * var hash = MD5.encrypt("calista") ;
 	 * var equal = hash == '93fc1e28bc17af6420552b746af10f4f' ;
 	 * 
 	 * trace("'calista' MD5 result : " + hash + " : " + equal ) ;
 	 * }
	 */
	calista.hash.MD5.encrypt = function( str /*String*/ ) /*String*/
	{
		var MD5 = calista.hash.MD5 ;
		return MD5.binl2hex( MD5.hash( MD5.str2binl(str) , str.length * 8 ) ) ;
	}

	/**
	 * @private
	 */
	calista.hash.MD5.bit_rol = function(num /*Number*/ , cnt /*Number*/ ) /*Number*/ 
	{
		return (num << cnt) | (num >>> (32-cnt));
	}

	/**
	 * @private
	 */
	calista.hash.MD5.cmn = function(q /*Number*/, a /*Number*/, b /*Number*/, x /*Number*/, s /*Number*/, t /*Number*/) /*Number*/ 
	{
		var MD5 = calista.hash.MD5 ;
		return MD5.safe_add( MD5.bit_rol( MD5.safe_add( MD5.safe_add(a, q), MD5.safe_add(x, t)), s), b);
	}

	/**
	 * @private
	 */	
	calista.hash.MD5.hash = function(x /*Array*/, len /*Number*/) /*Array*/ 
	{
		
		var MD5 = calista.hash.MD5 ;
		
		x[len >> 5] |= 0x80 << ((len)%32) ;
		x[(((len+64) >>> 9) << 4)+14] = len ;
		var a /*Number*/ = 1732584193  ;
		var b /*Number*/ = -271733879  ;
		var c /*Number*/ = -1732584194 ;
		var d /*Number*/ = 271733878   ;
		for (var i /*Number*/ = 0; i<x.length; i += 16) 
		{
			
			var olda /*Number*/ = a ;
			var oldb /*Number*/ = b ;
			var oldc /*Number*/ = c ;
			var oldd /*Number*/ = d ;
			
			a = MD5.ff(a, b, c, d, x[i+0], 7, -680876936);
			d = MD5.ff(d, a, b, c, x[i+1], 12, -389564586);
			c = MD5.ff(c, d, a, b, x[i+2], 17, 606105819);
			b = MD5.ff(b, c, d, a, x[i+3], 22, -1044525330);
			a = MD5.ff(a, b, c, d, x[i+4], 7, -176418897);
			d = MD5.ff(d, a, b, c, x[i+5], 12, 1200080426);
			c = MD5.ff(c, d, a, b, x[i+6], 17, -1473231341);
			b = MD5.ff(b, c, d, a, x[i+7], 22, -45705983);
			a = MD5.ff(a, b, c, d, x[i+8], 7, 1770035416);
			d = MD5.ff(d, a, b, c, x[i+9], 12, -1958414417);
			c = MD5.ff(c, d, a, b, x[i+10], 17, -42063);
			b = MD5.ff(b, c, d, a, x[i+11], 22, -1990404162);
			a = MD5.ff(a, b, c, d, x[i+12], 7, 1804603682);
			d = MD5.ff(d, a, b, c, x[i+13], 12, -40341101);
			c = MD5.ff(c, d, a, b, x[i+14], 17, -1502002290);
			b = MD5.ff(b, c, d, a, x[i+15], 22, 1236535329);
			a = MD5.gg(a, b, c, d, x[i+1], 5, -165796510);
			d = MD5.gg(d, a, b, c, x[i+6], 9, -1069501632);
			c = MD5.gg(c, d, a, b, x[i+11], 14, 643717713);
			b = MD5.gg(b, c, d, a, x[i+0], 20, -373897302);
			a = MD5.gg(a, b, c, d, x[i+5], 5, -701558691);
			d = MD5.gg(d, a, b, c, x[i+10], 9, 38016083);
			c = MD5.gg(c, d, a, b, x[i+15], 14, -660478335);
			b = MD5.gg(b, c, d, a, x[i+4], 20, -405537848);
			a = MD5.gg(a, b, c, d, x[i+9], 5, 568446438);
			d = MD5.gg(d, a, b, c, x[i+14], 9, -1019803690);
			c = MD5.gg(c, d, a, b, x[i+3], 14, -187363961);
			b = MD5.gg(b, c, d, a, x[i+8], 20, 1163531501);
			a = MD5.gg(a, b, c, d, x[i+13], 5, -1444681467);
			d = MD5.gg(d, a, b, c, x[i+2], 9, -51403784);
			c = MD5.gg(c, d, a, b, x[i+7], 14, 1735328473);
			b = MD5.gg(b, c, d, a, x[i+12], 20, -1926607734);
			a = MD5.hh(a, b, c, d, x[i+5], 4, -378558);
			d = MD5.hh(d, a, b, c, x[i+8], 11, -2022574463);
			c = MD5.hh(c, d, a, b, x[i+11], 16, 1839030562);
			b = MD5.hh(b, c, d, a, x[i+14], 23, -35309556);
			a = MD5.hh(a, b, c, d, x[i+1], 4, -1530992060);
			d = MD5.hh(d, a, b, c, x[i+4], 11, 1272893353);
			c = MD5.hh(c, d, a, b, x[i+7], 16, -155497632);
			b = MD5.hh(b, c, d, a, x[i+10], 23, -1094730640);
			a = MD5.hh(a, b, c, d, x[i+13], 4, 681279174);
			d = MD5.hh(d, a, b, c, x[i+0], 11, -358537222);
			c = MD5.hh(c, d, a, b, x[i+3], 16, -722521979);
			b = MD5.hh(b, c, d, a, x[i+6], 23, 76029189);
			a = MD5.hh(a, b, c, d, x[i+9], 4, -640364487);
			d = MD5.hh(d, a, b, c, x[i+12], 11, -421815835);
			c = MD5.hh(c, d, a, b, x[i+15], 16, 530742520);
			b = MD5.hh(b, c, d, a, x[i+2], 23, -995338651);
			a = MD5.ii(a, b, c, d, x[i+0], 6, -198630844);
			d = MD5.ii(d, a, b, c, x[i+7], 10, 1126891415);
			c = MD5.ii(c, d, a, b, x[i+14], 15, -1416354905);
			b = MD5.ii(b, c, d, a, x[i+5], 21, -57434055);
			a = MD5.ii(a, b, c, d, x[i+12], 6, 1700485571);
			d = MD5.ii(d, a, b, c, x[i+3], 10, -1894986606);
			c = MD5.ii(c, d, a, b, x[i+10], 15, -1051523);
			b = MD5.ii(b, c, d, a, x[i+1], 21, -2054922799);
			a = MD5.ii(a, b, c, d, x[i+8], 6, 1873313359);
			d = MD5.ii(d, a, b, c, x[i+15], 10, -30611744);
			c = MD5.ii(c, d, a, b, x[i+6], 15, -1560198380);
			b = MD5.ii(b, c, d, a, x[i+13], 21, 1309151649);
			a = MD5.ii(a, b, c, d, x[i+4], 6, -145523070);
			d = MD5.ii(d, a, b, c, x[i+11], 10, -1120210379);
			c = MD5.ii(c, d, a, b, x[i+2], 15, 718787259);
			b = MD5.ii(b, c, d, a, x[i+9], 21, -343485551);
			a = MD5.safe_add(a, olda); 
			b = MD5.safe_add(b, oldb);
			c = MD5.safe_add(c, oldc); 
			d = MD5.safe_add(d, oldd);
		}
		return [ a, b, c, d ] ;
	}
	
	/**
	 * @private
	 */
	calista.hash.MD5.ff = function(a /*Number*/, b /*Number*/, c /*Number*/, d /*Number*/, x /*Number*/, s /*Number*/, t /*Number*/) /*Number*/ 
	{
		return calista.hash.MD5.cmn((b & c) | ((~b) & d), a, b, x, s, t);
	}

	/**
	 * @private
	 */
	calista.hash.MD5.gg = function(a /*Number*/, b /*Number*/, c /*Number*/, d /*Number*/, x /*Number*/, s /*Number*/, t /*Number*/) /*Number*/ 
	{
		return calista.hash.MD5.cmn((b & d) | (c & (~d)), a, b, x, s, t);
	}
	
	/**
	 * @private
	 */
	calista.hash.MD5.hh = function(a /*Number*/, b /*Number*/, c /*Number*/, d /*Number*/, x /*Number*/, s /*Number*/, t /*Number*/) /*Number*/ 
	{
		return calista.hash.MD5.cmn(b ^ c ^ d, a, b, x, s, t);
	}

	/**
	 * @private
	 */
	calista.hash.MD5.ii = function(a /*Number*/, b /*Number*/, c /*Number*/, d /*Number*/, x /*Number*/, s /*Number*/, t /*Number*/) /*Number*/ 
	{
		return calista.hash.MD5.cmn(c ^ (b | (~d)), a, b, x, s, t);
	}
	
	/**
	 * @private
	 */
	calista.hash.MD5.safe_add = function(x /*Number*/, y /*Number*/) /*Number*/ 
	{
		var lsw /*Number*/ = (x & 0xFFFF)+(y & 0xFFFF);
		var msw /*Number*/ = (x >> 16)+(y >> 16)+(lsw >> 16);
		return (msw << 16) | (lsw & 0xFFFF);
	}
	
	/**
	 * @private
	 */
	calista.hash.MD5.str2binl = function(str /*String*/) /*Array*/ 
	{
		str = new String(str) ;
		var bin    /*Array*/  = new Array();
		var mask   /*Number*/ = (1 << 8)-1;
		var size   /*Number*/ = str.length * 8 ;
		for (var i /*Number*/ = 0 ; i<size ; i += 8 ) 
		{
			bin[i >> 5] |= (str.charCodeAt(i/8) & mask) << (i%32);
		}
		return bin;
	}
	
	/**
	 * @private
	 */
	calista.hash.MD5.binl2hex = function( binarray /*Array*/ ) /*String*/ 
	{
		var str /*String*/ = "" ;
		var tab /*String*/ = new String("0123456789abcdef");
		var size /*Number*/ = binarray.length * 4 ;
		for (var i /*Number*/ = 0; i<size; i++) 
		{
			str += tab.charAt((binarray[i >> 2] >> ((i%4)*8+4)) & 0xF) + tab.charAt((binarray[i >> 2] >> ((i%4)*8)) & 0xF);
		}
		return str;
	}	

}
