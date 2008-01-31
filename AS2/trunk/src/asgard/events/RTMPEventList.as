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

/**
 * The RTMP basic event enumeration list.
 * @author eKameleon
 */
class asgard.events.RTMPEventList 
{
	
	/**
	 * The name of the event when the rtmp connection is closed.
	 */
	public static var RTMP_CLOSE:String = "onRtmpClose" ;

	/**
	 * The name of the event when the rtmp connection is finished.
	 */
	public static var RTMP_FINISH:String = "onRtmpFinish" ;
	
	/**
	 * The name of the event when the rtmp connection is initialize.
	 */
	public static var RTMP_INIT:String = "onRtmpInit" ;
	
	/**
	 * The name of the event when the rtmp connection is started.
	 */
	public static var RTMP_START:String = "onRtmpStart" ;
	
	/**
	 * The name of the event when the rtmp connection status is changed.
	 */
	public static var RTMP_NET_STATUS:String = "onRtmpStatus" ;
	
	/**
	 * The name of the event when the rtmp connection status is out of time.
	 */
	public static var RTMP_TIMEOUT:String = "onRtmpTimeout" ;
	
}
