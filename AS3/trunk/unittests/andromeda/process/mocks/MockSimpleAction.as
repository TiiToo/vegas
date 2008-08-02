/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.process.mocks 
{
	import andromeda.process.SimpleAction;
	
	import system.Reflection;	

	/**
	 * This mock simulate an IAction object who increments a static counter "COUNT" when the run method of all instance of this class are called.
	 * @author eKameleon
	 */
	public class MockSimpleAction extends SimpleAction 
	{
		
		/**
		 * Creates a new MockAction instance.
		 */
		public function MockSimpleAction( id:*=null , verbose:Boolean=false )
		{
			super() ;
			this.id = id ;
		}
		
		/**
		 * The counter of this class.
		 */
		public static var COUNT:uint = 0 ;		
		
		/**
		 * The id of the object.
		 */
		public var id:* ;
		
		/**
		 * The verbose flag.
		 */
		public var verbose:Boolean ;
		
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new MockSimpleAction(id, verbose) ;
        }
		
		/**
		 * Reset the static counter.
		 */
		public static function reset():void
		{
			COUNT = 0 ;	
		}
		
		/**
		 * Run the process.
		 */
		public override function run(...arguments:Array):void
		{
			setRunning(true) ;
			notifyStarted() ;
			if ( verbose )
			{
				trace( this + " run :: " + COUNT + (id != null ? " id:" + id : "" ) ) ;
			}
			COUNT ++ ;	
			setRunning(false) ;
			notifyFinished() ;
		}
		
			
		/**
	 	 * Returns the <code class="prettyprint">String</code> representation of this object.
	 	 * @return the <code class="prettyprint">String</code> representation of this object.
	 	 */
		public override function toString():String
		{
			var str:String = "[" + Reflection.getClassName(this) ;
			if ( this.id != null )
			{
				str += " " + this.id ;	
			} 
			str += "]" ;
			return str ;
		}			
		
	}
}
