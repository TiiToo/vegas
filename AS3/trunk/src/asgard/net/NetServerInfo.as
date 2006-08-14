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

/* NetServerInfo

	AUTHOR

		Name : NetServerInfo
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-08-14
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
		
*/

package asgard.net
{

	import vegas.core.CoreObject;
	import vegas.util.Serializer ;

	public class NetServerInfo extends CoreObject
	{
		
		// ----o Constructor
		
		public function NetServerInfo( oInfo:*=null )
		{

			if (oInfo != null)
			{

				description = oInfo.description ;
			
				code = oInfo.code ;
			
				level = oInfo.level ;
			}
		
			_oInfo = toObject() ;
		
		}

		// ----o Public Properties
	
		public var code:String = null ;
		public var description:String = null ;
		public var level:String = null ;

		// ----o Public Methods
	
		public function toObject():Object 
		{
			
			return { description:description, code:code, level:level } ;
			
		}

		override public function toSource(...arguments):String 
		{
			return "new asgard.net.NetServerInfo(" + Serializer.toSource(toObject()) + ")" ;
		}

		// ----o Private Properties
	
		private var _oInfo:Object ;
		
	}
}