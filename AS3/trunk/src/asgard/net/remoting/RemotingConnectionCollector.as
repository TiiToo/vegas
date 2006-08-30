package asgard.net.remoting
{
	
	import asgard.net.remoting.RemotingConnection;

	import vegas.data.map.HashMap;
	import vegas.errors.Warning;
	import vegas.errors.IllegalArgumentError;
	
	public class RemotingConnectionCollector
	{
		
		// ----o Constructor
		
		public function RemotingConnectionCollector()
		{
			throw new IllegalArgumentError("You can't instanciate RemotinfConnectionCollector constructor") ; 
		}
		
		// ----o Public Methods
	
		static public function clear():void
		{
			_map.clear() ;	
		}
		
		static public function contains( sName:String ):Boolean 
		{
			return _map.containsKey( sName ) ;	
		}
		
		static public function get(sName:String):RemotingConnection 
		{
			try 
			{
				if (!contains(sName) ) 
				{
					throw new Warning("[RemotingConnectionCollector].get(\"" + sName + "\"). Can't find RemotingConnection instance." ) ;
				} ;
			} 
			catch (e:Warning) 
			{
				e.toString() ;
			}
			
			return RemotingConnection(_map.get(sName)) ;	
		}
		
		static public function insert(sName:String, rc:RemotingConnection):Boolean 
		{
			try 
			{
				if ( contains(sName) ) 
				{
					throw new Warning("[RemotingConnectionCollector].insert(). A RemotingConnection instance is already registered with '" + sName + "' name." ) ;
				} ;
			}
			catch (e:Warning) 
			{
				e.toString() ;
			}
			return Boolean(_map.put(sName, rc))   ;	
			
		}
		
		static public function isEmpty():Boolean 
		{
			return _map.isEmpty() ;	
		}
		
		static public function remove(sName:String):void
		{
			_map.remove(sName) ;
		}
		
		static public function size():uint
		{
			return _map.size() ;
		}
		
		// ----o Private Properties
		
		static private var _map:HashMap = new HashMap() ;	
		
	}


}