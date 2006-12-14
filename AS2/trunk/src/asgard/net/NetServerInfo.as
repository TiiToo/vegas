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

/** NetServerInfo

	AUTHOR

		Name : NetServerInfo
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-06-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	PROPERTY SUMMARY

		- code:String
		
		- description:String
		
		- level:String

	METHOD SUMMARY
	
		- hashCode():Number
		
		- toObject():Object
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String

	INHERIT
	
		Object → CoreObject → NetServerInfo
	
	IMPLEMENT
	
		IFormattable, IHashable, ISerializable

**/

import vegas.core.CoreObject;
import vegas.util.serialize.Serializer;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.net.NetServerInfo extends CoreObject 
{
	
	// ----o Constructor
	
	public function NetServerInfo( oInfo ) 
	{
		
		description = oInfo.description || null ;
		
		code = oInfo.code || null ;
		
		level = oInfo.level || null ;
		
		_oInfo = toObject() ;
		
	}

	// ----o Public Properties
	
	public var code:String ;
	public var description:String ;
	public var level:String ;

	// ----o Public Methods

	public function toObject():Object 
	{
		
		return { description:description, code:code, level:level } ;
			
	}

	public function toSource(indent : Number, indentor : String):String 
	{
		return "new asgard.net.NetServerInfo(" + Serializer.toSource(toObject()) + ")" ;
	}

	// ----o Private Properties
	
	private var _oInfo ;

}