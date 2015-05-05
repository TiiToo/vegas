# The HTMLStringFormatter class #

  * [Returns tutorial index page](TutorialsVEGAS.md)
    * [Returns Strings in VEGAS](VegasTutorialsString.md)

## Description ##

The **HTMLStringFormatter** class is used to format strings with html tags. This static tool class is inspired by the non-standard [HTML wrapper methods](http://developer.mozilla.org/en/docs/Core_JavaScript_1.5_Reference:Global_Objects:String#HTML_wrapper_methods) in the native Javascript 1.5 String methods.

Each of the following methods returns a copy of the string wrapped inside an HTML tag. For example :

```
import vegas.string.HTMLStringFormatter ;

var str:String = "test" ;
trace( HTMLStringFormatter.bold(str) ; // "<b>test</b>"
```

These methods are of limited use, as they provide only a subset of the available HTML tags and attributes. Don't forget the html limitation in the FlashPlayer. Some tags in this static tool class are only use in a real HTML page.

## Examples ##

### anchor (hypertext target) ###

Creates an HTML **anchor** that is used as a **hypertext target**.

```
import vegas.string.HTMLStringFormatter ;

var s:String = HTMLStringFormatter.anchor("contents_anchor", "ekameleon link") ;
trace("anchor : " + s) ; // anchor : <a name="contents_anchor">ekameleon link</a>link</a>
```

### big ###

Causes a string to be displayed in a big font as if it were in a **big tag**.

```
import vegas.string.HTMLStringFormatter ;
var s:String = HTMLStringFormatter.big("hello world") ;
trace("big : " + s) ; // big : <big>hello world</big>
```

### blink ###

Causes a string to blink as if it were in a **blink tag**.

```
import vegas.string.HTMLStringFormatter ;
var s:String = HTMLStringFormatter.blink("hello world") ;
trace("blink : " + s) ; // blink : <blink>hello world</blink>
```

### bold ###

Causes a string to be displayed as bold as if it were in a **b tag**.

```
import vegas.string.HTMLStringFormatter ;
var s:String = HTMLStringFormatter.bold("hello world") ;
trace("bold : " + s) ; // bold : <b>hello world</b>
```

### fixed ###

Causes a string to be displayed in fixed-pitch font as if it were in a **TT tag**.

```
import vegas.string.HTMLStringFormatter ;
var s:String = HTMLStringFormatter.fixed("hello world") ;
trace("fixed : " + s) ; // fixed : <tt>hello world</tt>
```

### fontColor ###

Causes a string to be displayed in the specified color as if it were in a <font color='color'> tag<b>.</b>

<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.fontColor("hello world" , "#FF0000" ) ;<br>
trace("fontColor : " + s) ; // fontColor : &lt;font color='#FF0000'&gt;hello world&lt;/font&gt;<br>
</code></pre>

<h3>fontSize</h3>

Causes a string to be displayed in the specified font size as if it were in a <font size='size'> tag<b>.</b>

<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.fontSize("hello world" , "#FF0000" ) ;<br>
trace("fontSize : " + s) ; // fontSize : &lt;font size='12'&gt;hello world&lt;/font&gt;<br>
</code></pre>

<h3>italics</h3>

Causes a string to be italic, as if it were in an <b>I tag</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.italics("hello world") ;<br>
trace("italics : " + s) ; // italics : &lt;i&gt;hello world&lt;/i&gt;<br>
</code></pre>

<h3>link</h3>

Creates an <b>HTML hypertext link</b> that requests another <b>URL</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.link("hello world", "http://ekameleon.net/blog", "_blank") ;<br>
trace("link : " + s) ; // link : &lt;a href="http://google.fr" target="_blank"&gt;hello world&lt;/a&gt;<br>
</code></pre>

<h3>paragraph</h3>

Causes a string to be paragraph, as if it were in an <b>p tag</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
<br>
var s:String = HTMLStringFormatter.paragraph("hello world") ;<br>
trace("paragraph : " + s) ; // paragraph : &lt;p&gt;hello world&lt;/p&gt;<br>
<br>
var s:String = HTMLStringFormatter.paragraph("hello world", "myStyle") ;<br>
trace("paragraph : " + s) ; // paragraph : &lt;p class="myStyle"&gt;hello world&lt;/p&gt;<br>
</code></pre>

<h3>small</h3>

Causes a string to be displayed in a small font, as if it were in a <b>small tag</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.small("hello world") ;<br>
trace("small : " + s) ; // small : &lt;small&gt;hello world&lt;/small&gt;<br>
</code></pre>

<h3>span</h3>

Causes a string to be span, as if it were in an <b>span tag</b>.<br>
<br>
<pre><code><br>
import vegas.string.HTMLStringFormatter ;<br>
<br>
var s:String = HTMLStringFormatter.span("hello world") ;<br>
trace("span : " + s) ; // span : &lt;span&gt;hello world&lt;/span&gt;<br>
<br>
var s:String = HTMLStringFormatter.span("hello world", "myStyle") ;<br>
trace("span : " + s) ; // span : &lt;span class="myStyle"&gt;hello world&lt;/span&gt;<br>
<br>
</code></pre>

<h3>strike</h3>

Causes a string to be displayed in a strike font, as if it were in a <b>strike tag</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.strike("hello world") ;<br>
trace("strike : " + s) ; // small : &lt;strike&gt;hello world&lt;/strike&gt;<br>
</code></pre>

<h3>sub</h3>

Causes a string to be displayed in a sub font, as if it were in a <b>sub tag</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.sub("hello world") ;<br>
trace("sub : " + s) ; // sub : &lt;sub&gt;hello world&lt;/sub&gt;<br>
</code></pre>

<h3>sup</h3>

Causes a string to be displayed in a sup font, as if it were in a <b>sup tag</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.sup("hello world") ;<br>
trace("sup : " + s) ; // sup : &lt;sup&gt;hello world&lt;/sup&gt;<br>
</code></pre>

<h3>underline</h3>

Causes a string to be displayed in a underline font, as if it were in a <b>u tag</b>.<br>
<br>
<pre><code>import vegas.string.HTMLStringFormatter ;<br>
var s:String = HTMLStringFormatter.underline("hello world") ;<br>
trace("underline : " + s) ; // underline : &lt;u&gt;hello world&lt;/u&gt;<br>
</code></pre>