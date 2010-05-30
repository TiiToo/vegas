
load("trace.js") ;
load("buRRRn.js") ;
load("system.js") ;

load("unittests/Application.js") ;

slot = function( message )
{
    trace( "slot message:" + message ) ;
}

var signal = new system.signals.Signal([String]) ; 

//var signal = new system.signals.Signal() ;

signal.connect( slot ) ;

signal.emit( "hello world" ) ;

