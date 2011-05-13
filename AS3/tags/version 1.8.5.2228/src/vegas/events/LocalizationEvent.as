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
  Portions created by the Initial Developer are Copyright (C) 2004-2011
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

package vegas.events
{
    import system.events.BasicEvent;
    
    import vegas.i18n.Lang;
    import vegas.i18n.Localization;
    
    import flash.events.Event;
    
    /**
     * The LocalizationEvent is used in the Localization singleton to notify a change.
     */
    public class LocalizationEvent extends BasicEvent
    {
        /**
         * Creates a new LocalizationEvent instance.
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function LocalizationEvent( type:String , target:Localization = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super( type, target, context, bubbles, cancelable, time );
        }
        
        /**
         * The name of the event when the localization is changed.
         * @eventType change
         */  
        public static var CHANGE:String = Event.CHANGE  ;
        
        /**
         * The default singleton name of the Localization singletons.
         */
        public static var DEFAULT_ID:String = "" ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new LocalizationEvent( type , target as Localization, context ) ;
        }
        
        /**
         * Indicates the current Lang value of the internal Localization.
         */
        public function get current():Lang
        {
            var localization:Localization = target as Localization ;
            return ( localization != null ) ? ( target as Localization ).current : null ;
        }
        
        /**
         * Returns the current <code class="prettyprint">Local</code> reference or the internal value of the Local property passed in argument with the string in argument.
         * @return the current <code class="prettyprint">Local</code> reference or the internal value of the Local property passed in argument with the string in argument.
         */
        public function getLocale( id:String=null ):*
        {
            var localization:Localization = target as Localization ;
            return ( localization != null ) ? localization.getLocale( id ) : null ;
        }
        
        /**
         * Apply the current localization over the specified object.
         * @param o The object to fill with the current localization in the application.
         * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object. 
         * @param callback (optional) The optional method to launch after the initialization over the specified object. 
         */
        public function init( o:Object , sID:String=null , callback:Function=null ):void
        {
            (target as Localization).init( o , sID , callback ) ;
        }
    }
}
