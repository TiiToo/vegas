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

/** ------ Locale

	AUTHOR

		Name : Locale
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-02-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	DESCRIPTION
	
		Cette classe permet de stocker toutes les propriétés récupérées dans un fichier de configuration externe.
		
	INHERIT
	
		CoreObject
			|
			Locale
	
	IMPLEMENTS
	
		IFormattable, IHashable
	
----------  */	

import vegas.core.CoreObject ;

/**
 * @author eKameleon
 */

dynamic class asgard.system.Locale extends CoreObject {
	
	// ----o Constructor
	
	public function Locale() {
		super();
	}

}