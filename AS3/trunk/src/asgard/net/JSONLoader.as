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
	import flash.net.URLRequest;
	
	import vegas.string.JSON;		

	/**
     * <p><b>Example :</b></p>
     * <code>
     * import flash.events.Event ;
     * import flash.events.ProgressEvent ;
     * import flash.net.URLRequest ;
     * import asgard.net.JSONLoader ;
     * 
     * var loader:JSONLoader = new JSONLoader() ;
     * var request:URLRequest = new URLRequest("json/config.json");
     * function onComplete(e:Event):void
     * {
     *     var data:* = e.target.data ;
     *     trace("> onComplete : " + e) ;
     *     for (var prop:String in data)
     *     {
     *         trace("  > " + prop + " : " + data[prop]) ;
     *     }
     * }
     * 
     * function onProgress(e:ProgressEvent):void
     * {
     *     trace("> onProgress : " + e) ;
     *     var percent:Number = Math.round( e.bytesLoaded * 100 / e.bytesTotal ) ;
     *     trace("  > progress : " + percent + " %");
     * }
     * 
     * loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
     * loader.addEventListener(Event.COMPLETE, onComplete);
     * 
     * loader.load(request) ;
     * </code>
     * @author eKameleon
     */
	public class JSONLoader extends ParserLoader
	{
		
		/**
		 * Creates a new JSONLoader instance.
		 */
		public function JSONLoader(request:URLRequest=null)
		{
			super(request);
		}
		
		/**
		 * Returns the method used to deserialize this loader.
		 * @return the method used to deserialize this loader.
		 * @see JSON
		 */
		public override function getDeserializer():Function
		{
			return JSON.deserialize ;	
		}
		
		
	}
}