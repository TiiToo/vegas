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

/** ObjectSerializer

	AUTHOR
	
		Name : ObjectSerializer
		Package : vegas.util.serialize
		Version : 1.0.0.0
		Date :  2005-12-23
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	DESCRIPTION
	
		EDEN Compatibility to serialize ECMAScript data.

	METHOD SUMMARY
	
		- toSource(o:Object, indent:Number, indentor:String):String
	
**/

import vegas.util.ArrayUtil;
import vegas.util.serialize.Serializer;

class vegas.util.serialize.ObjectSerializer {

	// ----o Construtor
	
	private function ObjectSerializer() {
		//
	}
	
	// ----o Static Methods

	static public function toSource(o:Object, indent:Number, indentor:String):String {
		var each:String ;
		var source:Array = [] ;
		if (indent != null) indent ++ ;
		for (each in o) {
			if ( o.hasOwnProperty(each) ) {
				if (o[each] === undefined) source.push( each + ":" + "undefined") ;
				else if (o[each] === null) source.push( each + ":" + "null") ;
				else source.push( each + ":" + Serializer.toSource(o[each], indent, indentor) ) ;
			}
		}
		if (indent == null) return "{" + source.join(",") + "}" ;
		if (indentor == null) indentor = "    " ;
		if(indent == null ) indent = 0;
		var decal:String = "\n" + ArrayUtil.initialize( indent, indentor ).join( "" ) ;
		return decal + "{" + decal + source.join( "," + decal ) + decal + "}" ;
    }

}