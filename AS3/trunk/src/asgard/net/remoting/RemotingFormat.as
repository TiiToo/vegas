/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package asgard.net.remoting
{
	
	import asgard.data.iterator.RecordSetIterator;
	import asgard.data.remoting.RecordSet;
	import asgard.net.remoting.RemotingService;
	
	import vegas.core.IFormat;
	import vegas.core.CoreObject;

    /**
     * @author eKameleon
     */
	public class RemotingFormat extends CoreObject implements IFormat
	{

		public function RemotingFormat()
		{
			super();
		}

		public function formatToString(o:*):String 
		{
			var rs:RemotingService = RemotingService(o);
			var r:* = rs.getResult() ;
			var txt:String = "[" ;
			if (rs.getServiceName()) txt += "\r\tserviceName : " + rs.getServiceName() + " , " ;
			if (rs.getMethodName()) txt += "\r\tmethodName : " + rs.getMethodName() + " ," ;
			if (rs.getServiceName()) txt += "\r\tresult : " ;
			if (r != undefined) 
			{
				if (r is RecordSet) 
				{
					txt += "[\r" ;
					var it:RecordSetIterator = r.iterator() ;
					while (it.hasNext()) 
					{
						var oC:* = it.next() ;
						txt += "\t[\r" ;
						for (var prop:String in oC) 
						{
							txt += "\t\t " + prop + " : " + oC[prop] + "\r" ;
						}
						txt += "\t] " ; 
						txt += (it.hasNext()) ? ",\r" : "\r" ;
					}	
				}
				else 
				{
					txt += r  + "\r";
				}
				txt += "]" ;
			}
			else 
			{
				txt += "empty";
				if (rs.getServiceName() || rs.getMethodName()) txt += "\r" ;
				txt += "]" ;
			}
			return txt ;
		}
	
	}
	
}