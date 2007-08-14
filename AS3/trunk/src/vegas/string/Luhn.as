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
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.string
{
	public class Luhn
	{
		
		static public function isValid(str:String):Boolean 
		{	
			var	n:Number ;
			var sum:uint = 0 ;
			var l:uint = str.length ;
			for (var i:uint = 0 ; i<l ; i++)
			{
				n = Number(str.charAt(i)) * ( i%2 == 1 ? 2 : 1) ;
				sum += n - ((n > 9) ? 9 : 0) ;
			}
			return sum%10 == 0 ;
		}
		
	}
}