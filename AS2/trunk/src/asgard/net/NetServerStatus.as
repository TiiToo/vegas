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

/** NetServerStatus

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
		
		- static validate(o):Boolean

**/

import vegas.core.ISerializable;
import vegas.util.ArrayUtil;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.net.NetServerStatus extends String implements ISerializable 
{
	
	// ----o Constructor
	
	public function NetServerStatus( s:String ) 
	{
		super(s) ;
	}

	// ----o Constants
	
	static public var BAD_VERSION:NetServerStatus = new NetServerStatus("badversion") ;
	
	static public var CLOSED:NetServerStatus = new NetServerStatus("closed") ;

	static public var FAILED:NetServerStatus = new NetServerStatus("failed") ;

	static public var INVALID:NetServerStatus = new NetServerStatus("invalidapp") ;
	
	static public var REJECTED:NetServerStatus = new NetServerStatus("rejected") ;
	
	static public var SHUTDOWN:NetServerStatus = new NetServerStatus("appshutdown") ;
	
	static public var SUCCESS:NetServerStatus = new NetServerStatus("success") ;

	static private var __ASPF__ = _global.ASSetPropFlags(NetServerStatus, null , 7, 7) ;

	// ----o Public Methods

	/**
	 * Convert onStatus code value in NetConnection.onStatus in a ConnectionStatus valid string.
	 */
	static public function format(code:String):NetServerStatus 
	{
		code = code.split(".").pop().toLowerCase() ;
		var status:Array = [BAD_VERSION, CLOSED, FAILED, INVALID, REJECTED, SHUTDOWN, SUCCESS] ;
		var l:Number = status.length ;
		while(--l > -1) {
			if (status[l].toString() == code) return status[l] ;	
		}
	}

	public function toSource(indent : Number, indentor : String):String 
	{
		return "new asgard.net.NetServerStatus(\"" + toString() + "\")" ;
	}

	static public function validate( o ):Boolean 
	{
		var status:Array = [BAD_VERSION, CLOSED, FAILED, INVALID, REJECTED, SHUTDOWN, SUCCESS] ;
		return ArrayUtil.contains(status, o) ;	
	}

}