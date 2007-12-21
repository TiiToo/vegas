﻿/*
  
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2006)
	  Use this version only with Vegas AS3 Framework Please.

*/
package system
{
	import flash.system.Capabilities;
	
	/**
	 * The Host class.
	 */
	public class Host
	{

		/**
		 * Creates a new Host instance.
		 */
		public function Host( id:HostID, version:Version )
		{
			_id = id;
			_version = version;
		}
		
		/**
		 * Returns the id of the Host object.
		 * @return the id of the Host object.
		 */
		public function get id():HostID
		{
			return _id;
		}

		public function get version():Version
		{
			return _version;
		}

		public function isDebug():Boolean
		{
			return Capabilities.isDebugger;
		}

		public function toString():String
		{
			return id.toString( ) + " " + version.toString( 4 );
		}
		
		private var _id:HostID;

		private var _version:Version;
		
	}
}

