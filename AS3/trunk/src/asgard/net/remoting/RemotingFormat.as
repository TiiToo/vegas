package asgard.net.remoting
{
	
	import asgard.data.iterator.RecordSetIterator;
	import asgard.data.remoting.RecordSet;
	import asgard.net.remoting.RemotingService;
	
	import vegas.core.IFormat;
	import vegas.core.CoreObject;

	public class RemotingFormat extends CoreObject implements IFormat
	{

		// ----o Constructor
	
		public function RemotingFormat()
		{
			super();
		}

		// ----o Public Methods
	
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