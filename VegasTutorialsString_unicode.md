# The UnicodeChar class #

  * [Returns tutorial index page](TutorialsVEGAS.md)
    * [Returns Strings in VEGAS](VegasTutorialsString.md)

## Description ##

This tool class provides an ECMA 262 Unicode IFormat-Control Characters tools. This class is based over the [ECMAScript 262 specifications](http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf) (see the **chapter 7 : Lexical Conventions**).

## Use ##

### The White space chars array ###

```
import vegas.string.UnicodeChar ;

// The length of the UnicodeChar.WHITE_SPACE_CHARS array : 5

trace ("The length of the UnicodeChar.WHITE_SPACE_CHARS array : " + UnicodeChar.WHITE_SPACE_CHARS.length) ;
```

### The UnicodeChar constants ###

**The UnicodeChar special chars :**

| BACK\_SLASH | Back Slash utf8 representation |
|:------------|:-------------------------------|
| BACK\_SPACE | Back Space utf8 representation |
| SIMPLE\_QUOTE | Simple Quote utf8 representation |
| DOUBLE\_QUOTE | Double Quote utf8 representation |

**The UnicodeChar whitespaces :**

| TAB |  Tab utf8 representation |
|:----|:-------------------------|
| VT | Vertical Tab utf8 representation |
| FF | Form Feed utf8 representation |
| SP | Space utf8 representation |
| NBSP | No-break space utf8 representation |

**The UnicodeChar line terminators :**

| LF | Line Feed utf8 representation |
|:---|:------------------------------|
| CR | Carriage Return utf8 representation |
| LS | Line Separator utf8 representation |
| PS | Paragraph Separator utf8 representation |

**Example to use this constants :**

```
import vegas.string.UnicodeChar ;

// | UnicodeChar.TAB hello world : |	hello world
trace ("| UnicodeChar.TAB hello world : " +  "|" + UnicodeChar.TAB + "hello world" ) ;

```

### Test if a charactere is a whitespace ###

```
import vegas.string.UnicodeChar ;

// UnicodeChar.TAB isWhiteSpace : true
trace ("UnicodeChar.TAB isWhiteSpace : " + UnicodeChar.isWhiteSpace( UnicodeChar.TAB ) ) ;
```

### Converts a String unicode number representation in this character representation ###

```
// UnicodeChar.toChar("0040" ) : @
trace( 'UnicodeChar.toChar("0040" ) : ' + UnicodeChar.toChar( "0040" ) ) ;
trace( 'UnicodeChar.toCharString("0040" ) : ' + UnicodeChar.toCharString( "0040" ) ) ;
```

### Use a UnicodeChar instance and this proxy call process ###

You can use the method notation **instance.uXXXX** to return the unicode char representation of the specified utf8 code.

```
var u:UnicodeChar = new UnicodeChar() ;

// u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) : 小飼弾@
trace( 'u.u5c0f() + u.u98fc() + u.u5f3e() + u.0040()) : ' + u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) ;

field.text = 'u.u5c0f() + u.u98fc() + u.u5f3e() + u.0040()) : ' + u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ;
```