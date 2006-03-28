/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2005
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

/** 	RemotingFormat

	AUTHOR
	
		Name : RemotingFormat
		Package : asgard.remoting
		Version : 1.0.0.0
		Date :  2005-12-02
		Author : ekameleon
		URL : http://www.ekameleon.net
		Mail : vegas@ekameleon.net

	METHOD SUMMARY
	
		- formatToString(o):String
	
	IMPLEMENTS
	
		IFormat

----------  */

import asgard.remoting.RemotingConnector ;

import vegas.data.iterator.Iterator ;
import vegas.core.IFormat ;

import mx.remoting.RecordSet ; // TODO voir à s'isoler du package mx.

class asgard.remoting.RemotingFormat implements IFormat {

	// ----o Constructor
	
	public function RemotingFormat() {
		//
	}

	// ----o Public Methods

	public function formatToString(o):String {
		var rc:RemotingConnector = RemotingConnector(o);
		var r = rc.results ;
		var txt:String = "[" ;
		if (rc.serviceName) txt += "\r\tserviceName : " + rc.serviceName + " , " ;
		if (rc.methodName) txt += "\r\tmethodName : " + rc.methodName + " ," ;
		if (rc.serviceName) txt += "\r\tresult : " ;
		if (r != undefined) {
			if (r instanceof RecordSet) {
				txt += "[\r" ;
				var it:Iterator = r.getIterator() ;
				while (it.hasNext()) {
					var oC = it.next() ;
					txt += "\t[\r" ;
					for (var prop:String in oC) txt += "\t\t " + prop + " : " + oC[prop] + "\r" ;
					txt += "\t] " ; 
					txt += (it.hasNext()) ? ",\r" : "\r" ;
				}	
			} else {
				txt += r  + "\r";
			}
			txt += "]" ;
		} else {
			txt += "empty ";
			if (rc.serviceName || rc.methodName) txt += "\r" ;
			txt += "]" ;
		}
		return txt ;
	}
	
}