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

/** NetStreamStatus

	AUTHOR

		Name : NetStreamStatus
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-06-24
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTANT SUMMARY
	
		- static BUFFER_EMPTY:NetStreamStatus
		
		- static BUFFER_FULL:NetStreamStatus
	
		- static BUFFER_FLUSH:NetStreamStatus

		- static PAUSE:NetStreamStatus

		- static PLAY_FAILED:NetStreamStatus
	
		- static PLAY_RESET:NetStreamStatus
		
		- static PLAY_PUBLISH:NetStreamStatus
		
		- static PLAY_START:NetStreamStatus
		
		- static PLAY_STOP:NetStreamStatus
		
		- static PLAY_STREAM_NOT_FOUND:NetStreamStatus

		- static PLAY_UNPUBLISH:NetStreamStatus

		- static PUBLISH_START:NetStreamStatus
		
		- static PUBLISH_BAD_NAME:NetStreamStatus
		
		- static PUBLISH_IDLE:NetStreamStatus

		- static RECORD_FAILED:NetStreamStatus
		
		- static RECORD_NOACCESS:NetStreamStatus
		
		- static RECORD_START:NetStreamStatus
		
		- static RECORD_STOP:NetStreamStatus

		- static SEEK_FAILED:NetStreamStatus
		
		- static SEEK_INVALID_TIME:NetStreamStatus

		- static SEEK_NOTIFY:NetStreamStatus

		- static UNPAUSE:NetStreamStatus

		- static UNPUBLISH_SUCCESS:NetStreamStatus

	METHOD SUMMARY
	
		- hashCode():Number
	
		- toString():String

	IMPLEMENTS
	
		IFormattable, IHashabled

**/

import vegas.core.CoreObject;

/**
 * @author eKameleon
 * @version 1.0.0.0
 **/	
class asgard.net.NetStreamStatus extends CoreObject {
	
	// ----o Constructor
	
	private function NetStreamStatus( sCode:String , sLevel:String) {
		code = sCode ;
		level = sLevel ;
	}

	// ----o Level
	
	static public var ERROR:String = "error" ;
	
	static public var STATUS:String = "status" ;
	
	// ----o Status
	
	/**
	 * Data is not being received quickly enough to fill the buffer. Data flow will be interrupted until the buffer refills.
	 */
	static public var BUFFER_EMPTY:NetStreamStatus = new NetStreamStatus("NetStream.Buffer.Empty", STATUS) ;
	
	/**
	 * The buffer is full and the stream will begin playing.
	 */
	static public var BUFFER_FULL:NetStreamStatus = new NetStreamStatus("NetStream.Buffer.Full", STATUS) ;
	
	/**
	 * Data has finished streaming, and the remaining buffer will be emptied.
	 */
	static public var BUFFER_FLUSH:NetStreamStatus = new NetStreamStatus("NetStream.Buffer.Flush", STATUS) ;

	/**
	 * The stream is paused.
	 */
	static public var PAUSE:NetStreamStatus = new NetStreamStatus("NetStream.Pause.Notify", STATUS) ;	

	/**
	 * An error has occurred in playback for a reason other than those listed elsewhere in this table,
	 * such as the subscriber not having read access.
	 */
	static public var PLAY_FAILED:NetStreamStatus = new NetStreamStatus("NetStream.Play.Failed", ERROR) ;	
	
	/**
	 * Caused by a play list reset.
	 */
	static public var PLAY_RESET:NetStreamStatus = new NetStreamStatus("NetStream.Play.Start", STATUS) ;	

	/**
	 * The initial publish to a stream is sent to all subscribers.
	 */
	static public var PLAY_PUBLISH:NetStreamStatus = new NetStreamStatus("NetStream.Play.PublishNotify", STATUS) ;	
	
	/**
	 * Playback has started.
	 */
	static public var PLAY_START:NetStreamStatus = new NetStreamStatus("NetStream.Play.Start", STATUS) ;	
		
	/**
	 * Playback has stopped.
	 */
	static public var PLAY_STOP:NetStreamStatus = new NetStreamStatus("NetStream.Play.Stop", STATUS) ;	
	
	/**
	 * The FLV passed to the play() method can't be found.
	 */
	static public var PLAY_STREAM_NOT_FOUND:NetStreamStatus = new NetStreamStatus("NetStream.Play.StreamNotFound", ERROR) ;	

	/**
	 * An unpublish from a stream is sent to all subscribers.
	 */
	static public var PLAY_UNPUBLISH:NetStreamStatus = new NetStreamStatus("NetStream.Play.UnpublishNotify", STATUS) ;	
	
	/**
	 * Publish was successful.
	 */
	static public var PUBLISH_START:NetStreamStatus = new NetStreamStatus("NetStream.Publish.Start", STATUS) ;	
	
	/**
	 *  Attempt to publish a stream which is already being published by someone else.
	 */
	static public var PUBLISH_BAD_NAME:NetStreamStatus = new NetStreamStatus("NetStream.Publish.BadName", ERROR) ;		

	/**
	 * The publisher of the stream has been idling for too long.
	 */
	static public var PUBLISH_IDLE:NetStreamStatus = new NetStreamStatus("NetStream.Publish.Idle", STATUS) ;	

	/**
	 * An attempt to record a stream failed.
	 */
	static public var RECORD_FAILED:NetStreamStatus = new NetStreamStatus("NetStream.Record.Failed", ERROR) ;
	
	/**
	 * Attempt to record a stream that is still playing or the client has no access right.
	 */
	static public var RECORD_NOACCESS:NetStreamStatus = new NetStreamStatus("NetStream.Record.NoAccess", ERROR) ;

	/**
	 * Recording has started.
	 */
	static public var RECORD_START:NetStreamStatus = new NetStreamStatus("NetStream.Record.Start", STATUS) ;
	
	/**
	 * Recording stopped.
	 */
	static public var RECORD_STOP:NetStreamStatus = new NetStreamStatus("NetStream.Record.Stop", STATUS) ;

	/**
	 * The seek fails, which happens if the stream is not seekable.
	 */
	static public var SEEK_FAILED:NetStreamStatus = new NetStreamStatus("NetStream.Seek.Failed", ERROR) ;

	/**
	 * For video downloaded with progressive download, 
	 * the user has tried to seek or play past the end of the video data that has downloaded thus far,
	 * or past the end of the video once the entire file has downloaded. 
	 * The message.details  property contains a time code that indicates the last valid position to which the user can seek.
	 */
	static public var SEEK_INVALID_TIME:NetStreamStatus = new NetStreamStatus("NetStream.Seek.InvalidTime", ERROR) ;

	/**
	 * The seek operation is complete.
	 */
	static public var SEEK_NOTIFY:NetStreamStatus = new NetStreamStatus("NetStream.Seek.Notify", STATUS) ;

	/**
	 * The stream is unpaused.
	 */
	static public var UNPAUSE:NetStreamStatus = new NetStreamStatus("NetStream.UnPause.Notify", STATUS) ;

	/**
	 * The unpublish operation was successfull.
	 */
	static public var UNPUBLISH_SUCCESS:NetStreamStatus = new NetStreamStatus("NetStream.Unpublish.Success", STATUS) ;	
	
	static private var __ASPF__ = _global.ASSetPropFlags(NetStreamStatus, null , 7, 7) ;

	// ----o Public Properties
	
	public var code:String ;
	
	public var level:String ;

	// ----o Public Methods

	public function toString():String {
		return code ;	
	}

}