/**
 * @requires 
 */
load( "library/vegas.js" ) ;

// test VEGAS

var core = new vegas.core.CoreObject() ;
trace(core) ;

// test CalistA

MD5 = calista.hash.MD5 ;

var hash = MD5.encrypt("calista") ;
var equal = hash == '93fc1e28bc17af6420552b746af10f4f' ;
 
trace("'calista' MD5 result : " + hash + " : " + equal ) ;

// E4X

var x = <item><subitem>bonjour</subitem><subitem>hello</subitem><subitem>hi</subitem></item> ;
trace( x.subitem[0] ) ;

// TODO find and fix the __resolve methods in the framework.