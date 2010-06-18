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

/**
 * {@code Event} is the basical event structure to work with {@link EventDispatcher}.
 * {@code
 * var e = new system.events.Event( "change" , this , "Hello World") ;
 * 
 * trace("> " + e) ;
 * 
 * trace("> target : " + e.getTarget()) ;
 * trace("> type : " + e.getType()) ;
 * trace("> context : " + e.getContext()) ;
 * trace("> timeStamp : " + new Date(e.getTimeStamp()) ) ;
 * }
 */
if ( system.events.Event == undefined) 
{
    /**
     * @requirese
     */
    require("system.events.EventPhase") ;
    
    /**
     * Creates a new {@code Event} instance.
     * <p><b>Example :</b></p>
     * <pre>
     * var e:Event = new Event(type, target, context, [bubbles:Boolean, [eventPhase:Number, [time:Number, [stop:Boolean]]]]) ;
     * </pre>
     * @param type the string type of the instance. 
     * @param target the target of the event.
     * @param context the optional context object of the event.
     * @param bubbles indicates if the event is a bubbling event.
     * @param eventPhase the current EventPhase of the event.
     * @param time this parameter is used in the deserialization of the object.
     * @param stop this parameter is used in the deserialization of the object.
     */
    system.events.Event = function ( type/*String*/ , target/*Object*/ , context/*Object*/ , bubbles /*Boolean*/ , eventPhase /*Number*/ , time /*Number*/ , stop /*Number*/ ) 
    {
        var EventPhase = system.events.EventPhase ;
        
        this._context = context || null ;
        this._target  = target  || null ;
        this._type    = type    || null ;
        
        this._bubbles    = Boolean( bubbles ) ;
        this._eventPhase = isNaN( eventPhase ) ? EventPhase.AT_TARGET : eventPhase ;
        this._time       = ( time > 0 ) ? time : ( ( new Date()).valueOf() ) ;
        this.stop        = isNaN( stop ) ? EventPhase.NONE : stop ;
    }
    
    //////////////
    
    /**
     * @extends Object
     */
    proto = system.events.Event.extend( Object ) ;
    
    //////////////
    
    /**
     * This property indicated in the event model if this event is stopped.
     */
    proto.stop /*uint*/ = null ;
     
    /**
     * Indicates whether the behavior associated with the event can be prevented.
     */
    proto.cancel = function () /*void*/ 
    {
        this._cancelled = true ;
    }
    
    /**
     * Returns the shallow copy of this event.
     * @return the shallow copy of this event.
     */
    proto.clone = function () 
    {
        return new system.events.Event( this._type, this._target , this._context ) ;
    }
    
    /**
     * Returns {@code true} if the event is bubbling.
     * @return {@code true} if the event is bubbling.
     */
    proto.getBubbles = function () /*Boolean*/ 
    {
        return this._bubbles ;
    }
    
    /**
     * Returns the optional context of this event.
     * @return an object, corresponding the optional context of this event.
     */
    proto.getContext = function () /*Object*/ 
    {
        return this._context ;
    }
    
    /**
     * The object that is actively processing the Event object with an event listener.
     */
    proto.getCurrentTarget = function () /*Object*/ 
    {
        return this._currentTarget ;
    }
    
    /**
     * Returns the current phase in the event flow.
     * @return the current phase in the event flow.
     * @see EventPhase
     */
    proto.getEventPhase = function () /*Number*/ 
    {
        return this._eventPhase ;
    }
    
    /**
     * The event target.
     */
    proto.getTarget = function () /*Object*/ 
    {
        return this._target ;
    }
    
    /**
     * Indicates the timestamp of the event.
     */
    proto.getTimeStamp = function () /*Number*/ 
    {
        return this._time ;
    }
    
    /**
     * The type of event.
     */
    proto.getType = function () /*String*/ 
    {
        return this._type ;
    }
    
    /**
     * Initialize the event with the properties type, bubbles, cancelable.
     * @param type the type of the event.
     * @param bubbles a boolean to indicate if the event is a bubbling event.
     * @param cancelable a boolean to indicate if the event is a capturing event.
     */
    proto.initEvent = function (type /*String*/ , bubbles /*Boolean*/, cancelable /*Boolean*/ ) /*void*/ 
    {
        this._type = type ;
        this._bubbles = bubbles ;
        this._cancelled = cancelable ;
        this._time = (new Date()).valueOf() ;
    }
    
    /**
     * Returns {@code true} if the event is cancelled.
     * @return {@code true} if the event is cancelled.  
     */
    proto.isCancelled = function() /*Boolean*/ 
    {
        return this._cancelled ;
    }
    
    /**
     * Returns {@code true} if the event is queued.
     * @return {@code true} if the event is queued.
     */
    proto.isQueued = function() /*Boolean*/ 
    {
        return this._inQueue ;
    }
    
    /**
     * Sets if the event is queued.
     */
    proto.queueEvent = function() /*void*/ 
    {
        this._inQueue = true ;
    }
    
    /**
     * Sets if the event is bubbling.
     */
    proto.setBubbles = function ( b /*Boolean*/ ) /*void*/ 
    {
        this._bubbles = b ;
    }
    
    /**
     * Sets the optional context object of this event. 
     */
    proto.setContext = function ( context /*Object*/ ) /*void*/ 
    {
        this._context = context || null ;
    }
    
    /**
     * Sets the optional context object of this event. 
     */
    proto.setCurrentTarget = function ( target /*Object*/ ) /*void*/ 
    {
        this._currentTarget = target ;
    }
    
    /**
     * Sets the current phase in the event flow.
     */
    proto.setEventPhase = function ( n /*Number*/ ) /*void*/ 
    {
        this._eventPhase = n ;
    }
    
    /**
     * Sets the event target.
     */
    proto.setTarget = function ( target /*Object*/ ) /*void*/ 
    {
        this._target = target || null ;
    }
    
    /**
     * Sets the event type.
     */
     proto.setType = function ( type /*String*/ ) /*void*/ 
     {
        this._type = type || null ;
    }
    
    /**
     * Prevents processing of any event listeners in the current node and any subsequent nodes in the event flow.
     */
    proto.stopImmediatePropagation = function () /*void*/ 
    {
        this.stop = system.events.EventPhase.STOP_IMMEDIATE ;
    }
    
    /**
     * Prevents processing of any event listeners in nodes subsequent to the current node in the event flow.
     */
    proto.stopPropagation = function () /*void*/ 
    {
        this.stop = system.events.EventPhase.STOP ;
    }
    
    /**
     * Returns a Eden representation of the object.
     * @return a string representing the source code of the object.
     */
    proto.toSource = function () /*String*/ 
    {
        var pattern /*String*/ = "new " + this.getConstructorPath() + "({0}, {1}, {2}, {3}, {4}, {5}, {6})" ;
        var args /*Array*/ = 
        [
            (this._type != null ) ? this._type.toSource() : null ,
            (this._target == null || this._target == _global) ? null : this._target.toSource() ,
            (this._context != null) ? this._context.toSource() : null ,
            (this._bubbles != null) ? this._bubbles.toSource() : false ,
            isNaN(this._eventPhase) ? 0 : this._eventPhase.toSource() ,
            isNaN(this._time) ? 0 : this._time ,
            this.stop.toSource() 
        ] ;
        return core.format.apply(this, [pattern].concat(args)) ;
    }
    
    /**
     * Returns the string representation of this event.
     * @return the string representation of this event.
     */
    proto.toString = function () /*String*/ 
    {
        var EventPhase = system.events.EventPhase ;
        var phase /*Number*/ = this._eventPhase ;
        var name /*String*/ = this.getConstructorName() ;
        var txt /*String*/ = "[" + name ;
        
        if (this._type) 
        {
            txt += " " + this._type ;
        }
        
        switch (phase) 
        {
            case EventPhase.CAPTURING_PHASE :
            {
                txt += ", CAPTURING" ;
                break;
            }
            case EventPhase.AT_TARGET:
            {
                txt += ", AT TARGET" ;
                break ;
            }
            case EventPhase.BUBBLING_PHASE:
            {
                txt += ", BUBBLING" ;
                break ;
            }
            default :
            {
                txt += ", (inactive)" ;
                break;
            }
        }
        
        if ( this._bubbles && phase != EventPhase.BUBBLING_PHASE ) 
        {
            txt += ", bubbles" ;
        }
        
        if ( this.isCancelled() ) 
        {
            txt += ", can cancel" ;
        }
        
        txt += "]" ;
        
        return txt ;
    }
    
    //////////////
    
    /**
     * @private
     */
    proto._bubbles /*Boolean*/ = false ;
    
    /**
     * @private
     */
    proto._cancelled /*Boolean*/ = false ;
    
    /**
     * @private
     */
    proto._context /*Object*/ = null ;
    
    /**
     * @private
     */
    proto._currentTarget /*Object*/ = null ;
    
    /**
     * @private
     */
    proto._inQueue /*Boolean*/ = false ;
    
    /**
     * @private
     */
    proto._target /*Object*/ = null ;
    
    /**
     * @private
     */
    proto._time /*Number*/ = 0 ;
    
    /**
     * @private
     */
    proto._type /*String*/ = null ;
    
    /**
     * Sets the timestamp of the event (used this method only in internal in the Event class).
     */
    proto._setTimeStamp = function ( t/*Number*/ ) 
    {
        this._time = t ;
    }
    
    //////////////
    
    delete proto ;
}