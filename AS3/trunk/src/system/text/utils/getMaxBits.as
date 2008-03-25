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
	 * Computes the number of bits in an int. The  normal answer for JavaScript and ActionScript is 32.
	 * @return The Max bits value.
   	 */
	internal function getMaxBits():Number 
  		{
    		var maxbits:int = 0 ;
    		var oldi:int    = 1 ;
    		var newi:int    = 2 ;
    		while( oldi != newi ) 
    			{
      			maxbits++ ;
      			oldi = newi ;
      			newi = newi << 1 ;
    			}
    		return maxbits;
		} 
	}
