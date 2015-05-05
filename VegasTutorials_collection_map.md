# The vegas.data.Map interface and this implementations #

## Generality ##

The **Map** interface in **VEGAS** is based on the [Java Collection Framework](http://java.sun.com/j2se/1.4.2/docs/guide/collections/).

This interface defines an object that maps keys to values. A map cannot contain duplicate keys ; each key can map to at most one value.

The **vegas.data.Map** interface defines a group of basic methods :


### The test methods ###


| isEmpty | return **true** if the collection no contains entries. |
|:--------|:-------------------------------------------------------|
| containsKey | return **true** if the map contains a mapping for the specified key. |
| containsValue | return **true** if the map maps one or more keys to the specified value.  |


### The insert and change methods ###


| put(key, value) | Associates the specified value with the specified key in the map. |
|:----------------|:------------------------------------------------------------------|
| putAll(m:Map) | Copies all of the mappings from the specified map to the map. |


### The remove methods ###


| clear() | Removes all mappings from this map. |
|:--------|:------------------------------------|
| remove(key) | Removes the mapping for this key from this map if it is present. |


### The copy methods ###


| clone() | Returns a shallow copy of the Map. |
|:--------|:-----------------------------------|


### The getter and enumeration methods ###


| get(key) | Returns the value to which this map maps the specified key. |
|:---------|:------------------------------------------------------------|
| getKeys():Array | Returns an Array representation of all keys of the Map. |
| getValues():Array | Returns an Array representation of all values of the Map. |
| iterator():Iterator | Returns the iterator of this collection (This Iterator is an MapIterator reference). |
| keyIterator():Iterator | Returns the Iterator of all keys of the Map. |

### The information methods ###

| size():Number | Returns the number of key-value mappings in the Map. |
|:--------------|:-----------------------------------------------------|
| toString():String | Returns the custom string representation of the Map. |


VEGAS contains in the **vegas.data.map** and the **vegas.data.set** packages all implementations of the interface :

  * [vegas.data.map.HashMap](http://vegas.ekameleon.net/docs/vegas/data/map/HashMap.html)
  * [vegas.data.map.ArrayMap](http://vegas.ekameleon.net/docs/vegas/data/map/ArrayMap.html)
  * [vegas.data.map.SortedArrayMap](http://vegas.ekameleon.net/docs/vegas/data/map/SortedArrayMap.html)
  * [vegas.data.map.TypedMap](http://vegas.ekameleon.net/docs/vegas/data/map/TypedMap.html)
  * [vegas.data.map.MultiHashMap](http://vegas.ekameleon.net/docs/vegas/data/map/MultiHashMap.html)
  * [vegas.data.set.MultiHashSet](http://vegas.ekameleon.net/docs/vegas/data/set/MultiHashSet.html)

**Remarque :** In **AS2**, **SSAS** and **AS3** the Map interface it's the same but in AS3 with the new [flash.utils.Dictionnary](http://livedocs.adobe.com/flex/2/langref/flash/utils/Dictionary.html) native class i have change the implementation of the **HashMap** class. Finally the **HashMap** class in **AS2** and **SSAS** is the **ArrayMap** class in **AS3**, the **HashMap** AS3 class based on the **Dictionnary** class of **Adobe**.

## Description of all implementation of the Map interface ##

### The vegas.data.map.HashMap class ###

This class is an easy representation of the **Map** interface. The implementation of this class is based on the **JAVA** HashMap class.

In **AS3** like in **Java** the **HashMap** class does not guarantee no guarantees as to the order of the map. The AS3 implementation use the [flash.utils.Dictionnary](http://livedocs.adobe.com/flex/2/langref/flash/utils/Dictionary.html) class to map the key/value entries.

In **AS2** and **SSAS** the **HashMap** class is based on two Arrays. The first Array register all keys and the second register all values. The **AS2/SSAS HashMap** class is the same class like the **AS3 ArrayMap** class but with strict methods of the **Map** interface.

**Example :**
```
import vegas.data.Map ;
import vegas.data.map.HashMap;
import vegas.data.iterator.Iterator;
 
var map:Map = new HashMap() ;
 
trace("put key1 -> value0 : " + map.put("key1", "value0") ) ;
trace("put key1 -> value1 : " + map.put("key1", "value1") ) ;            
trace("put key2 -> value2 : " + map.put("key2", "value2") ) ;
              
trace("map : " + map) ;
trace("map toSource : " + map.toSource()) ;
 
trace("> iterator") ;
var it:Iterator = map.iterator() ;
while(it.hasNext()) 
{
      var v = it.next() ;
      var k = it.key() ;
      trace( "   " + k + " : " + v ) ;
}
              
trace("remove key1 : " + map.remove("key1")) ;
trace("size : " + map.size()) ;      
              
map.clear() ;  
              
trace("isEmpty : " + map.isEmpty()) ;
```

### The vegas.data.map.ArrayMap class ###

The **ArrayMap** class it's the same in **AS2**, **AS3** and **SSAS**. This class uses two Arrays to map the key/value entries.

This class contains all method of the **Map** interface and two news methods :

| setKeyAt( index:Number , key ) | This method change the value of a key in the map at the index position, this method don't change the value of the key. |
|:-------------------------------|:-----------------------------------------------------------------------------------------------------------------------|
| setValueAt( index:Number, value ) | This method change the value of a key at the index position specified in argument. |

In **AS2** and **SSAS** the **ArrayMap** class extends the **HashMap** class.

```
import vegas.data.map.ArrayMap ;

var map:ArrayMap = new ArrayMap() ;

map.put("key1", "value1") ;
map.put("key2", "value2") ;
map.put("key3", "value3") ;

trace(map) ; // {key1:value1,key2:value2,key3:value3}

map.setKeyAt(1, "myKey") ;

trace(map) ; // {key1:value1,myKey:value2,key3:value3}

map.setValueAt(2, "myValue") ;

trace(map) ; // {key1:value1,myKey:value2,key3:myValue}
```

### The vegas.data.map.SortedArrayMap class ###

This class extends the **ArrayMap** class and contains all methods of the **ArrayMap** but this class can sort the entries **key/value** of the map with the sorting methods of the **Array** class.

The **SortedArrayMap** instances can sort this keys or this values :

  * We can choose with the property **sortBy** if the sort target the keys or the values. We can use the constants **SortedArrayMap.KEY** or **SortedArrayMap.VALUE** to defines the sorting target.
  * The **sort()** method of the SortedArrayMap use an [IComparator](http://vegas.ekameleon.net/docs/vegas/core/IComparator.html) object to sort the map. See the package **vegas.util.comparators** to use the vegas **IComparators** or implements your custom **IComparator** objects.
  * We can use an **options** property to defines the sorting filter of the internal Arrays of the Map. This options use the **Array.DESCENDING**, **Array.NUMERIC** etc.. constants to defines the option to use during the sort process. You can use the constants of the **SortedArrayMap** class to creates your custom sort filter (see next examples)
  * The method **sortOn()** of the **SortedArrayMap** sort the keys or the values with the **Array.sortOn()** methods.

**NB :** In **SSAS** the **Array** class don't have the **sortOn()** method (SSAS = Javascript 1.5). I have implemented this method directly in the prototype of the Array class but this method isn't really the best solution for me. I hope see in the next FMS version the implementation of the full sortOn() method of the Array class in ActionScript.

**Example 1 : use the 'sort' method.**
```
import vegas.data.map.SortedArrayMap ;
import vegas.util.comparators.NumberComparator ;
import vegas.util.comparators.StringComparator ;
 
var map:SortedArrayMap = new SortedArrayMap( [0] , ["item0"] ) ;
 
map.put( 1 , "item8" ) ;
map.put( 3 , "item7" ) ;
map.put( 2 , "item6" ) ;
map.put( 5 , "item5" ) ;
map.put( 4 , "item4" ) ;
map.put( 7 , "item3" ) ;
map.put( 6 , "item2" ) ;
map.put( 8 , "item1" ) ;
 
trace("----- original Map") ;
 
trace( map ) ;
 
trace("----- sort by key with sort() method") ;
 
map.comparator = new NumberComparator() ;
 
map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
map.sort() ;
trace( map ) ;
 
map.options = SortedArrayMap.NUMERIC ;
map.sort() ;
trace( map ) ;
 
trace("----- sort by value with sort() method") ;
 
map.comparator = new StringComparator() ;
 
map.sortBy = SortedArrayMap.VALUE ;
 
map.options = SortedArrayMap.DESCENDING ;
map.sort() ;
trace( map ) ;
 
map.options = SortedArrayMap.NONE ;
map.sort() ;
trace( map ) ;
```

**Example 2 : use the 'sortOn' method**
```
import vegas.data.iterator.Iterator ;
import vegas.data.Map ;
import vegas.data.map.SortedArrayMap ;
 
var map:SortedArrayMap = new SortedArrayMap() ;
 
map.put( { id:5 } , { name:'name4' } ) ;
map.put( { id:1 } , { name:'name1' } ) ;
map.put( { id:3 } , { name:'name5' } ) ;
map.put( { id:2 } , { name:'name2' } ) ;
map.put( { id:4 } , { name:'name3' } ) ;
 
var debug:Function = function( map:Map ):void
{
 
    var vit:Iterator = map.iterator() ;
    var kit:Iterator = map.keyIterator() ;
	
    var str:String = "{" ;
	
    while( vit.hasNext() ) 
    {
        var value = vit.next() ;
        var key   = kit.next() ;
        str += key.id + ":" + value.name ;
        if (vit.hasNext())
        {
            str += "," ;
	}
    }
    str += "}" ;
    trace(str) ;
}
 
trace("----- original Map") ;
 
debug( map ) ; // {5:name4,1:name1,3:name5,2:name2,4:name3}
 
trace("----- sort by key with sort() method") ;
 
map.sortBy = SortedArrayMap.KEY ; // default
 
map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
map.sortOn("id") ;
debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
 
map.options = SortedArrayMap.NUMERIC  ;
map.sortOn("id") ;
debug( map ) ; // {1:name1,2:name2,3:name5,4:name3,5:name4}
 
trace("----- sort by value with sort() method") ;

map.sortBy = SortedArrayMap.VALUE ;

map.options = SortedArrayMap.DESCENDING ;
map.sortOn("name") ;
debug( map ) ; // {3:name5,5:name4,4:name3,2:name2,1:name1}
 
map.options = SortedArrayMap.NONE ;
map.sortOn("name") ;
debug( map ) ; // {1:name1,2:name2,4:name3,5:name4,3:name5}
```

### The vegas.data.map.TypedMap class ###

This class is a wrapped class who implement a new Map who test the type of the values of the **Map** during the put() or the putAll() call. This class extends the [AbstractTypeable](http://vegas.ekameleon.net/docs/vegas/util/AbstractTypeable.html) class and implement the [ITypeable](http://vegas.ekameleon.net/docs/vegas/core/ITypeable.html) interface.

```
import vegas.data.iterator.Iterator ;
import vegas.data.Map ;
import vegas.data.map.HashMap ;
import vegas.data.map.TypedMap ;

var map1:HashMap = new HashMap() ;
map1.put("key1", "value1") ;
map1.put("key2", "value2") ;
map1.put("key3", "value3") ;

var map2:HashMap = new HashMap() ;
map2.put("key4", "value1") ;
map2.put("key5", "value5") ;
map2.put("key6", "value6") ;
//map2.put("key6", true) ;

var tm:TypedMap = new TypedMap(String, map1) ;
tm.put("key1", "value0") ;
tm.putAll(map2) ;
trace ("typedMap : " + tm) ;

trace ("typedMap toSource : " + tm.toSource()) ;

try
{
    tm.put("key7", 2) ;
}
catch( e:Error )
{
    trace( e.toString() ) ;
    // [TypeMismatchError] {key1:value0,key2:value2,key3:value3,key4:value1,key5:value5,key6:value6} validate('value' : 2) is mismatch.
}
```

### The vegas.data.map.MultiHashMap class ###

The [MultiHashMap](http://vegas.ekameleon.net/docs/vegas/data/map/MultiHashMap.html) class is inspired by the implementation if the [Jakarta collections framework](http://commons.apache.org/collections/apidocs/org/apache/commons/collections/MultiHashMap.html). This class implements the [MultiMap](http://vegas.ekameleon.net/docs/vegas/data/MultiMap.html) interface.

A **MultiMap** is a Map with slightly different semantics. Putting a value into the map will add the value to a Collection at that key. Getting a value will return a **Collection**, holding all the values put to that key.

**Example :**
```
import vegas.data.Collection ;
import vegas.data.iterator.Iterator ;
import vegas.data.map.HashMap ;
import vegas.data.Map ;
import vegas.data.MultiMap ;
import vegas.data.map.MultiHashMap ;
 
var map1:HashMap = new HashMap() ;
map1.put("key1", "valueD1") ;
map1.put("key2", "valueD2") ;
trace ("> map1 : " + map1) ;
trace ("> map1 containsKey 'key1' : " + map1.containsKey("key1")) ;
 
trace ("--- use a map argument in constructor") ;

var map:MultiHashMap = new MultiHashMap(map1) ;
map.put("key1", "valueA1") ;
map.put("key1", "valueA2") ;
map.put("key1", "valueA3") ;
map.put("key2", "valueA2") ;
map.put("key2", "valueB1") ;
map.put("key2", "valueB2") ;
map.put("key3", "valueC1") ;
map.put("key3", "valueC2") ;

trace ("init map : " + map) ;
trace ("r--- toSource MultiMap") ;

trace("map toSource : " + map.toSource()) ;

trace ("r--- put values in MultiMap") ;

trace ("key1 >> " + map.get("key1")) ;

trace ("key2 >> " + map.get("key2")) ;
 
trace ("key3 >> " + map.get("key3")) ;

trace ("r--- toString MultiMap") ;

trace (map) ;

map.remove("key1", "valueA2") ;

trace ("r--- remove a value in key1 >> " + map.get("key1")) ;

trace ("r--- use iterator") ;

var it:Iterator = map.iterator() ;
while(it.hasNext()) 
{
    trace ("\t :: " + it.next()) ;
}

trace ("r--- use a key iterator : key1") ;
var it:Iterator = map.iterator("key1") ;
while(it.hasNext()) 
{
    trace ("\t :: " + it.next()) ;
}

trace ("r--- putCollection key2 in key1") ;
map.putCollection("key1", map.get("key2")) ;
trace ("key1 >> " + map.get("key1")) ;

trace ("r--- different size") ;
trace ("map size : " + map.size()) ;
trace ("map totalSize : " + map.totalSize()) ;

trace ("r--- clone MultiMap") ;
var clone:MultiMap = map.clone() ;
clone.remove("key1") ;

trace("clone : " + clone) ;
trace ("clone size : " + clone.totalSize()) ;
trace ("map size : " + map.totalSize()) ;

trace ("r--- valueIterator") ;
var it:Iterator = map.valueIterator() ;
while(it.hasNext()) 
{
     trace("\t> " + it.next()) ;
}
```

### The vegas.data.set.MultiHashSet class ###

This class exist in the **vegas.data.set** package but is a **Map** implementation.

The [MultiHashSet](http://vegas.ekameleon.net/docs/vegas/data/set/MultiHashSet.html) class is a original **VEGAS implementation. This class extends the**MultiHashMap**class but use a**Set**to register all values of a specified key in the Map and not a basic**Collection**.**

A **Set** is a **Collection** that contains no duplicate elements. We can't insert in a **MultiHashSet** two same values with a specified key. But we can use two same values with two different keys.

**Example :**
```
import vegas.data.Collection ;
import vegas.data.collections.SimpleCollection ;
import vegas.data.set.MultiHashSet ;
 
var s:MultiHashSet = new MultiHashSet() ;
 
trace("----- Test put()") ;
 
trace("insert key1:valueA1 : " + s.put("key1", "valueA1")) ;
trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) 
trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
trace("insert key1:valueA3 : " + s.put("key1", "valueA3")) ;
trace("insert key2:valueA2 : " + s.put("key2", "valueA2")) ;
trace("insert key2:valueB1 : " + s.put("key2", "valueB1")) ;
trace("insert key2:valueB2 : " + s.put("key2", "valueB2")) ;
 
trace("size : " + s.size()) ;
trace("totalSize : " + s.totalSize()) ;
 
trace("---- Test toArray") ;
 
var ar:Array = s.toArray() ;
trace("s.toArray : " + ar) ;
 
trace("----- Test contains") ;
 
trace("contains valueA1 : " + s.contains("valueA1") ) ;
trace("contains valueA1 in key1 : " + s.contains("key1", "valueA1") ) ;
trace("contains valueA1 in key2 : " + s.contains("key2", "valueA1") ) ;
 
trace("---- Test remove(key, value)") ;
 
trace("remove key1:valueA2 : " + s.remove("key1", "valueA2")) ;
trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
 
trace("---- Test remove(key)") ;
 
trace("remove key2 : " + s.remove("key2")) ;
trace("size : " + s.size()) ;
 
trace("---- Test putCollection(key, co:Collection)") ;
var co:Collection = new SimpleCollection(["valueA1", "valueA4", "valueA1"]) ;
s.putCollection("key1", co) ;
trace("s.toString : " + s) ;
```

NB: In **AS3** the name of the **vegas.data.set** package change, you must use the **vegas.data.sets** package name.

## Conclusion ##

The **Map** interface is really important in all the class implemented in **VEGAS** and this extensions (AndromedA, ASGard, ...).

I use the **HashMap** class for example in the **vegas.events.EventDispatcher** class, the **vegas.logging.Log** class, the **asgard.display.DisplayObjectCollector** class, the **asgard.net.StreamCollector** class, the **andromeda.model.map.MapModel** class, etc.

The **Design Pattern MVC** (model view controller) implementation in the **AndromedA** extension of **VEGAS** can't exist within the implementation of this interface.

