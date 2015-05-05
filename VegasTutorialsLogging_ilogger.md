# The ILogger interface #

## The log methods ##

All loggers within the logging framework must implement this interface.

The ILogger interface defines the log methods to dispatch log message with a specific level. This interface contains 6 methods :

  * debug() : Logs the specified data using the **LogEventLevel.DEBUG** level.
  * error() : Logs the specified data using the **LogEventLevel.ERROR** level.
  * fatal() : Logs the specified data using the **LogEventLevel.FATAL** level.
  * info()  : Logs the specified data using the **LogEventLevel.INFO** level.
  * warn()  : Logs the specified data using the **LogEventLevel.WARN** level.

  * log() : Logs the specified data at the given level. This method is used in the other methods of the interface.

All the previous methods use arguments.

The first argument is the data (or message) to dispatch in the log flow of the application.

If the first argument message is a String, can contains braces with an index indicating which additional parameter should be inserted into the string before it is logged.

Example :

```
import vegas.logging.ILogger ;
import vegas.logging.Log ;

var logger:ILogger = Log.getLogger("my_logger") ;
logger.debug( "the first additional parameter was {0} the second was {1}" , 100, true ) ;
```

## The LogLogger class ##

The concrete class of the **ILogger** interface is the [LogLogger](http://svn.riaforge.org/vegas/AS2/trunk/src/vegas/logging/LogLogger.as) class.

This class dispatches events for each message logged using the log() method.

This class is use in the **Log** factory to creates **ILogger** references with the **Log.getLogger()** method.

To creates a new **ILogger** reference you must use the **Log** class and not the **new** keyword.

```
var logger:ILogger = Log.getLogger("my_category") ;
```

## The category R/W property and singletons ##

All **ILoggers** reference in the application are singletons with a specific **category** value. In the AS3 version the **ILogger** interface contains the R/W virtual property **category**.

Example :

```

var logger1:ILogger = Log.getLogger("my_category") ;

var logger2:ILogger = Log.getLogger("my_category") ;

trace( logger1 == logger2 ) ; // true

```


The **category** of the **ILogger** is the channel to dispatch the log messages. Only the ITarget registered in this category can receive the logs.
