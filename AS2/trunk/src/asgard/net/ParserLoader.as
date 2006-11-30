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

import asgard.net.DataFormat;
import asgard.net.URLLoader;

/**
 * @author eKameleon
 */
class asgard.net.ParserLoader extends URLLoader 
{
	
	/**
	 * Creates a new ParserLoader instance.
	 */
	private function ParserLoader() 
	{
		super() ;
	}

	public var fieldName:String ;

	public function deserializeData():Void 
	{
		
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
		
		var deserialize:Function = getDeserializer() ;
		setData( deserialize( source )  ) ;
		
	}
	
	public function getDeserializer():Function 
	{
		return null ;	
	}

}