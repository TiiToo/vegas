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

/** Delegate

	AUTHOR

		Name : Delegate
		Package : vegas.events
		Version : 1.0.0.0
		Date :  2006-07-07
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	CONSTRUCTOR
	
		new Delegate(scope, method:Function) ;

	METHOD SUMMARY
	
		- addArguments(...arguments:Array):Void
		
		- clone():*
		
		- static create(scope, medthod):Function
		
		- getArguments():Array
		
		- getMethod():Function
		
		- getScope():Object
		
		- handleEvent(e:Event)
		
		- run():Void
		
		- setArguments(...arguments:Array):Void

        - toSource(...arguments:Array):String
		
		- toString():String

	INHERIT
	
		CoreObject → Delegate

	IMPLEMENTS
	
		EventListener, ICloneable, IFormattable, IHashable, IRunnable

	SEE ALSO
	
		Event, EventListener

**/

package vegas.events
{
    
    import flash.events.Event;
    import vegas.core.CoreObject;
    import vegas.core.ICloneable;
    import vegas.core.IRunnable;

    public class Delegate extends CoreObject implements EventListener, ICloneable, IRunnable
    {
        
        // ----o Constructor
        
        public function Delegate(scope:*, method:Function, ...arguments:Array)
        {
		    _s = scope ;
    		_m = method ;
    		_a = arguments ;
    		_p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;
        }
        
        // ----o Public Methods
 
 	   public function addArguments( ...arguments:Array ):void 
 	   {
    		if (arguments.length > 0) 
    		{
			    _a = _a.concat( arguments) ;
                _p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;
		    }
    	}
 
     	public function clone():*
     	{
		    return new Delegate( getScope(), getMethod() ) ;
	    }
 
 	   static public function create(scope:*, method:Function, ...arguments:Array):Function 
 	   {
 	       
 	       var s:* = scope ;
 	       var m:Function = method ;
 	       var a:Array = arguments ;
 	       var f:Function = function():* {	
      			var args:Array = a.concat(arguments) ;
    			return m.apply(s, args) ;
    		} ;

    		return f;
	    }	
	
	    public function getArguments():Array
	    {
		    return _a ;
    	}

    	public function getMethod():Function 
    	{
		    return _m ;
    	}
	
	    public function getScope():*
	    {
		    return _s ;
    	}
        
        public function handleEvent(e:Event):*
        {
            return _m.apply(_s, [e].concat(_a));
        }

	    public function run( ...arguments:Array ):void
	    {
		    addArguments(arguments) ;
    		_p() ;
	    }

	    public function setArguments( ...arguments:Array ):void
	    {
		    if (arguments.length > 0) 
		    {
			    _a = [].concat(arguments) ;
			    _p = Delegate.create.apply(this, [_s].concat([_m], _a) ) ;

    		}
    		
	    }

        /**
         * Returns a string representing the source code of the Delegate object.
         * This method return 'null'.
         */
		override public function toSource(...arguments):String 
		{
			return "null" ;
		}

	    // ----o Private Properties
	
    	private var _m:Function ; // method
    	private var _s:* ; // scope
    	private var _a:Array ; // arguments
    	private var _p:Function; // proxy

    }
    
}