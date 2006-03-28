/*

	MTASC TEST

*/

//import vegas.logging.LuminicTracer ;
import vegas.logging.SOSTracer ;

class vegas.Test {

	// ----o Constructor
	
	public function Test() {
		
		trace ("TEST :: Constructor") ;
		SOSTracer.trace("here is some myDebug info : {0} and {1}", 2.25 , true) ;
		
	}

	// ----o Main
	
	static public function main():Void {
		
		Stage.align = "" ;
		Stage.scaleMode = "noScale" ;
	
		//LuminicTracer.initialize("__TEST__") ;
		SOSTracer.initialize("TEST SOS", 0xFCE7C7, true) ;

		
		var t:Test = new Test() ;
		
	}	
	
}