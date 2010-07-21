///////////////////////////

load( "trace.js" ) ;


load( "buRRRn.js" ) ;
load( "core.js"   ) ;
load( "system.js" ) ;

///////////////////////////

load("unittests/Application.js") ;

///////////////////////////



ExpressionFormatter = system.formatters.ExpressionFormatter ;

formatter = new ExpressionFormatter() ;

formatter.expressions.put( "root"      , "c:"                     ) ;
formatter.expressions.put( "system"    , "{root}/project/system"  ) ;
formatter.expressions.put( "data.maps" , "{system}/data/maps"     ) ;
formatter.expressions.put( "map"       , "{data.maps}/HashMap.as" ) ;

source = "the root : {root} - the class : {map}" ; 
// the root : c: - the class : c:/project/system/data/maps/HashMap.as

trace( formatter.format( source ) ) ;

trace( "----" ) ;

formatter.expressions.put( "system"    , "%root%/project/system" ) ;
formatter.expressions.put( "data.maps" , "%system%/data/maps" ) ;
formatter.expressions.put( "HashMap"   , "%data.maps%/HashMap.as" ) ;

formatter.beginSeparator = "%" ;
formatter.endSeparator   = "%" ;

source = "the root : %root% - the class : %HashMap%" ;

trace( formatter.format( source ) ) ;
// the root : c: - the class : c:/project/system/data/maps/HashMap.as