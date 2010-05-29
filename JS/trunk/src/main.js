
load("trace.js") ;
load("buRRRn.js") ;
load("system.js") ;

slot = function( )
{
    trace("slot") ;
}

signal = new system.signals.InternalSignal() ;

signal.connect( slot ) ;