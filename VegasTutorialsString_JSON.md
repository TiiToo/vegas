# The JSON class #

  * [Returns tutorial index page](TutorialsVEGAS.md)
    * [Returns Strings in VEGAS](VegasTutorialsString.md)

## Description ##

JSON (JavaScript Object Notation)is a lightweight data-interchange format. It is based on a subset of the JavaScript Programming Language, Standard [ECMA-262 3rd Edition - December 1999](http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf).

This text format is a good solution to create config files, external data structures with a notation near of the actionscript notation.

Official page project of JSON : http://www.json.org/

In VEGAS, i have implement a new version of the JSON class with an AS2, AS3 and SSAS version, the big differences with the official version are :

  * Supports the hexa numbers in the string with the notation : **0xrrggbb**.
  * Supports in the objects deserialization the key property with quote, double quote or not surrounded by quotes.
  * Supports in string deserialization simple or double quotes.
  * Supports with the AS2 version of the **vegas.string.JSON** class compile with MTASC.

In VEGAS the JSON singleton is an instance of the JSONSerializer class :

  * [view source](http://code.google.com/p/vegas/source/browse/AS3/trunk/sources/vegas/string/json/JSONSerializer.as)

## Serialize example ##

```
import vegas.string.JSON ;
 
var a:Array = [2, true, "coucou"] ;
var o:Object = { prop1 : 1 , prop2 : 2 } ;
var s:String = "hello world" ;
var n:Number = 4 ;
var b:Boolean = true ;
 
trace("* a : " + JSON.serialize( a ) )  ;	
trace("* o : " + JSON.serialize( o ) )  ;
trace("* s : " + JSON.serialize( s ) )  ;
trace("* n : " + JSON.serialize( n ) )  ;
trace("* b : " + JSON.serialize( b ) )  ;
```

## Deserialize example ##

```
import vegas.string.JSON ;
 
var source:String = '[ { prop1 : 0xFF0000 , "prop2":2, prop3:"hello", prop4:true} , 2, true, 3, [3, 2] ]' ;
 
var o = JSON.deserialize(source) ;
var l:Number = o.length ;
for (var i:Number = 0 ; i<l ; i++) 
{
     trace("> " + i + " : " + o[i] + " -> typeof :: " + typeof(o[i])) ;
     if (typeof(o[i]) == "object") 
     {
          for (var each:String in o[i]) 
          {
              trace("    > " + each + " : " + o[i][each] + " :: " + typeof(o[i][each]) ) ;
          }
     }
}
```

## Handling errors ##

If the JSON string isn't compatible with the JSON parser, a **vegas.string.errors.JSONError** is notify in the application.

```
import vegas.string.JSON ;
import vegas.string.errors.JSONError ;
 
var source:String = "[3, 2," ;
try
{
    var o = JSON.deserialize(source) ;
}
catch(e:JSONError)
{
    trace( e.toString()) ; // output: [JSONError] Bad Array, at:6 in "[3, 2,"
}
```