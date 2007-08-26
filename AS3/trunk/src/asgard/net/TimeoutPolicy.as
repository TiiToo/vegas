/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.net
{
	
	import vegas.core.CoreObject;
	import vegas.util.Serializer;
	
	public class TimeoutPolicy extends CoreObject
	{
		
		// ----o Constructor
		
		public function TimeoutPolicy( value:uint )
		{
			_value = value ;
		}

		// ----o Public Properties
	
		static public const INFINITY:TimeoutPolicy = new TimeoutPolicy(0) ;
			
		static public const LIMIT:TimeoutPolicy = new TimeoutPolicy(1) ;

		// -----o Public Methods
		
		override public function toSource(...arguments):String
		{
			return "new asgard.net.TimeOutPolicy(" + Serializer.toSource(_value) + ")" ;
		}
		
		override public function toString():String
		{
			return String(_value) ;	
		}
		
		public function valueOf():*
		{
			return _value ;
		}
		
		// ----o Private Properties
		
		private var _value:uint ;
		
	}
}