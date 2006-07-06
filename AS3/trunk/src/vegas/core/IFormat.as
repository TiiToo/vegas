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

/** IFormat [Interface]

	AUTHOR

		Name : IFormat
		Package : vegas.core
		Version : 1.0.0.0
		Date :  2006-07-05
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION : 
	
		interface qui permet d'implémenter une méthode qui va transformer n'importe quel objet en chaine de caractère.

	METHOD SUMMARY
	
		- formatToString(o):String

**/

package vegas.core
{
	public interface IFormat
	{
		function formatToString(o):String ;
	}
}