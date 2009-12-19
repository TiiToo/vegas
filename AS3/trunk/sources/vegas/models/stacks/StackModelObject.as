/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

package vegas.models.stacks 
{
    import system.data.Iterator;
    import system.data.Stack;
    import system.data.ValueObject;
    import system.data.stacks.ArrayStack;
    
    import vegas.models.CoreModelObject;
    
    /**
     * This model use an internal <code class="prettyprint">Stack</code> to register value objects.
     */
    public class StackModelObject extends CoreModelObject 
    {
        /**
         * Creates a new StackModelObject instance.
         * @param id the id of this model.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */ 
        public function StackModelObject(id:* = null, global:Boolean = true , channel:String = null)
        {
            super( id, global, channel ) ;
            _stack = initializeStack() ;
        }
        
        /**
         * Default event type when the pop method is invoked.
         */
        public static var POP_VO:String = "onPopVO" ;
        
        /**
         * Default event type when the push method is invoked.
         */
        public static var PUSH_VO:String = "onPushVO" ;
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _stack.clear() ;
            super.clear() ;
        }
        
        /**
         * Returns the event name use in the {@code pop} method.
         * @return the event name use in the {@code pop} method.
         */
        public function getEventTypePOP():String
        {
            return _sPopType ;
        }
        
        /**
         * Returns the event name use in the {@code push} method.
         * @return the event name use in the {@code push} method.
         */
        public function getEventTypePUSH():String
        {
            return _sPushType ;
        }
        
        /**
         * Returns the internal {@code Stack} reference of this model.
         * @return the internal {@code Stack} reference of this model.
         */
        public function getStack():Stack
        {
            return _stack ; 
        }
        
        /**
         * This method is invoked in the constructor of the class to initialize all events.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sPopType  = POP_VO ;
            _sPushType = PUSH_VO ;
        }
        
        /**
         * Initialize the internal Stack instance in the constructor of the class.
         * You can overrides this method if you want change the default {@code SimpleStack} use in this model.
         */
        public function initializeStack():Stack
        {
            return new ArrayStack() ;
        }
        
        /**
         * Returns {@code true} if this model is empty.
         * @return {@code true} if this model is empty.
         */
        public function isEmpty():Boolean 
        { 
            return _stack.isEmpty() ;
        }
        
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _stack.iterator() ;
        }
        
        /**
         * Notify a {@code ModelObjectEvent} when a {@code ValueObject} is poped in the model.
         */ 
        public function notifyPop( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sPopType, vo ) ) ;
        }
        
        /**
         * Notify a {@code ModelObjectEvent} when a {@code ValueObject} is pushed in the model.
         */ 
        public function notifyPush( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sPushType, vo ) ) ;
        }
        
        /**
         * Removes and returns the lastly pushed value object in the model.
         * @return the lastly pushed value object in the model.
         */
        public function pop():ValueObject
        {
            var vo:ValueObject = _stack.pop() ;
            notifyPop( vo ) ;
            return vo ;
        }
        
        /**
         * Pushes the passed-in value object to this stack.
         * @param vo The ValueObject to push.
         * @throws ArgumentError If the ValueObject is 'null' or 'undefined'.
         */
        public function push( vo:ValueObject ):void
        {
            if (vo == null)
            {
                throw new ArgumentError( this + " push method failed, the ValueObject passed in argument not must be 'null' or 'undefined'.") ;  
            }
            validate(vo) ;
            _stack.push( vo ) ;
            notifyPush( vo ) ;
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">pop</code> method.
         */
        public function setEventTypePOP( type:String ):void
        {
            _sPopType = type ;
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">push</code> method.
         */
        public function setEventTypePUSH( type:String ):void
        {
            _sPushType = type ;
        }
        
        /**
         * Sets the internal Stack of this model. 
         * By default the initializeStack() method is used if the passed-in argument is null.
         */
        public function setStack( s:Stack ):void
        {
            _stack = s || initializeStack() ;
        }
        
        /**
         * Returns the number of <code class="prettyprint">ValueObject</code> in this model.
         * @return the number of <code class="prettyprint">ValueObject</code> in this model.
         */
        public function size():Number
        {
            return _stack.size() ;
        }
        
        /**
         * @private
         */
        private var _sPopType:String ;
                
        /**
         * @private
         */
        private var _sPushType:String ;
        
        /**
         * @private
         */
        private var _stack:Stack ;
        
    }
}
