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
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

try 
{

	var dummy = vegas ;

}
catch(e) 
{

	// Burrrn
	
	load("./library/buRRRn.js") ;

	
	// VEGAS

	// Namespace Method
	
	_global.includePath   = "./library/" ;
	_global.includeSuffix = ".js" ;
	
	// Namespace Methods
	
	_global.getNamespace = function ( includePath /*String*/ ) 
	{
		var a = includePath.split('.');
		var scope = global ;
		var l = a.length ;
		for (var i = 0 ; i < l ; i++) 
		{
			var name = a[i];
			if ( ! scope.hasOwnProperty(name) ) 
			{
				scope[name] = {} ;
			}
			scope = scope[name] ;
		}
		return scope ;
	}
	
	// Requires Methods
		
	_global.require = function ( uri /*String*/ ) 
	{
		try
		{
			if ( eval(uri) != undefined ) 
			{
				return false ;
			}
		}
		catch(e)
		{
			trace( "require(" + uri + ") failed : " + e.toString() ) ;
			return false ;
		}
	
		uri = uri.split( "." ).join( "/" ) ;
		
		return load( ( includePath || "" ) + uri + ( includeSuffix || "" ) ) ;
	}
	
	_global.requirePackage = function ( uri /*String*/ ) 
	{
		return load( includePath + uri + includeSuffix ) ;
	}
	
	_global.trace = function ( o )
	{
		print( o + "\n" ) ;
	}
	
	_global.includePath   = "./library/" ;	
		
	_global.getNamespace = function ( path /*String*/ ) 
	{
		var a = path.split('.');
	    var scope = _global ;
		var l = a.length ;
		for (var i = 0 ; i < l ; i++) 
		{
			var name = a[i];
			if ( ! scope.hasOwnProperty(name) ) 
			{
				scope[name] = {} ;
			}
			scope = scope[name] ;
		}
		return scope ;
	}
	
		
	// -----o Defined NameSpaces.
		
	getNamespace("vegas") ;
	getNamespace("vegas.core") ;
	getNamespace("vegas.core.types") ;
	getNamespace("vegas.data") ;
	getNamespace("vegas.data.array") ;
	getNamespace("vegas.data.collections") ;
	getNamespace("vegas.data.iterator") ;
	getNamespace("vegas.data.list") ;
	getNamespace("vegas.data.map") ;
	getNamespace("vegas.data.queue") ;
	getNamespace("vegas.data.set") ;
	getNamespace("vegas.data.stack") ;
	getNamespace("vegas.errors") ;
	getNamespace("vegas.events") ;
	getNamespace("vegas.logging") ;
	getNamespace("vegas.logging.errors") ;
	getNamespace("vegas.logging.targets") ;
	getNamespace("vegas.string") ;
	getNamespace("vegas.string.errors") ;
	getNamespace("vegas.util") ;
	getNamespace("vegas.util.comparators") ;
	getNamespace("vegas.util.factory") ;
	getNamespace("vegas.util.mvc") ;
	
	// vegas.core
	
	require("vegas.core._global") ;
	require("vegas.core.Array") ;
	require("vegas.core.Function") ;
	require("vegas.core.Object") ;
	require("vegas.core.SharedObject") ;
	require("vegas.core.String") ;
	require("vegas.core.CoreObject") ;
	require("vegas.core.ICloneable") ;
	require("vegas.core.IComparable") ;
	require("vegas.core.IComparator") ;
	require("vegas.core.ICopyable") ;
	require("vegas.core.Identifiable") ;
	require("vegas.core.IEquality") ;
	require("vegas.core.IFactory") ;
	require("vegas.core.IFormat") ;
	require("vegas.core.IFormattable") ;
	require("vegas.core.IHashable") ;
	require("vegas.core.IRunnable") ;
	require("vegas.core.ISerializable") ;
	require("vegas.core.ITypeable") ;
	require("vegas.core.IValidator") ;
			
	// vegas.core.types
		
	require("vegas.core.types.Char") ; 
	require("vegas.core.types.Int") ;
	
	// vegas.data
		
	require("vegas.data.Bag") ;
	require("vegas.data.Collection") ;
	require("vegas.data.List") ;
	require("vegas.data.Map") ;
	require("vegas.data.MultiMap") ;
	require("vegas.data.Set") ;
			
	// vegas.data.array
	
	require("vegas.data.array.TypedArray") ;
	require("vegas.data.array.ArrayFilter") ;

	// vegas.data.collections
	
	require("vegas.data.collections.AbstractCollection") ;
	require("vegas.data.collections.CollectionFormat") ;
	require("vegas.data.collections.SimpleCollection") ;
	require("vegas.data.collections.TypedCollection") ;

	// vegas.data.iterator
	
	require("vegas.data.iterator.ArrayIterator") ;
	require("vegas.data.iterator.ArrayFieldIterator") ;
	require("vegas.data.iterator.Iterable") ;
	require("vegas.data.iterator.Iterable") ;
	require("vegas.data.iterator.Iterator") ;
	require("vegas.data.iterator.LinkedListIterator") ;
	require("vegas.data.iterator.ListIterator") ;
	require("vegas.data.iterator.ObjectIterator") ;
	require("vegas.data.iterator.OrderedIterator") ;
	require("vegas.data.iterator.PageByPageIterator") ;
	require("vegas.data.iterator.ProtectedIterator") ;
	require("vegas.data.iterator.StringIterator") ;
	
	// vegas.data.list
	
	require("vegas.data.list.AbstractList") ;
	require("vegas.data.list.ArrayList") ;
	require("vegas.data.list.LinkedList") ;
	require("vegas.data.list.LinkedListEntry") ;
	require("vegas.data.list.SortedArrayList") ;
	
	// vegas.data.map
	
	require("vegas.data.map.ArrayMap") ;
	require("vegas.data.map.HashMap") ;
	require("vegas.data.map.MapIterator") ;
	require("vegas.data.map.MapFormat") ;
	require("vegas.data.map.MultiHashMap") ;
	require("vegas.data.map.MultiMapFormat") ;
	require("vegas.data.map.SortedArrayMap") ;
	require("vegas.data.map.TypedMap") ;
	
	// vegas.data.queue
	
	require("vegas.data.queue.CircularQueue") ;
	require("vegas.data.queue.LinearQueue") ;
	require("vegas.data.queue.PriorityQueue") ;
	require("vegas.data.queue.QueueFormat") ;
	require("vegas.data.queue.TypedQueue") ;
	
	// vegas.data.set
	
	require("vegas.data.set.AbstractSet") ;
	require("vegas.data.set.HashSet") ;
	require("vegas.data.set.MultiHashSet") ;
	require("vegas.data.set.TypedSet") ;
	
	// vegas.data.stack

	require("vegas.data.stack.SimpleStack") ;
	require("vegas.data.stack.TypedStack") ;
	
	// vegas.errors
	
	require("vegas.errors.AbstractError") ;
	require("vegas.errors.ArgumentOutOfBoundsError") ;
	require("vegas.errors.ArgumentsError") ;
	require("vegas.errors.ClassCastError") ;
	require("vegas.errors.ConcurrentModificationError") ;
	require("vegas.errors.ErrorElement") ;
	require("vegas.errors.ErrorFormat") ;
	require("vegas.errors.FatalError") ;
	require("vegas.errors.IllegalArgumentError") ;
	require("vegas.errors.IllegalStateError") ;
	require("vegas.errors.IndexOutOfBoundsError") ;
	require("vegas.errors.NoSuchElementError") ;
	require("vegas.errors.NullPointerError") ;
	require("vegas.errors.NumberFormatError") ;
	require("vegas.errors.RangeError") ;
	require("vegas.errors.RuntimeError") ;
	require("vegas.errors.TypeMismatchError") ;
	require("vegas.errors.UnsupportedOperation") ; 
	require("vegas.errors.ValueOutOfBoundsError") ;
	require("vegas.errors.Warning") ;
	
	// vegas.events
	
	require("vegas.events.AbstractCoreEventDispatcher") ;
	require("vegas.events.ArrayEvent") ;
	require("vegas.events.BasicEvent") ;
	require("vegas.events.BooleanEvent") ;
	require("vegas.events.Delegate") ;
	require("vegas.events.DynamicEvent") ;
	require("vegas.events.EDispatcher") ;
	require("vegas.events.Event") ;
	require("vegas.events.EventDispatcher") ;
	require("vegas.events.EventListener") ;
	require("vegas.events.EventListenerBatch") ;
	require("vegas.events.EventListenerCollection") ;
	require("vegas.events.EventListenerComparator") ;
	require("vegas.events.EventListenerContainer") ;
	require("vegas.events.EventPhase") ;
	require("vegas.events.EventQueue") ;
	require("vegas.events.EventTarget") ;
	require("vegas.events.EventType") ;
	require("vegas.events.FastDispatcher") ;
	require("vegas.events.FrontController") ;
	require("vegas.events.IDispatcher") ;
	require("vegas.events.IEventDispatcher") ;
	require("vegas.events.ModelChangedEvent") ;
	require("vegas.events.ModelChangedEventType") ;
	require("vegas.events.NumberEvent") ;
	require("vegas.events.StringEvent") ;
	require("vegas.events.TextEvent") ;
	require("vegas.events.TimerEvent") ;
	require("vegas.events.TimerEventType") ;
	require("vegas.events.ValidatorEvent") ;
	require("vegas.events.ValidatorEventType") ;
	
	// vegas.logging
	
	require("vegas.logging.AbstractTarget") ;
	require("vegas.logging.ILogger") ; 
	require("vegas.logging.ITarget") ;
	require("vegas.logging.LogEvent") ;
	require("vegas.logging.LogEventLevel") ;
	require("vegas.logging.LogLogger") ;
	require("vegas.logging.Log") ;
	require("vegas.logging.LogLogger") ;
	
	// vegas.logging.errors
	
	require("vegas.logging.errors.InvalidCategoryError") ;
	require("vegas.logging.errors.InvalidFilterError") ;
		
	// vegas.logging.targets

	require("vegas.logging.targets.LineFormattedTarget") ;
	require("vegas.logging.targets.TraceTarget") ;
	require("vegas.logging.targets.SOSTarget") ;
	require("vegas.logging.targets.SOSType") ;
	
	// vegas.string
	
	require("vegas.string.JSON") ;
	require("vegas.string.UnicodeChar") ;
	require("vegas.string.WildExp") ;
	
	// vegas.string.errors
	
	require("vegas.string.errors.JSONError") ;
	
	// vegas.util

	require("vegas.util.AbstractTypeable") ;
	require("vegas.util.ConstructorUtil") ;
	require("vegas.util.ITimer") ;
	require("vegas.util.MathsUtil") ;
	require("vegas.util.Mixin") ;
	require("vegas.util.ResolverProxy") ;
	require("vegas.util.TypeUtil") ;
	require("vegas.util.Timer") ;
	
	// vegas.util.comparators
	
	require("vegas.util.comparators.BooleanComparator") ;
	require("vegas.util.comparators.ComparableComparator") ;
	require("vegas.util.comparators.DateComparator") ;
	require("vegas.util.comparators.NullComparator") ;
	require("vegas.util.comparators.NumberComparator") ;
	require("vegas.util.comparators.ReverseComparator") ;
	require("vegas.util.comparators.StringComparator") ;
		
	// vegas.util.factory
	
	require("vegas.util.factory.EventFactory") ;
	require("vegas.util.factory.PropertyFactory") ;
	
	// vegas.util.mvc
		
	require("vegas.util.mvc.IController") ;
	require("vegas.util.mvc.IModel") ;
	require("vegas.util.mvc.IView") ;
	require("vegas.util.mvc.AbstractController") ;
	require("vegas.util.mvc.AbstractModel") ;
	require("vegas.util.mvc.AbstractView") ;
	
	// Extensions
	
	requirePackage( "calista"   )  ; // CalistA  v 1.0.0.0
	requirePackage( "andromeda" )  ; // AndromedAS  v 1.0.0.0
	requirePackage( "pegas"     )  ; // PegAS  v 1.0.0.0

	_global.includePath   = "./src/" ;	
	
}