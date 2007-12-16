
package test
{

	import vegas.core.CoreObject ;

	/**
 	 * The Address class.
 	 */
	public class Address extends CoreObject
	{
	
		/**
		 * Creates a new Address instance.
		 */
		public function Address( city:String = null , street:String = null , zip:Number = NaN )
		{
			this.city   = city ;
			this.street = street ;
			this.zip    = zip    ;
		}

		/**
		 * The city of this address.
		 */
		public var city:String ;
		
		/**
		 * The street of this address.
		 */
		public var street:String ; 
	
		/**
		 * The zip code of this address.
	 	*/
		public var zip:Number ;
	
	}

}