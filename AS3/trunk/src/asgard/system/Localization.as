/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <vegas@ekameleon.net>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.system 
{
	import asgard.events.LocalizationEvent;
	
	import system.Reflection;
	
	import vegas.core.Identifiable;
	import vegas.data.map.HashMap;
	import vegas.events.AbstractCoreEventDispatcher;    

	/**
     * The Localization class allows to manage via textual files with 'JSON' or 'eden' format to charge the textual contents 
     * of an application according to the parameters of languages chosen by the users.
     * <p>It is possible to define several singletons of the Localization class to manage several elements in the application, but for this it's necessary to use the static property getInstance(sName). 
     * Thus all the authorities become of Singletons reusable a little everywhere in the application rather quickly.</p> 
     * @author eKameleon
     * @see Lang
     * @see Locale
     */
    public class Localization extends AbstractCoreEventDispatcher implements Identifiable
    {

        /**
         * Creates a new Localization instance.
         * @param sName the name of the object.
         */
        public function Localization( id:* , bGlobal:Boolean = false, sChannel:String = null )
        {
            super(bGlobal, sChannel) ;
            _id     = id ;
            _map    = new HashMap() ;
            _loader = new EdenLocalizationLoader(this) ;
        }
        
        /**
         * The name of the event when the localization is changed.
         */
        public static var CHANGE:String = LocalizationEvent.CHANGE  ;

        /**
         * The default singleton name of the Localization singletons.
         */
        public static var DEFAULT_ID:String = "" ;

        /**
         * (read-write) Indicates the current {@code Lang} object selected in the current localization.
         */
        public function get current():Lang 
        {
            return _current ;
        }
            
        /**
         * @private
         */
        public function set current( lang:Lang ):void
        {
            if ( Lang.validate(lang) ) 
            {
                _current = lang ;
                if ( contains(lang) ) 
                {
                    notifyChange() ;
                }
                else 
                {
                    loader.loadLang( current ) ;
                }
            }
        }    

        /**
         * (read-write) Returns the id of this object.
         * @return the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
    
        /**
         * @private
         */
        public function set id( id:* ):void
        {
            _id = id ;
        }
        
        /**
         * Returns the internal ILocalizationLoader reference of the Localization singleton.
         * @return the internal ILocalizationLoader reference of the Localization singleton.
         */
        public function get loader():ILocalizationLoader
        {
            return _loader ;    
        }
        
        /**
         * @private
         */
        public function set loader( loader:ILocalizationLoader ):void
        {
            _loader = loader || new EdenLocalizationLoader() ; // default eden parser
            _loader.localization = this ;    
        }
        
        /**
         * Removes all singletons in the internal map of this object..
         */
        public function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns {@code true} if this Localization contains the specified Lang.
          * @return {@code true} if this Localization contains the specified Lang.
         */
        public function contains( lang:* ):Boolean 
        {     
            if ( Lang.validate( lang ) )
            {
                return _map.containsKey( _getID( lang ) ) ;
            }
            else
            {
                return false ;    
            }
        }
    
        /**
         * Returns the current {@code Locale} object defines with the specified {@code Lang} object in argument.
         * @return the current {@code Locale} object defines with the specified {@code Lang} object in argument.
         */
        public function get( lang:* ):Locale 
        {
            if ( Lang.validate( lang ) )
            {
                return _map.get( _getID( lang ) ) as Locale ;
            }
            else
            {
                return null ;
            }
        }
        
        /**
         * Returns the event name use in the notifyChange method.
         * @return the event name use in the notifyChange method.
         */
        public function getEventTypeCHANGE():String
        {
            return _sTypeCHANGE ;
        }
        
        /**
         * Returns a {@code Localization} singleton reference with the specified name passed-in argument.
         * @return a {@code Localization} singleton reference with the specified name passed-in argument.
         */
        public static function getInstance( id:String=null ):Localization 
        {
            id = id || Localization.DEFAULT_ID  ;
            if (!__mInstances.containsKey(id)) 
            {
                __mInstances.put(id, new Localization(id)) ;
            }
            return __mInstances.get(id) as Localization  ;
        }    
        
        /**
          * Returns the locale object with all this properties.
          * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object.  
          * @return the locale object with all this properties.
          */
        public function getLocale( id:String=null ):* 
        {
            if ( id != null ) 
            {
                return this.get( _current )[ id ] || null ;
            }
            else 
            {
                return this.get( _current ) || null ;
            }
        }
        
        /**
         * Apply the current localization over the specified object.
         * @param o The object to fill with the current localization in the application.
         * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object.
         * @param callback (optional) The optional method to launch after the initialization over the specified object. 
         */
        public function init( o:Object , sID:String=null , callback:Function=null ):void
        {
            var init:* = getLocale( sID ) ;
            for (var prop:String in init)
            {
                o[prop] = init[prop] ;    
            }
            if ( callback != null )
            {
                callback.call(o) ;    
            }
        } 
        
        /**
         * Returns {@code true} if the Localization model is empty.
         * @return {@code true} if the Localization model is empty.
         */
        public function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }

        /**
         * Notify when the Localization change.
         */
        public function notifyChange():void 
        {
            dispatchEvent( new LocalizationEvent( _sTypeCHANGE , this ) ) ;
        }
        
        /**
         * Puts the specified Locale object with the passed-in Lang reference.
         */
        public function put( lang:* , oL:Locale ):* 
        {
            if ( Lang.validate( lang ) )
            {
                return _map.put( _getID( lang ) , oL ) ;
            }
            else
            {
                return null ;    
            }
        }

        /**
         * Releases the specified {@code Localization} singleton with the specified name in argument.
         * @return the reference of the removed Localization object.
         */
        public static function release( id:String ):Localization 
        {
            if (id == null) 
            {
                id = Localization.DEFAULT_ID ;
            }
            return Localization.__mInstances.remove(id) ;
        }

        /**
         * Removes the specified Lang in the Localization model.
         * @param lang a valid Lang object. This argument is valid if the {@link Lang.validate} method return {@code true}.
         * @return The removed Locale object or null.
         */
        public function remove( lang:* ):* 
        {
            if ( Lang.validate(lang) ) 
            {
                return _map.remove( _getID( lang ) ) ;
            }
            else
            {
                return null ;    
            }
        }
        
        /**
         * Returns the event type use in the notifyChange ethod.
         * @return the event type use in the notifyChange method.
         */
        public function setEventTypeCHANGE( type:String ):void
        {
           _sTypeCHANGE = type || CHANGE ;
        }
        
        /**
         * Returns the number of Lang elements in the Localization singleton.
         * @return the number of Lang elements in the Localization singleton.
         */
        public function size():uint 
        {
            return _map.size() ;
        }
        
        /**
          * Returns the {@code String} representation of this object.
          * @return the {@code String} representation of this object.
          */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " " + this.id ;    
            } 
            str += "]" ;
            return str ;
        }    

        /**
         * @private
         */
        private var _current:Lang = null ;
        
        /**
         * @private
         */
        private var _id:* ;
        
        /**
         * @private
         */
        private var _loader:ILocalizationLoader ;        

        /**
         * @private
         */
        private var _map:HashMap = null ;
        
        /**
         * @private
         */
        private static var __mInstances:HashMap = new HashMap() ;
        
        /**
         * @private
         */
        private var _sTypeCHANGE:String = LocalizationEvent.CHANGE ;
        
        /**
         * Returns the id of the specified argument.
         * @return the id of the specified argument.
         */
        private function _getID( lang:* ):String
        {
            var id:String ;
            if ( lang is Lang )
            {
                id = lang.value ;
            }
            else if ( lang is String )
            {
                id = lang as String ;    
            }
            else
            {
                id = null ;    
            }
            return id ;
        }
    }
}
