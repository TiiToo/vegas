/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
  
*/

try 
{
    dummy = system ;
}
catch(e) 
{
    // constants
    
    SRC     = "./" ;
    SUFFIX  = ".js" ;
    
    // packages
    
    getPackage("system") ;
    
    getPackage("system.data") ;
    getPackage("system.data.collections") ;
    getPackage("system.data.iterators") ;
    getPackage("system.data.maps") ;
    getPackage("system.errors") ;
    getPackage("system.formatters") ;
    getPackage("system.logging") ;
    getPackage("system.logging.targets") ;
    getPackage("system.numeric") ;
    getPackage("system.process") ;
    getPackage("system.signals") ;
    
    // system
    
    require( "system.Cloneable" ) ;
    require( "system.Comparable" ) ;
    require( "system.Comparator" ) ;
    require( "system.Enum" ) ;
    require( "system.Equatable" ) ;
    require( "system.Serializable" ) ;
    require( "system.Serializer" ) ;
    require( "system.Sortable" ) ;
    
    // system.data
    
    require( "system.data.Boundable"       ) ;
    require( "system.data.Collection"      ) ;
    require( "system.data.Data"            ) ;
    require( "system.data.Identifiable"    ) ;
    require( "system.data.Iterable"        ) ;
    require( "system.data.Iterator"        ) ;
    require( "system.data.Map"             ) ;
    require( "system.data.OrderedIterator" ) ;
    require( "system.data.Queue"           ) ;
    require( "system.data.Set"             ) ;
    require( "system.data.Typeable"        ) ;
    require( "system.data.Validator"       ) ;
    require( "system.data.ValueObject"     ) ;
    
    // system.data.collections
    
    require( "system.data.collections.ArrayCollection"     ) ;
    require( "system.data.collections.CollectionFormatter" ) ;
    require( "system.data.collections.TypedCollection"     ) ;
    
    // system.data.iterators
    
    require( "system.data.iterators.ArrayIterator"      ) ;
    require( "system.data.iterators.MapIterator"        ) ;
    require( "system.data.iterators.PageByPageIterator" ) ;
    
    // system.data.maps
    
    require( "system.data.maps.ArrayMap"     ) ;
    require( "system.data.maps.MapEntry"     ) ;
    require( "system.data.maps.MapFormatter" ) ;
    
    // system.errors
    
    require( "system.errors.ConcurrencyError"    ) ;
    require( "system.errors.InvalidChannelError" ) ;
    require( "system.errors.InvalidFilterError"  ) ;
    require( "system.errors.NonUniqueKeyError"   ) ;
    require( "system.errors.NoSuchElementError"  ) ;
    
    // system.data.formatters
    
    require( "system.formatters.Formattable" ) ;
    
    // system.logging
    
    require( "system.logging.Loggable"      ) ;
    require( "system.logging.Logger"        ) ;
    require( "system.logging.LoggerEntry"   ) ;
    require( "system.logging.LoggerFactory" ) ;
    require( "system.logging.LoggerLevel"   ) ;
    require( "system.logging.LoggerStrings" ) ;
    require( "system.logging.LoggerTarget"  ) ;
    
    // system.logging.targets
    
    require( "system.logging.targets.LineFormattedTarget" ) ;
    require( "system.logging.targets.TraceTarget"         ) ;
    
    // system.numeric
    
    require( "system.numeric.Mathematics" ) ;
    require( "system.numeric.PRNG"        ) ;
    require( "system.numeric.Range"       ) ;
    require( "system.numeric.RomanNumber" ) ;
    
    // system.process
    
    require( "system.process.Action"    ) ;
    require( "system.process.Batch"     ) ;
    require( "system.process.Lockable"  ) ;
    require( "system.process.Priority"  ) ;
    require( "system.process.Resetable" ) ;
    require( "system.process.Resumable" ) ;
    require( "system.process.Runnable"  ) ;
    require( "system.process.Startable" ) ;
    require( "system.process.Stoppable" ) ;
    require( "system.process.Task"      ) ;
    require( "system.process.TaskPhase" ) ;
    
    // system.signals
    
    require( "system.signals.Receiver"       ) ;
    require( "system.signals.Signal"         ) ;
    require( "system.signals.SignalEntry"    ) ;
    require( "system.signals.Signaler"       ) ;
    require( "system.signals.SignalStrings"  ) ;
}