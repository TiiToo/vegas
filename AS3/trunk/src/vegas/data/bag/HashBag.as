package vegas.data.bag
{

	import vegas.data.Collection ;
	import vegas.data.Map;
	import vegas.data.map.HashMap ;
	
	import vegas.util.Copier ;
	import vegas.util.Serializer ;

	public class HashBag extends AbstractBag
	{
		
		// ----o Constructor
		
		public function HashBag(c:Collection=null)
		{
			super(new HashMap());
			if (c != null) 
			{
				insertAll(c) ;
			}
		}
	
		// ----o Public Methods
	
		override public function clone():*
		{
			return new HashBag(_getMap().clone()) ;
		}

		override public function copy():*
		{
			return new HashBag( Copier.copy(_getMap()) ) ;
		}

		override public function toSource(...arguments:Array):String 
		{
			return Serializer.getSourceOf(this, [_extractList()] ) ;
		}
		
	}
}