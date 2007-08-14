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

package vegas.events.dom
{
	import vegas.core.CoreObject;
	import vegas.events.EventListener;
	import vegas.util.ClassUtil;
	import vegas.util.Serializer;
	
	internal class EventListenerContainer extends CoreObject
	{
		
		public function EventListenerContainer( listener:EventListener )
		{
			super();
			_listener = listener ;
		}

		// ----o Public Properties
	
		public var useCapture:Boolean ;

		// ----o Public Methods
    
		public function enableAutoRemove(enable:Boolean):void {
        	_autoRemove = enable;
	    }

		public function getPriority():uint {
			return _priority || 0 ;
		}
    
	    public function isAutoRemoveEnabled():Boolean 
	    {
     	   return _autoRemove;
	    }

	    public function getListener():EventListener 
	    {
    	    return _listener ;
	    }
    
		public function setPriority(n:uint=0):void
		{
			_priority = n ;
		}

		override public function toSource(...arguments:Array):String 
		{
			return "new " + ClassUtil.getPath(this) + "(" + Serializer.toSource(_listener) + ")" ;
		}

		// ----o Private Properties

		private var _autoRemove:Boolean = false ;
	    private var _listener:EventListener = null ;
		private var _priority:uint ;
		
	}
	
}