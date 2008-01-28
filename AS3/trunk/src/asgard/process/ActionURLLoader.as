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
package asgard.process 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	
	import asgard.process.AbstractActionLoader;	

	/**
	 * This action process launch the load of a URLLoader object.
	 * @author eKameleon
	 */
	public class ActionURLLoader extends AbstractActionLoader 
	{

		/**
		 * Creates a new ActionURLLoader instance.
		 * @param loader The URLLoader object to load.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
		public function ActionURLLoader( loader:URLLoader, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( bGlobal, sChannel );
			if ( loader != null )
			{
				this.loader = loader ;	
			}
		}

        /**
         * (read-only) Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public override function get bytesLoaded():uint
    	{
    		return (_loader as URLLoader).bytesLoaded ;	
    	}
        
        /**
         * (read-write) Indicates the total number of bytes in the downloaded data.
         */
        public override function get bytesTotal():uint
    	{
    		return (_loader as URLLoader).bytesTotal ;	
    	}

       /**
         * (read-write) Indicates the data received from the load operation. 
         */
        public function get data():*
    	{
    		return _loader.data ;	
    	}
    	
    	/**
    	 * @private
    	 */
        public function set data( value:* ):void
    	{
    		_loader.data = value ;
    	}
        
        /**
         * (read-write) Controls whether the downloaded data is received as 
         *   - text (URLLoaderDataFormat.TEXT),
         *   - raw binary data (URLLoaderDataFormat.BINARY)
         *   - URL-encoded variables (URLLoaderDataFormat.VARIABLES).
         */
        public function get dataFormat():String
    	{
    		return _dataFormat ;	
    	}
    	
    	/**
    	 * @private
    	 */
        public function set dataFormat( value:String ):void
    	{
    		_dataFormat = value ;	
    	}

        /**
         * (read-write) Activate or disactivate parsing (Use this with XML, EDEN, JSON...). 
         */
        public function get parsing():Boolean
    	{
    		return _isParsing ;	
    	}
    	
    	/**
    	 * @private
    	 */
        public function set parsing( b:Boolean ):void
    	{
    	    _isParsing = b ;	
    	}
    	
		/**
		 * Cancels a load() method operation that is currently in progress for the Loader instance.
		 */
		public override function close():void
		{
			(_loader as URLLoader).close() ;
			notifyFinished() ;
		}

        /**
         * Override this method. Parse your datas when loading is complete.
         */
        public function parse():void
        {
            // override this method.
        }

        /**
         * Dispatch Event.COMPLETE event after all the received data is decoded and placed in the data property. 
         */
        protected override function complete( e : Event ) : void
		{
		    if (_isParsing) 
		    {
		        parse() ;
		    }
            super.complete(e) ;
        }	
        
		/**
		 * This protected method contains the invokation of the load method of the current loader of this process.
		 */
		protected override function _run():void
		{
			(_loader as URLLoader).load( request ) ;
		}

    	/**
    	 * @private
    	 */
		private var _dataFormat:String = URLLoaderDataFormat.TEXT ;
		
		/**
		 * @private
		 */
  		private var _isParsing:Boolean = false ;
		
	}

}
