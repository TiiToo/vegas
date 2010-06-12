
///////////////////////////

load( "trace.js" ) ; // Rhino hack

load( "buRRRn.js" ) ;
load( "core.js"   ) ;
load( "system.js" ) ;

///////////////////////////

load("unittests/Application.js") ;

///////////////////////////

var target = new system.logging.targets.TraceTarget() ;

target.filters        = [ "examples.*" ] ;
target.level          = system.logging.LoggerLevel.ALL ;

target.includeDate    = true ;
target.includeTime    = true ;
target.includeLevel   = true ;
target.includeChannel = true ;
target.includeLines   = true ;

var logger = system.logging.Log.getLogger( "examples" ) ;

logger.log   ( "Here is some myDebug info : {0} and {1}", 2.25 , true ) ;
logger.debug ( "Here is some debug message." ) ;
logger.info  ( "Here is some info message." ) ;
logger.warn  ( "Here is some warn message." ) ;
logger.error ( "Here is some error message." ) ;
logger.fatal ( "Here is some fatal error..." ) ;

target.includeDate    = false ;
target.includeTime    = false ;
target.includeChannel = false ;

logger.info( "test : [{0}, {1}, {2}]", 2, 4, 6 ) ;