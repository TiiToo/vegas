/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Luna Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** StageLocalizer

	AUTHOR
		
		Name : StageLocalizer
		Package : asgard.display
		Version : 1.0.0.0
		Date :  2003-03-25
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION :

		Classe statique. Permet de définir la position d'un point selon 
		le référentiel défini par la propriété Stage.align courante.

	STATIC PROPRERTIES

		- WIDTH : propriété en lecture seule. Retourne la largeur initiale de la scène principale.

		- HEIGHT : propriété en lecture seule. Retourne la hauteur initiale de la scène principale.


	STATIC METHODS :
	
		- getMiddle() : Renvoi un point ayant pour coordonnées x et y le centre de la scène.
	
		- localizePoint (p:Object) : String
			Description : Méthode statique.
				Cette méthode renvoie une chaine de caractère
				Retourne la position d'un point dans la scène principale en fonction du référentiel courant défini par la propriété Stage.align.

			argument : un objet définissant un point de coordonnée x et y.
			renvoi :
				- "B" : Bottom
				- "T" : Top
				- "L" : Left
				- "R" : Right
				- "TL" : Top Left
				- "TR" : Top Right
				- "BL" : Bottom Left
				- "BR" : Bottom Right
				- "" : Center
		- getMirror  (position:String) : String
			Decription : renvoi la position mirroir dans la scène d'une position donnée.
			Exemple :
				- "T" renvoi "R" ;
				- "B" renvoi "T" ;
				- "TR" renvoi "BL" ;
				- "TL" renvoi "BR" ;
				- "BR" renvoi "TL" ;
				- "BL" renvoi "TR" ;
				- "L" renvoi "R" ;
				- "R" renvoi "L" ;
				- "" renvoi "" ;

**/

import asgard.display.StageAlign;

class asgard.display.StageLocalizer {
	
	// ----o Constructor

	private function StageLocalizer () {
		//
	}

	// ----o INIT

	static public var WIDTH = Stage.width ;
	static public var HEIGHT = Stage.height ;

	// ----o Public Methods

	static public function localizePoint(point):String {
		_curX = point.x ;
		_curY = point.y ;
		_setMiddle () ;
		_setPos () ;
		return _pos  ;
	}

	static public function getMiddle(Void):Object {
		_setMiddle () ;
		return { x:_x , y:_y } ;
	}
	
	static public function getVerticalMirror(point):String {
		var align:String = localizePoint(point) ;
		switch (align.toUpperCase () ) {
			case "TR" : return "BR" ;
			case "TL" : return "BL" ;
			case "BR" : return "TR" ;
			case "BL" : return "TL" ;
			case "L" : return "R" ;
			case "R" : return "L" ;
			default : return "" ;
		}
	}
	
	static public function getMirror(pos:String):String {
		switch (pos.toUpperCase () ) {
			case "T" : return "R" ;
			case "B" : return "T" ;
			case "TR" : return "BL" ;
			case "TL" : return "BR" ;
			case "BR" : return "TL" ;
			case "BL" : return "TR" ;
			case "L" : return "R" ;
			case "R" : return "L" ;
			default : return "" ;
		}
	}

	// ----o Private Methods

	static private var _curX:Number ;
	static private var _curY:Number ;
	static private var _pos:String ;
	static private var _x:Number  ;
	static private var _y:Number ;
	
	// ----o Private Methods

	static private function _setMiddle () : Void {
		switch (Stage.align) {
			
			case StageAlign.BOTTOM : // bottom
				_x = WIDTH / 2 ;
				_y = -  ((Stage.height / 2) - HEIGHT)  ;
				break ;
			
			case StageAlign.BOTTOM_LEFT : // bottom left
				_x = Stage.width / 2 ;
				_y = -  ((Stage.height / 2) - HEIGHT)  ;
				break ;

			case StageAlign.BOTTOM_RIGHT : // bottom right
				_x =  - (Stage.width - WIDTH) + Stage.width  / 2   ;
				_y = -  ((Stage.height / 2) - HEIGHT)  ;
				break ;
				
			case StageAlign.LEFT : // left
				_x = Stage.width / 2 ;
				_y = HEIGHT / 2  ;
				break ;
				
			case StageAlign.RIGHT : // right
				_x =  - (Stage.width - WIDTH) + Stage.width  / 2   ;
				_y = HEIGHT / 2  ;
				break ;
			
			case StageAlign.TOP : // top
				_x = WIDTH / 2 ;
				_y = Stage.height / 2 ;
				break ;
			
			
			case StageAlign.TOP_LEFT : // top left
				_x = Stage.width / 2 ;
				_y = Stage.height / 2 ;
				break ;
			
			case StageAlign.TOP_RIGHT : // top right
				_x =  - (Stage.width - WIDTH) + Stage.width  / 2   ;
				_y = Stage.height / 2 ;
				break ;
			
			default : 
				_x = WIDTH / 2 ;
				_y =  HEIGHT / 2 ;
		}
	}

	static private function _setPos () : Void {
		if (_curX == undefined && _curY == undefined) { _pos = "" ; return ; }
		if  (_curX > _x && _curY > _y) _pos =  "BR" ;
		else if  ( _curX < _x && _curY > _y ) _pos = "BL" ;
		else if  ( _curX > _x && _curY < _y) _pos =  "TR" ;
		else if  ( _curX < _x && _curY < _y ) _pos =  "TL" ;
		else if  ( _curX == _x && _curY > _y ) _pos = "B" ;
		else if  ( _curX == _x && _curY < _y ) _pos = "T" ;
		else if  ( _curX < _x && _curY == _y ) _pos = "L" ;
		else _pos = "R" ;
	}

}