///////////////////////////

load( "trace.js" ) ;


load( "buRRRn.js" ) ;
load( "core.js"   ) ;
load( "system.js" ) ;

///////////////////////////

load("unittests/Application.js") ;

///////////////////////////

trace( core.reflect.hasDefinitionByName("core.dump") ) ;
trace( core.reflect.hasDefinitionByName("core.reflect.hasDefinitionByName") ) ;
trace( core.reflect.hasDefinitionByName("core.Unknow") ) ;
trace( core.reflect.hasDefinitionByName("a") ) ;
trace( core.reflect.hasDefinitionByName("unknow") ) ;
trace( core.reflect.hasDefinitionByName("unknow") ) ;