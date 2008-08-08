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
    import flash.utils.Dictionary;
    
    import system.Reflection;    

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
         * ar = ClassUtil.buildNewInstance( Array ) ;
         * trace( ar ) ;
         * //output: []
         * 
         * // test with 0 argument
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
            var c:Class = clazz ;
            if ( args != null && args.length > 0 )
            {
                var a:Array = args ;
                switch( a.length )
                {
                    case  1 : return new c(a[0]) ;
                    case  2 : return new c(a[0],a[1]) ;
                    case  3 : return new c(a[0],a[1],a[2]) ;                
                    case  4 : return new c(a[0],a[1],a[2],a[3]) ;
                    case  5 : return new c(a[0],a[1],a[2],a[3],a[4]) ;
                    case  6 : return new c(a[0],a[1],a[2],a[3],a[4],a[5]) ;
                    case  7 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6]) ;
                    case  8 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7]) ;
                    case  9 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8]) ;
                    case 10 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9]) ;
                    case 11 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10]) ;
                    case 12 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11]) ;
                    case 13 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12]) ;
                    case 14 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13]) ;
                    case 15 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14]) ;
                    case 16 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15]) ;
                    case 17 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16]) ;
                    case 18 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17]) ;
                    case 19 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18]) ;
                    case 20 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19]) ;
                    case 21 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20]) ;
                    case 22 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21]) ;
                    case 23 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22]) ;
                    case 24 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23]) ;
                    case 25 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24]) ;
                    case 26 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25]) ;
                    case 27 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26]) ;
                    case 28 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27]) ;
                    case 29 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28]) ;
                    case 30 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29]) ;
                    case 31 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30]) ;
                    case 32 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30],a[31]) ;
                    default :
                    {
                        throw new ArgumentError( "ClassUtil.buildNewInstance() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.") ; 
                    }
                }
            }
            else
            {
                return new c() ;
            }
        }
        
        /**
         * Returns the unique name of the specified instance in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import flash.display.Sprite ;
         * 
         * trace( ClassUtil.getUniqueName( new Sprite()  ) ) ; // Sprite0
         * trace( ClassUtil.getUniqueName( new Sprite()  ) ) ; // Sprite1
         * 
         * trace( ClassUtil.getUniqueName( new Sprite() , true ) ) ; // flash.display.Sprite0
         * trace( ClassUtil.getUniqueName( new Sprite() , true ) ) ; // flash.display.Sprite1
         * </pre>
         * @return the unique name of the specified instance in argument.
         */
        public static function getUniqueName( o:* , isFull:Boolean=false ):String
        {
            var name:String = isFull ? Reflection.getClassPath( o ) : Reflection.getClassName( o ) ;
            var charCode:int = name.charCodeAt( name.length - 1 );
            if (charCode >= 48 && charCode <= 57) // if the class name finish with a number 0..9
            {
                name += "_" ;
            }
            if ( _clazzBuffer[name] == null )
            {
                _clazzBuffer[name] = 0 ;    
            }
            else
            {
                _clazzBuffer[name] ++ ;
            }
            return name + _clazzBuffer[name] ;
        }
        
        /**
         * @private
         */
        private static var _clazzBuffer:Dictionary = new Dictionary(true) ;
         
    }    
}

