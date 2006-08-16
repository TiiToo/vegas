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

/* JSONLoader

	AUTHOR

		Name : JSONLoader
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-08-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	EXAMPLE
	
		import flash.events.Event ;
		import flash.events.ProgressEvent ;
		import flash.net.URLRequest ;
		import asgard.net.JSONLoader ;
		
		var loader:JSONLoader = new JSONLoader() ;
		var request:URLRequest = new URLRequest("json/config.json");
		
		function onComplete(e:Event):void
		{
		
			var data:* = e.target.data ;
			trace("> onComplete : " + e) ;
			for (var prop:String in data)
			{
				trace("  > " + prop + " : " + data[prop]) ;
			}
			
		}
		
		function onProgress(e:ProgressEvent):void
		{
			trace("> onProgress : " + e) ;
			var percent:Number = Math.round( e.bytesLoaded * 100 / e.bytesTotal ) ;
			trace("  > progress : " + percent + " %");
		}
		
		loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
		loader.addEventListener(Event.COMPLETE, onComplete);
		
		loader.load(request) ;
		
*/

package asgard.net
{
	
	import asgard.net.ParserLoader ;

	import flash.net.URLRequest;
	
	import vegas.string.JSON ;

	public class JSONLoader extends ParserLoader
	{
		
		// ----o Constructor
		
		public function JSONLoader(request:URLRequest=null)
		{
			super(request);
		}
		
		// ----o 
		
		override public function getDeserializer():Function
		{
			return JSON.deserialize ;	
		}
		
		
	}
}