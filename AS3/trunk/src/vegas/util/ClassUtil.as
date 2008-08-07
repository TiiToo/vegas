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
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * 
         * import vegas.util.ClassUtil ;
         * 
         * Array.prototype.toString = function():String
         * {
         *     return "[" + this.join(",") + "]" ;
         * }
         * 
         * var ar:Array
         * 
         * // test with no argument
         * ar = ClassUtil.buildNewInstance( Array , [] ) ;
         * trace( ar ) ;
         * //output: []
         * 
         * // test with 0 arguments
         * ar = ClassUtil.buildNewInstance( Array , [] ) ;
         * trace( ar ) ;
         * //output: []
         * 
         * // test with 2 arguments
         * ar = ClassUtil.buildNewInstance( Array , Arrays.initialize(2,0) ) ;
         * trace( ar ) ;
         * //output: [0,0]
         * 
         * // test with 32 arguments
         * ar = ClassUtil.buildNewInstance( Array , Arrays.initialize(32,0) ) ;
         * trace( ar ) ;
         * //output: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
         * 
         * // test with 33 arguments
         * ar = ClassUtil.buildNewInstance( Array , Arrays.initialize(33,0) ) ;
         * trace( ar ) ;
         * 
         * //output:
         * // ArgumentError: ClassUtil.buildNewInstance() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.
         * </pre>
         * @param clazz The Class of the instance to build.
         * @param args The array of all arguments to passed-in.
         */
        public static function buildNewInstance( clazz:Class, args:Array=null ):*
		{
            if ( args != null && args.length > 0 )
            {
                switch( args.length )
                {
                    case  1 : return new clazz(args[0]) ; break ;
                    case  2 : return new clazz(args[0],args[1]) ; break ;
                    case  3 : return new clazz(args[0],args[1],args[2]) ; break ;                
                    case  4 : return new clazz(args[0],args[1],args[2],args[3]) ; break ;
                    case  5 : return new clazz(args[0],args[1],args[2],args[3],args[4]) ; break ;
                    case  6 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5]) ; break ;
                    case  7 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6]) ; break ;
                    case  8 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]) ; break ;
                    case  9 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8]) ; break ;
                    case 10 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9]) ; break ;
                    case 11 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10]) ; break ;
                    case 12 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11]) ; break ;
                    case 13 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12]) ; break ;
                    case 14 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13]) ; break ;
                    case 15 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14]) ; break ;
                    case 16 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15]) ; break ;
                    case 17 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16]) ; break ;
                    case 18 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17]) ; break ;
                    case 19 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18]) ; break ;
                    case 20 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19]) ; break ;
                    case 21 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20]) ; break ;
                    case 22 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21]) ; break ;
                    case 23 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22]) ; break ;
                    case 24 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23]) ; break ;
                    case 25 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24]) ; break ;
                    case 26 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25]) ; break ;
                    case 27 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25],args[26]) ; break ;
                    case 28 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25],args[26],args[27]) ; break ;
                    case 29 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25],args[26],args[27],args[28]) ; break ;
                    case 30 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25],args[26],args[27],args[28],args[29]) ; break ;
                    case 31 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25],args[26],args[27],args[28],args[29],args[30]) ; break ;
                    case 32 : return new clazz(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13],args[14],args[15],args[16],args[17],args[18],args[19],args[20],args[21],args[22],args[23],args[24],args[25],args[26],args[27],args[28],args[29],args[30],args[31]) ; break ;
                    default :
                    {
                        throw new ArgumentError( "ClassUtil.buildNewInstance() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.") ; 
                    }
                }
            }
            else
            {
                return new clazz() ;
            }
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
	}	
}

