﻿/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <ekameleon@gmail.com> (2007-2008)

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
		
		/**
		 * The version of this Host object.
		 */
		public function get version():Version
		{
			return _version;
		}
		
		/**
		 * Indicates if the host of the application is a debugger.
		 */
		public function isDebug():Boolean
		{
			return Capabilities.isDebugger;
		}
		
		/**
		 * Returns the string representation of the object.
		 * @return the string representation of the object.
		 */
		public function toString():String
		{
			return id.toString( ) + " " + version.toString( 4 );
		}

		/**
		 * @private
		 */
		private var _id:HostID;
		
		/**
		 * @private
		 */
		private var _version:Version;
		
	}
}

