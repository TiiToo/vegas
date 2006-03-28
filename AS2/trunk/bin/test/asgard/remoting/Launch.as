/* -----

The PHP Service

	<?php
	
	include_once("../amfphp/util/MethodTable.php");
	
	class Test {
		
		// -----o Constructor
		
		function Test () {
			$this->methodTable = MethodTable::create("Test") ;
		}
 
		// ----- Method
		
		function hello($who) {
			//trigger_error("ooooo") ;
			return "hello " . $who . " !" ;
		}
	}
	
	?>


---- */

import vegas.events.EventListenerProxy ;
import vegas.remoting.RemotingConnector ;
import vegas.remoting.RemotingEventType ;

// MTASC TEST !! launch with mtasc this main class !!!
// use SOSTracer or LuminicTracer to test this class in a output console please !

class Launch {

	// ----o Constructor
	
	public function Launch(target:MovieClip) {
		
		// ---- start initialize debug

		// .... choose luminic or SOS console here...
		
		// ---- end initialize debug
		
		trace ("Test Remoting class") ; //, Level.DEBUG) ;
		
		var rc:RemotingConnector = new RemotingConnector() ;
		rc.addEventListener(RemotingEventType.RESULT, new EventListenerProxy(this, result)) ;
		rc.addEventListener(RemotingEventType.FAULT, new EventListenerProxy(this, fault)) ;

		rc.gatewayUrl = "http://localhost/vegas/php/gateway.php" ;
		rc.serviceName = "Test" ;
		rc.methodName = "hello" ;
		rc.params = ["ekameleon"] ;

		rc.trigger() ;
		
	}


	// ----o Main

	static public function main() {
		var go:Launch = new Launch(_root) ;
	}	
	
	// ----o Public Methods
	
	function fault(ev:Object):Void {
		trace (ev.type + " : " + ev.fault.faultstring) ;
	}

	function result(ev:Object):Void {
		trace (ev.type + " : " + ev.result) ;
	}
	

}