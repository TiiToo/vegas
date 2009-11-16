/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.transitions 
{
    import pegas.transitions.Motion;
    
    /**
     * The Tween class lets you use ActionScript to move, resize, and fade movie clips easily on the Stage by specifying a property of the target movie clip to be tween animated over a number of frames or seconds.
     * The Tween class also lets you specify a variety of easing methods.
     * <p>Easing refers to gradual acceleration or deceleration during an animation, which helps your animations appear more realistic.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import pegas.transitions.Tween ;
     * var tw:Tween = new Tween (mc, "_x", Elastic.easeOut, mc._x, 400, 2, true, true) ;
     * </pre>
     */
    public class Tween extends Motion 
    {
        /**
         * Creates a new Tween instance.
         * <p><b>Usage :</b></p>
         * <pre class="prettyprint">
         * var tw:Tween = new Tween( obj, prop:String, e:*, b:Number, f:Number, d:Number , u:Boolean, auto:Boolean ) ;
         * var tw:Tween = new Tween( obj, entries:Array , d:Number , u:Boolean, auto:Boolean ) ;
         * </pre>
         */
        public function Tween( ...arguments:Array )
        {
            _model = new TweenModel() ;
            if (arguments[0] != null) 
            {
                target = arguments[0] ;
            }
            var auto:Boolean ;
            var l:int = arguments.length ;
            if ( l > 1 )
            {
                if ( arguments[1] is Array ) 
                {
                    model      = arguments[1] as Array ;
                    duration   = arguments[2] > 0 ? arguments[2] : null ;
                    useSeconds = arguments[3] === true ;
                    auto       = arguments[4] === true ;
                }
                else
                {
                    add( new TweenEntry( arguments[1] , arguments[2], arguments[3], arguments[4]) )  ;
                    duration   = ( arguments[5] > 0 ) ? arguments[5] : null ;
                    useSeconds = arguments[6] === true ;
                    auto       = arguments[7] === true ; // auto start
                }
            }
            if ( auto ) 
            {
                run() ;
            }
        }
        
        /**
         * Determinates the model of this Tween.
         * @see pegas.transitions.TweenModel
         */
        public function get model():* 
        {
            return _model ;
        }
        
        /**
         * @private
         */
        public function set model( o:* ):void 
        {
            _unCheck() ;
            if ( o is TweenModel ) 
            {
                _model = o as TweenModel ;
            }
            else if ( o is Array ) 
            {
                _model = new TweenModel( null , o as Array ) ;
            }
            else 
            {
                _model = new TweenModel() ;
            }
        }
        
        /**
         * Inserts a TweenEnry in the model of the Tween object.
         * @param entry a TweenEntry reference.
         */
        public function add( entry:TweenEntry ):void 
        {
            _model.add( entry ) ;
            _unCheck() ;
        }
        
        /**
         * Inserts a new property in the Tween object.
         * @param prop the string representation of the number property.
         * @param easing the easing method used by the Tween on this property (use a Function or a Easing object).
         * @param begin the begin value.
         * @param finish the finish value.
         * @return a TweenEntry defined by the specified arguments.
         */
        public function addProperty( prop:String=null , easing:*=null, begin:Number=NaN, finish:Number=NaN):TweenEntry 
        { 
            var e:TweenEntry = new TweenEntry(prop, easing, begin, finish) ;
            add(e) ;
            return e ;
        }
        
        /**
         * Removes all entries in the model of this Tween object.
         */
        public function clear():void 
        {
            if ( running ) 
            {
                this.stop() ;
            }    
            if ( _model )
            {
                _model.clear() ;
            }
            _unCheck() ;
            notifyCleared() ;
        }
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            var t:Tween = new Tween() ;
            t.target     = target ;
            t.duration   = duration ;
            t.useSeconds = useSeconds ;
            if (size() > 0) 
            {
                t.model = model.clone() ;
            }
            return t ;
        }
        
        /**
         * Remove a TweenEntry in the Tween Object.
         * @param entry The entry to remove in this Tween.
         */
        public function remove( entry:TweenEntry ):Boolean 
        {
            var b:Boolean =  _model.remove( entry ) ;
            _unCheck() ;
            return b ;
        }    
        
        /**
         * Remove a property in the Tween Object.
         */
        public function removeProperty( prop:String ):Boolean 
        {
            var b:Boolean = _model.remove( prop ) ;
            _unCheck() ;
            return b ;
        }
        
        /**
         * Set the TweenEntry property of this TweenLite object.
         * @param prop the property name of the object to change.
         * @param easing the easing function of the tween entry (use a Function or a Easing object).
         * @param begin the begin value.
         * @param finish the finish value. 
         */
        public function setTweenEntry( prop:String, easing:* , begin:Number , finish:Number ):void
        {
            if ( _model.contains( prop ) )
            {
                var entry:TweenEntry = _model.get(prop) ;
                entry.easing = easing ;
                entry.begin  = begin  ;
                entry.finish = finish ;
                _unCheck() ;
            }
            else
            {
                addProperty.apply( this , arguments ) ;
            }
        }
        
        /**
         * Returns the numbers of elements(properties) in the model of this Tween.
         * @return the numbers of elements(properties) in the model of this Tween.
         */
        public function size():Number 
        {
            return _model.size() ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            if ( _model == null )
            {
                return ;
            }
            if ( _memory == null )
            {
                _memory = _model.toArray() ;
            }
            _len = _memory.length ;
            while(--_len > -1) 
            {
                _entry = _memory[_len] as TweenEntry ;
                _target[ _entry.prop ] = _entry.set( _time , _duration ) ;
            }
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        private var _entry:TweenEntry ;
        
        /**
         * @private
         */
        private var _len:int ;
        
        /**
         * @private
         */
        private var _memory:Array ;
         
        /**
         * @private
         */
        private var _model:TweenModel ;
        
        /**
         * @private
         */
        private function _unCheck():void
        {
            _memory = null ;
            _entry  = null ;
            _len    = 0    ;
        }
    }
}
