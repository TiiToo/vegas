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
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)
	  Use this version only with Vegas AS3 Framework Please.

*/
package system
{

	/**
	 * Represents information about an operating system, such as the version and platform identifier. 
	 * This class cannot be inherited.
	 */
	final public class OperatingSystem
	{

		/**
		 * Creates a new OperatingSystem instance.
		 */
		public function OperatingSystem( platform:PlatformID, version:Version )
		{
			_platform = platform;
			_version = version;
		}
		
		/**
		 * Returns the platform id of this operating system.
		 * @return the platform id of this operating system.
		 */
		public function get platform():PlatformID
		{
			return _platform;
		}

		/**
		 * Returns the version of this operating system.
		 * @return the version of this operating system.
		 */
		public function get version():Version
		{
			return _version;
		}
		
		/**
		 * Returns the String representation of the object.
		 * @return the String representation of the object.
		 */
		public function toString():String
		{
			return platform.toString( );
		}
		
		private var _platform:PlatformID;

		private var _version:Version;
		
	}
}
