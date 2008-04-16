﻿/*

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
     * The NetStream status object who contains the level and the status value of all NetStreams in the application.
     * @author eKameleon
     */
    public class NetStreamStatus extends CoreObject
    {
    	
		/**
		 * Creates a new NetStreamStatus instance.
		 * @param code the <code class="prettyprint">String</code> code value.
		 * @param level the <code class="prettyprint">String</code> level value.
		 */
		public function NetStreamStatus( code:String , level:String ) 
		{
			this.code  = code ;
			this.level = level ;
		}

		/**
	 	 * The code of the NetStream information.
		 */
		public var code:String ;
	
		/**
		 * The level of the NetStream status information.
		 */
		public var level:String ;

		/**
		 * Compares the specified object with this object for equality.
		 * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
		 */
		public function equals(o:*):Boolean
		{
			return o.toString() == toString() ;	
		}

		/**
		 * Returns the string representation of this object.
		 * @return the string representation of this object.
		 */
		public override function toString():String 
		{
			return code ;	
		}
		
		/**
		 * The 'error' level code.
		 */
		public static const ERROR:String = "error" ;
		
		/**
		 * The 'status' level code.
		 */
		public static const STATUS:String = "status" ;		
		
		/**
		 * Data is not being received quickly enough to fill the buffer. Data flow will be interrupted until the buffer refills.
		 */
		public static const BUFFER_EMPTY:NetStreamStatus = new NetStreamStatus("NetStream.Buffer.Empty", STATUS) ;
		
		/**
		 * The buffer is full and the stream will begin playing.
		 */
		public static const BUFFER_FULL:NetStreamStatus = new NetStreamStatus("NetStream.Buffer.Full", STATUS) ;
		
		/**
		 * Data has finished streaming, and the remaining buffer will be emptied.
		 */
		public static const BUFFER_FLUSH:NetStreamStatus = new NetStreamStatus("NetStream.Buffer.Flush", STATUS) ;
		
		/**
		 * The stream is paused.
		 */
		public static const PAUSE:NetStreamStatus = new NetStreamStatus("NetStream.Pause.Notify", STATUS) ;	

		/**
		 * Playback has completed.
		 */
		public static const PLAY_COMPLETE:NetStreamStatus = new NetStreamStatus("NetStream.Play.Complete", STATUS) ;
		
		/**
		 * An error has occurred in playback for a reason other than those listed elsewhere in this table,
		 * such as the subscriber not having read access.
		 */
		public static const PLAY_FAILED:NetStreamStatus = new NetStreamStatus("NetStream.Play.Failed", ERROR) ;	
		
		/**
		 * Caused by a play list reset.
		 */
		public static const PLAY_RESET:NetStreamStatus = new NetStreamStatus("NetStream.Play.Start", STATUS) ;	
		
		/**
		 * The initial publish to a stream is sent to all subscribers.
		 */
		public static const PLAY_PUBLISH:NetStreamStatus = new NetStreamStatus("NetStream.Play.PublishNotify", STATUS) ;	
		
		/**
		 * Playback has started.
		 */
		public static const PLAY_START:NetStreamStatus = new NetStreamStatus("NetStream.Play.Start", STATUS) ;	
			
		/**
		 * Playback has stopped.
		 */
		public static const PLAY_STOP:NetStreamStatus = new NetStreamStatus("NetStream.Play.Stop", STATUS) ;	
		
		/**
		 * The FLV passed to the play() method can't be found.
		 */
		public static const PLAY_STREAM_NOT_FOUND:NetStreamStatus = new NetStreamStatus("NetStream.Play.StreamNotFound", ERROR) ;	
	
		/**
		 * The subscriber is switching from one stream to another in a playlist.
		 */
		public static const PLAY_SWITCH:NetStreamStatus = new NetStreamStatus("NetStream.Play.Switch", STATUS) ;	
	
		/**
		 * An unpublish from a stream is sent to all subscribers.
		 */
		public static const PLAY_UNPUBLISH:NetStreamStatus = new NetStreamStatus("NetStream.Play.UnpublishNotify", STATUS) ;	
		
		/**
		 * Publish was successful.
		 */
		public static const PUBLISH_START:NetStreamStatus = new NetStreamStatus("NetStream.Publish.Start", STATUS) ;	
		
		/**
		 *  Attempt to publish a stream which is already being published by someone else.
		 */
		public static const PUBLISH_BAD_NAME:NetStreamStatus = new NetStreamStatus("NetStream.Publish.BadName", ERROR) ;		
		
		/**
		 * The publisher of the stream has been idling for too long.
		 */
		public static const PUBLISH_IDLE:NetStreamStatus = new NetStreamStatus("NetStream.Publish.Idle", STATUS) ;	
		
		/**
		 * An attempt to record a stream failed.
		 */
		public static const RECORD_FAILED:NetStreamStatus = new NetStreamStatus("NetStream.Record.Failed", ERROR) ;
		
		/**
		 * Attempt to record a stream that is still playing or the client has no access right.
		 */
		public static const RECORD_NOACCESS:NetStreamStatus = new NetStreamStatus("NetStream.Record.NoAccess", ERROR) ;
		
		/**
		 * Recording has started.
		 */
		public static const RECORD_START:NetStreamStatus = new NetStreamStatus("NetStream.Record.Start", STATUS) ;
			
		/**
		 * Recording stopped.
	 	 */
		public static const RECORD_STOP:NetStreamStatus = new NetStreamStatus("NetStream.Record.Stop", STATUS) ;
		
		/**
		 * The seek fails, which happens if the stream is not seekable.
		 */
		public static const SEEK_FAILED:NetStreamStatus = new NetStreamStatus("NetStream.Seek.Failed", ERROR) ;
		
		/**
		 * For video downloaded with progressive download, 
		 * the user has tried to seek or play past the end of the video data that has downloaded thus far,
		 * or past the end of the video once the entire file has downloaded. 
		 * The message.details  property contains a time code that indicates the last valid position to which the user can seek.
		 */
		public static const SEEK_INVALID_TIME:NetStreamStatus = new NetStreamStatus("NetStream.Seek.InvalidTime", ERROR) ;
		
		/**
		 * The seek operation is complete.
		 */
		public static const SEEK_NOTIFY:NetStreamStatus = new NetStreamStatus("NetStream.Seek.Notify", STATUS) ;
	
		/**
		 * The stream is unpaused.
		 */
		public static const UNPAUSE:NetStreamStatus = new NetStreamStatus("NetStream.UnPause.Notify", STATUS) ;
		
		/**
		 * The unpublish operation was successfull.
	 	 */
		public static const UNPUBLISH_SUCCESS:NetStreamStatus = new NetStreamStatus("NetStream.Unpublish.Success", STATUS) ;			
		
    }
}
