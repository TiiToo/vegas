/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is MarS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package mars.process.application 
{
	import asgard.config.Config;
	import asgard.system.Lang;
	import asgard.system.Localization;
	
	import mars.process.abstract.AbstractInitProcess;
	
	import pegas.maths.Range;	

	/**
	 * This process is launch to debug an application who contains a Config and a Localization object.
	 * @author eKameleon
	 */
	public class RunDebug extends AbstractInitProcess
	{
	
		/**
		 * Creates a new RunDebug instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the {@code bGlobal} argument is {@code true}.
		 */
		public function RunDebug( collapse:Boolean=false, depth:uint=4, bGlobal:Boolean = false , sChannel:String = null ) 
		{
			super(bGlobal, sChannel);
			isCollapse = collapse ;
			maxDepth   = depth ;
		}

		/**
		 * Debug the Config object.
		 */
		public var debugConfig:Boolean = true ;

		/**
		 * Debug the Localization object.
		 */
		public var debugLocalization:Boolean = false ;

		/**
		 * Indicated if the console use collapse property or not.
		 */
	    public var isCollapse:Boolean ;
		
		/**
		 * (read-only) Returns the max depth to collaspe the structure of an object in the console.
		 */
	    public function get maxDepth():uint
	    {
	        return _maxDepth ;
	    }

		/**
		 * (read-only) Sets the max depth to collaspe the structure of an object in the console.
		 */
        public function set maxDepth( value:uint ):void
        {
		    var r:Range = new Range(1, 100) ;
    		_maxDepth = r.clamp(value) ;
    	}

		/**
		 * The space string use to format the debugs.
		 */
		public static var SPACE:String = "   " ;
	
		/**
		 * Launch the debug process in this method.
		 */
		public override function init():void
		{
			
			if ( debugConfig )
			{
				getLogger().debug( this + " debug " + Config.getInstance() ) ;
				enumerate( Config.getInstance() ) ;
			}
			
			if ( debugLocalization ) // TODO finish
			{
				var localization:Localization = Localization.getInstance() ;
				var current:Lang = localization.current ;
							
				getLogger().debug( this + " debug " + localization + " current:" + current ) ;
				enumerate( Localization.getInstance().getLocale() ) ;
			}
			
		}
		
		/**
		 * Enumerates the specified object.
		 */
		public function enumerate( o:Object ):void
		{
			_enumerate(o) ;
		}
		
		/**
		 * @private
		 */
		private var _maxDepth:uint ;
		
		/**
		 * @private
		 */
		private function _enumerate( o:Object , depth:uint = 1 ):void
		{
			for ( var prop:String in o ) 
			{
				var value:* = o[prop] ;
				getLogger().info( _getSpace( depth-1 ) + " + " + prop + " : " + value ) ;
				if ( value is Object && (isCollapse == true) && (depth <= maxDepth) )
				{
					_enumerate( value , depth + 1 ) ;
				}
			}
		}
		
		private function _getSpace( depth:uint=0 ):String
		{
			var s:String = "" ;
			if ( isNaN(depth) || depth == 0 )
			{
				return "" ;
			}
			while( --depth > -1 )
			{
				s += SPACE ;	
			}
			return s ;	
		}
		
	}
}
