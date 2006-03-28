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

/** ------ JSONLoader

	AUTHOR

		Name : JSONLoader
		Package : asgard.system
		Version : 1.0.0.0
		Date :  2006-03-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : contact@ekameleon.net

	DESCRIPTION
	
		Dynamic Class

	INHERIT
	
		CoreObject
			|
			AbstractCoreEventDispatcher
			 |
			 AbstractLoader
			 	|
			 	URLLoader
			 		|
			 		JSONLoader
			 	
	IMPLEMENTS
	
		EventTarget, IFormattable, IHashable, IEventDispatcher, ILoader
	
----------  */	

import asgard.net.DataFormat;
import asgard.net.URLLoader;

import vegas.string.JSON;

// TODO tester fieldName et DataFormat.VARIABLES

/**
 * @author eKameleon
 */
class asgard.net.JSONLoader extends URLLoader {
	
	// ----o Constructor
	
	function JSONLoader() {
		super() ;
	}

	// ----o Public Properties
	
	public var fieldName:String ;

	// ----o Public Methods

	public function deserializeData():Void {
		
		var source:String ;
		
		switch (getDataFormat()) {

				case DataFormat.VARIABLES :

					source = this.getData()[fieldName] ;
					
					break ;

				case DataFormat.BINARY :
				case DataFormat.TEXT :

					source = this.getData() ;
					
					break ;

		}
		setData( JSON.deserialize( source )  ) ;
		
	}

	public function getJSON() {
		return _oJSON ;	
	}

	private var _oJSON ;

}