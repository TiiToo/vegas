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
    
	/**
	 * Defines the NetServer status.
	 * @author eKameleon
	 */
	public class NetServerStatus extends CoreObject
	{

        /**
         * Creates a new NetServerStatus instance.
	 	 * @param s the String value of this object.
         */ 
		public function NetServerStatus( value:String )
		{
			_value = value ;
		}
	
		/**
	 	 * Packet encoded in an unidentified format.
	 	 */	
		public static const BAD_VERSION:NetServerStatus = new NetServerStatus("badversion") ;
		
		/**
	 	 * The connection was closed successfully.
	 	 */
		public static const CLOSED:NetServerStatus = new NetServerStatus("closed") ;

		/**
		 * The connection attempt failed or the NetConnection.call method was not able to invoke the server-side method or command.
		 */
		public static const FAILED:NetServerStatus = new NetServerStatus("failed") ;

		/**
		 * The application name specified during connect is invalid.
		 */
		public static const INVALID:NetServerStatus = new NetServerStatus("invalidapp") ;
		
		/**
	 	 * The connection attempt did not have permission to access the application.
	 	 */
		public static const REJECTED:NetServerStatus = new NetServerStatus("rejected") ;
		
		/**
	 	 *  The specified application is shutting down.
	 	 */
		public static const SHUTDOWN:NetServerStatus = new NetServerStatus("appshutdown") ;
	
		/**
	 	 * The connection attempt succeeded.
	 	 */
		public static const SUCCESS:NetServerStatus = new NetServerStatus("success") ;

		/**
	 	 * Compares the specified object with this object for equality.
	 	 * @return {@code true} if the the specified object is equal with this object.
	 	 */
		public function equals( o:* ):Boolean
		{
			return o.valueOf() == valueOf() ;	
		}

		/**
		 * Convert onStatus code value in NetConnection.onStatus in a ConnectionStatus valid string.
		 */
		public static function format(code:String):NetServerStatus 
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

		/**
		 * Returns the Eden String representation of this object.
		 * @return the Eden String representation of this object.
		 */
		public override function toSource(...arguments:Array):String 
		{
			return "new asgard.net.NetServerStatus(\"" + toString() + "\")" ;
		}
		
		/**
		 * Returns the String representation of the object.
		 * @return the String representation of the object.
		 */
		public override function toString():String
		{
			return _value ;
		}

		/**
		 * Validate if the specified object is a valid status value.
		 * @return {@code true} if the specified object is a valid status value.
		 */
		public static function validate( o:* ):Boolean 
		{
			var status:Array = [BAD_VERSION, CLOSED, FAILED, INVALID, REJECTED, SHUTDOWN, SUCCESS] ;
			return status.indexOf(o) > -1 ;	
		}	
		
		/**
		 * Returns the primitive value of this object.
		 * @return the primitive value of this object.
		 */
		public function valueOf():*
		{
			return _value ;
		}
		
		private var _value:String ;
		
	}
}