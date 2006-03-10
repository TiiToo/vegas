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

/* ---------------- Luhn

	AUTHOR
	
		Name : 	Luhn
		Package : vegas.string
		Version : 1.0.0.0
		Date :  2005-09-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Algorithme "module 10" ou "mod 10", développé en 1960 pour valider l'identification de certains nombres.
		
		La méthode consiste en une simple formule de vérification de somme (CheckSum) et permet de valider
		par exemple les numéros de carte de crédit, certains numéros de comptes etc.
		
		L'algorithme fait parti du domaine public. 
		Il n'a aucun but au niveau de la sécurisation des données,
		il permet surtout l'utilisation de nombres aléatoires.
		
	USE
	
		Luhn.isValid( str:String )
	
	METHODS
	
		- isValid(str:String):Boolean
	
	EXAMPLE
	
		import vegas.string.Luhn ;
		
		var code:String = "456565654" ;
		trace (code + " isValid : " + Luhn.isValid(code)) ;

	THANKS : 
	
		ShoeBox : http://www.shoe-box.org/blog/
	
		Formule de Luhn : http://fr.wikipedia.org/wiki/Formule_de_Luhn

-------------------- */

class vegas.string.Luhn {

	// ----o Constructor
	
	private function Luhn() {
		//
	}
	
	// ----o Statics
	
	static public function isValid(str:String):Boolean {	
		str = new String(str) ;
		var	n:Number ;
		var sum:Number = 0 ;
		var l:Number = str.length ;
		for (var i:Number = 0 ; i<l ; i++){
			n = Number(str.charAt(i)) * ( i%2 == 1 ? 2 : 1) ;
			sum += n - ((n > 9) ? 9 : 0) ;
		}
		return sum%10 == 0 ;
	}

}

