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

/* ParserLoader

	AUTHOR

		Name : ParserLoader
		Package : asgard.net
		Version : 1.0.0.0
		Date :  2006-08-16
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

*/

package asgard.net
{
	
	import flash.events.Event ;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;

	public class ParserLoader extends URLLoader
	{
		
		// ----o Constructor
		
		public function ParserLoader(request:URLRequest=null)
		{
			super(request);
			addEventListener(Event.COMPLETE, complete) ;
		}
	
		// ----o Public Properties
		
		/**
		 * Use deserializer method if this property is 'true'.
		 */
		public var isDeserialize:Boolean = true ;	

		// ----o Public Methods

		/**
		 * Returns a deserialize method to use in the ParserLoader when loading is complete.
		 * override this method.
		 */
		public function getDeserializer():Function
		{
			return null ;	
		}
		
		// ----o Protected Methods
		
		protected function complete(e:Event):void
		{
			
			var deserialize:Function ;
			
			switch (dataFormat) {
			
				case URLLoaderDataFormat.TEXT :
					
					if ( getDeserializer() != null && isDeserialize )
					{
						deserialize = getDeserializer() ;
						data = deserialize(data) ;
						
					}
					
					break ;
				
				case URLLoaderDataFormat.VARIABLES :
					
					data = new URLVariables(data) ;
					if ( getDeserializer() != null && isDeserialize )
					{
						deserialize = getDeserializer() ;
						for (var prop:String in data)
						{
							data[prop] = deserialize(data[prop]) ;
						}
					}
					break ;

				case URLLoaderDataFormat.BINARY :
				default :
					//
					break ;

			}
			
		}
		
	}
}