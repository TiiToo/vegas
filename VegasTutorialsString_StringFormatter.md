# The StringFormatter class #

  * [Returns tutorial index page](TutorialsVEGAS.md)
    * [Returns Strings in VEGAS](VegasTutorialsString.md)

## Description ##

The **StringFormatter** class is used to create instances who can format a **String** object with a specific pattern.

A **pattern** is a string with text and braces with an index ( **{index}** ). The formatting process replace all braces with an index with the parameters inserted in the format method of the class.

The syntax of an element to format is **{index[,alignment][:formatString]}**

#### 1 - index ####

Represent the index argument goes into the format method of the instance.

#### 2 - alignment (optional) ####

This optional property represents the minimal length of the replaced string value.

**Postive values** : the string argument will be right justified and if the string is not long enough, the string will be padded with spaces on the left.

**Negative values** : the string argument will be left justied and if the string is not long enough, the string will be padded with spaces on the right.

If this value was not specified, we will default to the length of the string argument.

#### 3 - formatString (optional) ####

An optional string to replace the alignement character in the specified indexed brace value with the **alignement** value.

## Examples ##

### 1 - Basic example ###

The **format()** method remplace all indexed elements defines in the braces with the specified parameters in the method.

```
import vegas.string.StringFormatter ;
 
var pattern:String = "{3} and {2} and {1} or {0}" ;
 
var f:StringFormatter = new StringFormatter(pattern) ;
 
var result:String = f.format("a", "b", "c", "d") ;
trace ( result ) ; // output: d et c et b ou a
```

### 2 - Alignement property ###

```
import vegas.string.StringFormatter ;
 
var f:StringFormatter = new StringFormatter() ;
 
f.pattern = "Brad's dog has {0,6} fleas.";
var result:String = f.format(41) ;
trace ("result : " + result) ;
 
trace("----") ;
 
f.pattern = "Brad's dog has {0,6:#} fleas.";
var result:String = f.format(41) ;
trace ("result : " + result) ;
 
trace("----") ;
 
f.pattern = "Brad's dog has {0,-4:_} fleas." ;
var result:String = f.format(42) ;
trace ( result ) ;
 
trace("----") ;
 
f.pattern = "Brad's dog has {0,-4} fleas." ;
var result:String = f.format(12) ;
trace ( result ) ;
 
trace("----") ;
 
f.pattern = "{0,-10} | {1,-10} | {2,-10} | {3,-10}"
var result:String = f.format("vegas", "framework", "100%", "ekameleon.net") ;
trace ( result ) ;
var result:String = f.format("lunas", "framework", "0%", "ekameleon.net") ;
trace ( result ) ;
```