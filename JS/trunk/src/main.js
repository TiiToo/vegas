
load("trace.js") ;
load("buRRRn.js") ;
load("system.js") ;

Slot = function( name /*String*/ )
{
    this.name = name ;
}

Slot.extend( system.signals.Receiver ) ;

Slot.prototype.receive = function ( ) /*void*/ 
{
    trace( this + " receive" ) ;
}

Slot.prototype.toString = function ( ) /*String*/ 
{
    return "[Slot name:" + this.name + "]" ;
}

slot1 = new Slot("slot1") ;
slot2 = new Slot("slot2") ;
slot3 = new Slot("slot3") ;

signal = new system.signals.InternalSignal() ;

trace( signal.connect( slot1 , 0 ) ) ;
trace( signal.length ) ;

trace("---") ;

trace( signal.connect( slot2 , 2 ) ) ;
trace( signal.length ) ;

trace("---") ;

trace( signal.connect( slot3 , 1 ) ) ;
trace( signal.length ) ;

trace("---") ;

trace( signal.connect( slot2 )  ) ;
trace( signal.length ) ;

trace("---") ;

trace( signal.disconnect( slot2 )  ) ;
trace( signal.hasReceiver( slot2 )  ) ;
trace( signal.length ) ;

trace("---") ;

trace( signal.disconnect()  ) ;
trace( signal.connected() ) ;
trace( signal.length ) ;