/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
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

package vegas.models.queues 
{
    import system.data.Iterator;
    import system.data.Queue;
    import system.data.ValueObject;
    import system.data.queues.LinearQueue;
    
    import vegas.models.CoreModelObject;
    
    /**
     * This model use an internal <code class="prettyprint">Queue</code> to register value objects.
     */
    public class QueueModelObject extends CoreModelObject 
    {
        /**
         * Creates a new QueueModelObject instance.
         * @param global the flag to use a global event flow or a local event flow (default true).
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         * @param id the id of this model.
         */ 
        public function QueueModelObject( global:Boolean = true , channel:String = null , id:* = null )
        {
            super( global, channel , id );
            _queue = initializeQueue() ;
        }
        
        /**
         * Default event type when the dequeue method is invoked.
         */
        public static const DEQUEUE_VO:String = "dequeueVO" ;
            
        /**
         * Default event type when the enqueue method is invoked.
         */
        public static const ENQUEUE_VO:String = "enqueueVO" ;
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _queue.clear() ;
            super.clear() ;
        }
        
        /**
         * Dequeues the head value object in the model.
         */
        public function dequeue():*
        {
            var r:* = _queue.poll() ;
            notifyDequeue( r ) ;
            return r ;
        }
        
        /**
         * Enqueues a value object in the model.
         */
        public function enqueue( vo:ValueObject ):Boolean
        {   
            if (vo == null)
        {   
                throw new ArgumentError( this + " enqueue method failed, the ValueObject passed in argument not must be 'null' or 'undefined'.") ;  
            }
            validate(vo) ;
            var b:Boolean = _queue.enqueue( vo ) ;
            notifyEnqueue( vo ) ;
            return b ;
        }
        
        /**
         * Returns the event name use in the {@code dequeue} method.
         * @return the event name use in the {@code dequeue} method.
         */
        public function getEventTypeDEQUEUE():String
        {
            return _sDequeueType ;
        }
        
        /**
         * Returns the event name use in the {@code enqueue} method.
         * @return the event name use in the {@code enqueue} method.
         */
        public function getEventTypeENQUEUE():String
        {
            return _sEnqueueType ;
        }
        
        /**
         * Returns the internal Queue reference of this model.
         * @return the internal Queue reference of this model.
         */
        public function getQueue():Queue
        {
            return _queue ; 
        }        
        
        /**
         * This method is invoked in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sDequeueType = DEQUEUE_VO ;
            _sEnqueueType = ENQUEUE_VO ;
        }
        
        /**
         * Initialize the internal Queue instance in the constructor of the class.
         * You can overrides this method if you want change the default LinearQueue use in this model.
         */
        public function initializeQueue():Queue
        {
            return new LinearQueue() ;
        }
        
        /**
         * Returns {@code true} if this model is empty.
         * @return {@code true} if this model is empty.
         */
        public function isEmpty():Boolean 
        { 
            return _queue.isEmpty() ;
        }
        
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _queue.iterator() ;
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">ValueObject</code> is dequeue in the model.
         */ 
        public function notifyDequeue( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sDequeueType , vo ) ) ;
        }
        
        /**
        * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">ValueObject</code> is enqueue in the model.
        */ 
        public function notifyEnqueue( vo:ValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sEnqueueType , vo ) ) ;
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">dequeue</code> method.
         */
        public function setEventTypeDEQUEUE( type:String ):void
        {
            _sDequeueType = type ;
        }
        
        /**
         * Sets the event name use in the <code class="prettyprint">enqueue</code> method.
         */
        public function setEventTypeENQUEUE( type:String ):void
        {
            _sEnqueueType = type ;
        }
        
        /**
         * Sets the internal Queue of this model. 
         * By default the initializeQueue() method is used if the passed-in argument is null.
         */
        public function setQueue( queue:Queue ):void
        {
            _queue = queue || initializeQueue() ;
        }
        
        /**
         * Returns the number of <code class="prettyprint">ValueObject</code> in this model.
         * @return the number of <code class="prettyprint">ValueObject</code> in this model.
         */
        public function size():Number
        {
            return _queue.size() ;
        }
        
        /**
         * Returns the <code class="prettyprint">Array</code> representation of this object.
         * @return the <code class="prettyprint">Array</code> representation of this object.
         */
        public function toArray():Array
        {
            return _queue.toArray() ;
        }
        
        /**
         * The internal {@code Queue} reference.
         */
        private var _queue:Queue ;
        
        /**
         * The internal ModelObjectEvent type use in the dequeue method.
         */
        private var _sDequeueType:String ;
        
        /**
         * The internal ModelObjectEvent type use in the enqueue method.
         */
        private var _sEnqueueType:String ;
    }
}
