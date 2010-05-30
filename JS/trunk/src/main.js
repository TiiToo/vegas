
load("trace.js") ;
load("buRRRn.js") ;
load("system.js") ;

load("unittests/Application.js") ;


Slot = function( name )
{
    this.name = name ;
}

Slot.extend( system.signals.Receiver ) ;

Slot.prototype.receive = function ( message ) 
{
    trace( this + " : " + message ) ;
}

Slot.prototype.toString = function () 
{
    return "[Slot name:" + this.name + "]" ;
}

slot1 = new Slot("slot1") ;

slot2 = function( message )
{
    trace( this + " : " + message ) ;
}

var signal = new system.signals.Signal() ;

signal.proxy = slot1 ;

signal.connect( slot1 ) ;
signal.connect( slot2 ) ;

signal.emit( "hello world" ) ;

