/*

    Licence
    
        Copyright (c) 2005 JSON.org

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
    
        The Software shall be used for Good, not Evil.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    
    Contributor(s) :
    
        - Ported to Actionscript May 2005 by Trannie Carter <tranniec@designvox.com>, wwww.designvox.com
        
        - Alcaraz Marc (aka eKameleon) 2006-01-24 <vegas@ekameleon.net> 
        
            - Refactoring AS2 and MTASC Compatibilty 
            - AS3 version
            - SSAS version (for 'Flash Communication Server' and 'Flash Media Server')
            - Add Hexa Digits in 'deserialize' method
            - Supports in the objects deserialization the key property with quote, double quote or not surrounded by quotes.
            - Supports in string simple or double quotes.    
            
            More informations in the VEGAS page project : http://code.google.com/p/vegas/
            
            NOTE : eden Hexa digits code inspiration -> http://code.google.com/p/edenrr/

*/
package vegas.string
{
    import vegas.string.json.JSONSerializer;        
    
    
    /**
     * <code class="prettyprint">JSON</code> (JavaScript object Notation) is a lightweight data-interchange format.
     * <p>More information in the official site : <a href="http://www.JSON.org/">http://www.JSON.org</a></p>
     * <p>Add Hexa Digits tool in deserialize method - <a href="http://code.google.com/p/edenrr/">eden inspiration</a></p>
     * @example
     * <pre class="prettyprint">
     * import vegas.string.JSON;
     * import vegas.string.errors.JSONError;
     * 
     * import system.Reflection ;
     * 
     * // --- Init
     * 
     * var a:Array = [2, true, "hello"] ;
     * var o:Object = { prop1 : 1 , prop2 : 2 } ;
     * var s:String = "hello world" ;
     * var n:Number = 4 ;
     * var b:Boolean = true ;
     * 
     * trace("# Serialize \r") ;
     * 
     * trace("- a : " + JSON.serialize( a ) )  ;
     * trace("- o : " + JSON.serialize( o ) )  ;
     * trace("- s : " + JSON.serialize( s ) )  ;
     * trace("- n : " + JSON.serialize( n ) )  ;
     * trace("- b : " + JSON.serialize( b ) )  ;
     * 
     * trace ("\r# Deserialize \r") ;
     * 
     * var source:String = '[ { "prop1" : 0xFF0000 , prop2:2, prop3:"hello", prop4:true} , 2, true, 3, [3, 2] ]' ;
     * 
     * o = JSON.deserialize(source) ;
     * 
     * var l:uint = o.length ;
     * for (var i:uint = 0 ; i < l ; i++)
     * {
     *     trace("> " + i + " : " + o[i] + " -> typeof :: " + typeof(o[i])) ;
     *     if (typeof(o[i]) == "object")
     *     {
     *         for (var each:String in o[i])
     *         {
     *             trace("    > " + each + " : " + o[i][each] + " :: " + Reflection.getClassName(o[i][each]) ) ;
     *         }
     *     }
     * }
     * 
     * trace ("\r# JSONError \r") ;
     * 
     * source = "[3, 2," ; // test1
     * 
     * // var source:String = '{"prop1":coucou"}' ; // test2
     * 
     * try
     * {
     *    var errorObj:* = JSON.deserialize(source) ;
     * }
     * catch( e:JSONError )
     * {
     *     trace( e.toString() ) ;
     * }
     * </pre>
     * @author eKameleon
     */
    public var JSON:JSONSerializer = new JSONSerializer() ;
    
}