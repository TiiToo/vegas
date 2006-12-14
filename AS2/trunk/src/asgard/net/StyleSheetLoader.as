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
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

import asgard.net.DataFormat;
import asgard.net.URLLoader;
import asgard.text.StyleSheet;

import vegas.errors.UnsupportedOperation;

/**
 * This loader is a simple ILoader to receive an external CSS style sheet.
 * @author eKameleon
 */
class asgard.net.StyleSheetLoader extends URLLoader
{

	/**
	 * Creates a new StyleSheetLoader instance.
	 */	
	function StyleSheetLoader() 
	{
		super();
	}

	/**
	 * Deserialize the source and transform it in a StyleSheet reference.
	 */
	public function deserializeData():Void 
	{
		setData( new StyleSheet( this.getData() )  ) ;
	}

	/**
	 * Unsupported method in the StyleSheetLoader. You can only load a string text in the external css file.
	 * @throws UnsupportedOperation this method is unsupported.
	 */
	public function setDataFormat( s:String ):Void 
	{
		if (s != DataFormat.TEXT)
		{
			throw new UnsupportedOperation( this + " the method setDataFormat is unsupported, the dataFormat is only a DataFormat.TEXT.") ;
		}
	}

}