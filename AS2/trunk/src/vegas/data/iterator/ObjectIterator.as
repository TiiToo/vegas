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

/* ------- 	ObjectIterator

	AUTHOR
	
		Name : ObjectIterator
		Package : vegas.data.iterator
		Version : 1.0.0.0
		Date :  2005-11-03
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		Permet de parcourir les attributs d'un objet à condition que les attributs soient énumérables."
		PS : iterator d'objets (plus lent qu'un for..in classique)

	METHOD SUMMARY
	
		- hasNext()
		
			renvoi true si il existe encore une propriété dans l'objet
		
		- index()
			
			récupère la position du pointeur 
		
		- key()
		
			récupère le nom de l'attribut en cours aprés un it.next()
		
		- next()
		
			récupère le prochain attribut dans l'objet
		
		- remove()
		
			supprime une propriété aprés un it.next()
		
		- reset()
		
			Réinitialise l'iterator
		
		- seek() 
		
			Permet de changer l'index de l'iterator (entre 0 et nombre de propriétés dans l'objet)

	INHERIT
	
		CoreObject
			|
			StringIterator

	IMPLEMENTS
	
		IFormattable, IHashable, Iterator

----------  */

import vegas.core.CoreObject;
import vegas.data.iterator.Iterator;
import vegas.util.MathsUtil;

class vegas.data.iterator.ObjectIterator extends CoreObject implements Iterator {

	// ----o Construtor
	
	public function ObjectIterator(o) {
		_o = o ;
		_a = new Array ;
		_k = -1 ;
		for (var each:String in o) if (typeof(o[each]) != "function") _a.push(each) ;
		_len = _a.length ;
	}
	
	// ----o Public Methods
	
	public function hasNext():Boolean {
		return _k <  (_len - 1) ;
	}

	public function index():Number {
		return _k ;
	}

	public function key() {
		return _a[_k] ;
	}

	public function next() {
		return _o[ _a[++_k] ] ;
	}
	
	public function remove() {
		var p:String = _a[_k] ;
		_a.splice(_k--, 1) ;
		delete _o[p] ;
		_len -- ;
		return p ;
	}
	
	public function reset():Void {
		_k = -1 ;
	}
	
	public function seek(n:Number):Void {
		_k = MathsUtil.clamp ((n-1), -1, _len) ;
	}
	
	// ----o Private Properties
	
	private var _a:Array ;
	private var _k:Number ;
	private var _o ;
	private var _len:Number ;
	
}