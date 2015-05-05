# vegas.util.MathsUtils #

The MathsUtil class is a static tool class with lots of static methods to manipulate the numbers.

## clamp method ##

```
import vegas.util.MathsUtil ;
 
var clamp:Number = MathsUtil.clamp(4) ;
trace ("clamp 4 - [] : " + clamp) ; // clamp 4 - [] : 4
 
var clamp:Number = MathsUtil.clamp(3, 1, 5) ;
trace ("clamp 3 - [1,5] " + clamp) ; // clamp 3 - [1,5] 3
 
var clamp:Number = MathsUtil.clamp(0, 1, 5) ;
trace ("clamp 0 - [1-5] " + clamp) ; // clamp 0 - [1-5] 1
 
var clamp:Number = MathsUtil.clamp(9, 2, 5) ;
trace ("clamp 9 - [1-5] " + clamp) ; // clamp 9 - [1-5] 5
```

## round method ##

```
import vegas.util.MathsUtil ;
 
var round:Number = MathsUtil.round(12.123456789) ;
trace ("round : " + round) ; // round : 12
 
var round:Number = MathsUtil.round(12.123456789, 1) ;
trace ("round : " + round) ; // round : 12.1
 
var round:Number = MathsUtil.round(12.123456789, 5) ;
trace ("round : " + round) ; // round : 12.12346
```

You can use the **round()** method, the **floor()** method and the **ceil()** method with the sames arguments.

## sign method ##

```
import vegas.util.MathsUtil ;
 
trace (MathsUtil.sign(4)) ; // 1
trace (MathsUtil.sign(0)) ; // 1
trace (MathsUtil.sign(-4)) ; // -1
 
try
{
    var r = MathsUtil.sign(NaN, 2) ;
}
catch( e:Error )
{
    trace(e.toString()) ; // [IllegalArgumentError] MathsUtil.sign, Argument 'n' must not be 'null' or 'undefined'
}
```

## getPercent method ##

```
import vegas.util.MathsUtil ;
 
trace( MathsUtil.getPercent( 15, 100 ) + "%" ) ; // 15%
trace( MathsUtil.getPercent( 100, 200 ) + "%" ) ; // 50%
trace( MathsUtil.getPercent( 4, 16 ) + "%" ) ; // 25%
```