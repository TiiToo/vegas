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

/* IActionLoader (interface)

	AUTHOR

		Name : IActionLoader
		Package : asgard.config
		Version : 1.0.0.0
		Date :  2008-09-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net
	
*/

package asgard.net
{

    import asgard.process.IAction;

    import flash.net.URLLoader ;
    import flash.net.URLRequest ;

    public interface IActionLoader extends IAction
    {

        // ----o Public Properties
    
        /**
         * (Read-write) The data received from the load operation. 
         */
        function get data():* ;
        function set data( value:* ):void ;

        /**
         * (read-write) Activate or disactivate parsing. 
         */
        function get parsing():Boolean ;
        function set parsing( b:Boolean ):void ;

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
        
        /**
         * Parse datas if the loading is complete.
         */
        function parse():void ;
        
    }
}