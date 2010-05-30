
load("trace.js") ;
load("buRRRn.js") ;
load("system.js") ;

a = function()
{
    
}

b = a ;

trace( a == b ) ;

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

trace( slot1 == slot2 ) ;
trace( slot1.receiver == slot2.receiver ) ;

slot1.receive() ;
slot2.receive() ;



signal = new system.signals.InternalSignal() ;

trace( signal.connect( slot1 , 2 ) ) ;
trace( signal.connect( slot2 , 0 ) ) ;
trace( signal.connect( slot3 , 1 ) ) ;