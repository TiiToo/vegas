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

/*	IConfigLoader (interface)

	AUTHOR

		Name : IConfigLoader
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2008-09-01
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/

package asgard.config
{

    import asgard.process.IAction;

    import flash.net.URLLoader ;
    import flash.net.URLRequest ;
    
    import vegas.events.IEventBroadcaster;
    
    public interface IConfigLoader extends IAction, IEventBroadcaster
    {

        // ----o Public Properties
    
        /**
         * (Read-only) Return the config object.
         */
        function get config():Config ;
    
        /**
         * (Read-write) The data received from the load operation. 
         */
        function get data():* ;
        function set data( value:* ):void ;
    
        /**
         * (Read-write) The name of the config file with datas.
         */
        function get fileName():String ;
    	function set fileName( value:String ):void ;
        
        /**
         * (Read-write) The path of the config file with datas.
         */
    	function get path():String ;
        function set path( value:String ):void ;

        /**
         * (Read-write) The suffix of the config file with datas.
         */
    	function get suffix():String ;
	    function set suffix( value:String ):void ;
        
        // ----o Public Methods
        
        /**
         * Closes the load operation in progress.
         */
        function close():void ;
    
        /**
         * Return the original loader in the constructor. Override this method.
         */ 
        function getLoader():URLLoader ;
    
        /**
         * Sends and loads data from the specified URL.
         */
        function load( request:URLRequest=null ):void ;
        
    }
    
    
}