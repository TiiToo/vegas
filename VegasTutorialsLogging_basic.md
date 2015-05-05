# Basic Example #

## The source code of this example ##

```

import vegas.logging.ILogger ;
import vegas.logging.ITarget ;
import vegas.logging.Log ;
import vegas.logging.LogEvent ;
import vegas.logging.LogEventLevel ;

import vegas.logging.targets.TraceTarget ;

// 1 - Creates the ITarget reference of the application

var traceTarget:TraceTarget = new TraceTarget() ;

// 2 - Setup the attributes of the ITarget reference.

traceTarget.filters = [ "vegas.logging.*" ] ; 

traceTarget.includeDate = true ;
traceTarget.includeTime = true ;
traceTarget.includeLevel = true ;
traceTarget.includeCategory = true ;
traceTarget.includeLines = true ;

traceTarget.level = LogEventLevel.ALL ;

// 3 - Register the ITarget reference in the Log static manager class. 

Log.addTarget( traceTarget ) ;

// 4 - Dispatch the log messages in your application.

var logger:ILogger = Log.getLogger("vegas.logging.test") ;

logger.log( LogEventLevel.DEBUG, "here is some debug message : {0} and {1}", 2.25 , true) ; 

logger.info("here is some information : {0} and {1}", 2.25 , true) ;

logger.fatal("here is some fatal error.") ; 

logger.error("here is some error.") ;

```

## The process of this example ##

### 1 - Creates the **ITarget** reference of the application ###

`var traceTarget:TraceTarget = new TraceTarget() ;`

In this example the TraceTarget class provides a logger target that uses the global **trace()** method to output log messages.

### 2 - Setup the attributes of the ITarget reference ###

  * Set the filter value of the target, the filters array contains a pseudo-hierarchical mapping for processing only those events for a given category of logs.

  * Sets the specific attributes of the TraceTarget instance to indicates in the logs the category, the date, the level, the time of the current log message.

### 3 - Register the **ITarget** references in the **Log** manager class. ###

### 4 - Dispatch the log messages in your application ###

Use an **ILogger** singleton to dispatch the log messages of the application to the **ITarget** references.
