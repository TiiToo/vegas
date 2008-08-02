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
ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
Portions created by the Initial Developer are Copyright (C) 2004-2008
the Initial Developer. All Rights Reserved.
  
Contributor(s) :
  
 */

package vegas.util
{
    import system.Reflection;
    
    import vegas.core.HashCode;
    import vegas.core.IHashable;    

    /**
	 * The <code class="prettyprint">ClassUtil</code> utility class is an all-static class with methods for working with function the Class in AS3.
	 * @author eKameleon
	 */
	public class ClassUtil
	{

        /**
         * Wrapping method which select which build method use according to the argument count (32 max).
         * @param clazz The Class of the instance to build.
         * @param args The array of all arguments to passed-in.
         */
        public static function buildNewInstance( clazz:Class, args:Array=null ):*
		{
			var build:Function  = _builders[ (args != null) ? args.length : 0 ] ;
			var params:Array    = [ clazz ] ;
			if ( args != null )
			{
				if ( args.length > 0 )
				{
					params = params.concat( args );
				}
			}
			return build.apply( null, params );
	    }
		
		/**
		 * Creates an instance with the passed-in Class.
		 * @param c the class to instanciate.
		 * @param initProperties An object with all properties to to pass over the new instance.
		 * @return a new instance of the specified Class in argument.
		 */
		public static function createNewInstance( clazz:Class = null , initProperties:Object = null , args:Array=null ):* 
		{
			if ( clazz == null )
			{
				return null ;
			}
			var instance:* = buildNewInstance( clazz, args ) ;
			if (initProperties != null) 
			{
				for (var prop:String in initProperties)
				{
					instance[prop] = initProperties[prop];
				}
			}
			return instance ;
		}
        
        /**
		 * Returns the unique name of the specified instance in argument.
		 * @return the unique name of the specified instance in argument.
		 */
		public static function getUniqueName(instance:*):String
		{
			var name:String = Reflection.getClassName( instance ) ;
			var charCode:int = name.charCodeAt( name.length - 1 );
			if (charCode >= 48 && charCode <= 57)
			{
				name += "_" ;
			}
			var count:uint ;
			if ( instance is IHashable )
			{
				count = (instance as IHashable).hashCode() ;		 
			}	
			else
			{
				count = HashCode.next() ;
			}
			
			return name + count ;
		}


		/**
		 * @private
		 */
		private static var _builders:Array =
		[
			function( clazz:Class  ):* { return new clazz() ; } ,
			function( clazz:Class ,a01:* ):* { return new clazz(a01) ; } ,
			function( clazz:Class ,a01:*,a02:* ):* { return new clazz(a01,a02) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:* ):* { return new clazz(a01,a02,a03) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:* ):* { return new clazz(a01,a02,a03,a04) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:* ):* { return new clazz(a01,a02,a03,a04,a05) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:* ):* { return new clazz(a01,a02,a03,a04,a05,a06) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:*,a26:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:*,a26:*,a27:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:*,a26:*,a27:*,a28:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:*,a26:*,a27:*,a28:*,a29:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:*,a26:*,a27:*,a28:*,a29:*,a30:* ):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:*,a26:*,a27:*,a28:*,a29:*,a30:*,a31:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31) ; } ,
			function( clazz:Class ,a01:*,a02:*,a03:*,a04:*,a05:*,a06:*,a07:*,a08:*,a09:*,a10:*,a11:*,a12:*,a13:*,a14:*,a15:*,a16:*,a17:*,a18:*,a19:*,a20:*,a21:*,a22:*,a23:*,a24:*,a25:*,a26:*,a27:*,a28:*,a29:*,a30:*,a31:*,a32:*):* { return new clazz(a01,a02,a03,a04,a05,a06,a07,a08,a09,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32) ; } 			
		] ;

	}
}