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

/* NetServerStatus

	AUTHOR

		Name : NetServerStatus
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-04-20
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- CLOSED:NetServerStatus ("closed")
		
		- FAILED:NetServerStatus ("failed")
		
		- INVALID:NetServerStatus ("invalidapp")
		
		- REJECTED:NetServerStatus ("rejected")
		
		- SHUTDOWN:NetServerStatus ("appshutdown")
		
		- SUCCESS:NetServerStatus ("success")

	METHOD SUMMARY
	
		- static format(code:String):String
		
		- toSource(indent : Number, indentor : String):String
		
		- toString():String
		
		- static validate(o):Boolean
		 
		- valueOf():*

*/

package asgard.net
{
	
	import vegas.core.CoreObject;

	public class NetServerStatus extends CoreObject
	{

		// ----o Constructor
		
		public function NetServerStatus( value:String )
		{
			_value = value ;
		}
	
		// ----o Constants
	
		static public const BAD_VERSION:NetServerStatus = new NetServerStatus("badversion") ;
		
		static public const CLOSED:NetServerStatus = new NetServerStatus("closed") ;
	
		static public const FAILED:NetServerStatus = new NetServerStatus("failed") ;
	
		static public const INVALID:NetServerStatus = new NetServerStatus("invalidapp") ;
		
		static public const REJECTED:NetServerStatus = new NetServerStatus("rejected") ;
		
		static public const SHUTDOWN:NetServerStatus = new NetServerStatus("appshutdown") ;
		
		static public const SUCCESS:NetServerStatus = new NetServerStatus("success") ;
		
		// ----o Public Methods
		
		/**
		 * Convert onStatus code value in NetConnection.onStatus in a ConnectionStatus valid string.
		 */
		static public function format(code:String):NetServerStatus 
		{
			code = code.split(".").pop().toLowerCase() ;
			var status:Array = [BAD_VERSION, CLOSED, FAILED, INVALID, REJECTED, SHUTDOWN, SUCCESS] ;
			var l:uint = status.length ;
			while(--l > -1) 
			{
				if (status[l].toString() == code) 
				{
					return status[l] ;	
				}
			}
			return null ;
		}

		override public function toSource(...arguments:Array):String 
		{
			return "new asgard.net.NetServerStatus(\"" + toString() + "\")" ;
		}

		override public function toString():String
		{
			return _value ;
		}

		static public function validate( o:* ):Boolean {
			var status:Array = [BAD_VERSION, CLOSED, FAILED, INVALID, REJECTED, SHUTDOWN, SUCCESS] ;
			return status.indexOf(o) > -1 ;	
		}	
		
		public function valueOf():*
		{
			return _value ;
		}
		
		// ----o Private Properties
		
		private var _value:String ;
		
	}
}