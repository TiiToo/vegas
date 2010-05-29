try
{
    dummy = trace ;
}
catch( e )
{
    trace = function( message /*String*/ )
    {
        print( message ) ;
    }
}