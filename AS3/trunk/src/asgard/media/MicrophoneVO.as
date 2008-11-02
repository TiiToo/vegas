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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.media 
{
    import andromeda.vo.SimpleValueObject;
    
    import system.Reflection;
    import system.eden;
    
    import flash.media.Microphone;
    import flash.net.registerClassAlias;    

    /**
     * This value object contains all values to set a Microphone object.
     * @author eKameleon
     */
    public class MicrophoneVO extends SimpleValueObject 
    {
	
		/**
		 * Creates a new MicrophoneVO instance.
		 * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored.
		 */
        public function MicrophoneVO( init:Object=null )
		{
            super( init );
        }
        
        /**
         * Routes audio captured by a microphone to the local speakers.
         */
        public var loopBack:Boolean = true ;
           
        /**
         * The rate at which the microphone captures sound, in kHz.
         */
        public var rate:Number = 11 ;
        
		/**
		 * The amount of sound required to activate the microphone and dispatch the activity event.
		 */
    	public var silenceLevel:Number ;
    	
    	/**
    	 * The number of milliseconds between the time the microphone stops detecting sound and the time the activity event is dispatched.
    	 */
    	public var silenceTimeout:Number ;
     	
        /**
         * Set to true if echo suppression is enabled; false otherwise.
         */
        public var useEchoSuppression:Boolean ;     	
     	
     	/**
     	 * Apply this value object in the specified Microphone reference.
     	 */
     	public function apply( micro:Microphone ):void
     	{
            if ( micro != null )
            {     		
                micro.setLoopBack( loopBack ) ;
			    micro.setUseEchoSuppression( useEchoSuppression ) ;
			    micro.setSilenceLevel( silenceLevel, silenceTimeout ) ;
            }     		
     	}
     	
    	/**
	     * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
	     */
    	public static function register( aliasName:String = "MicrophoneVO" ):void
    	{
	        registerClassAlias( aliasName , MicrophoneVO ) ;
	    }
	    
        /**
         * Returns the <code class="prettyprint">Object</code> representation of this object.
         * @return the <code class="prettyprint">Object</code> representation of this object.
         */
        public function toObject():Object
        {
            var o:Object =
            {
                rate               : rate  ,
                silenceLevel       : silenceLevel ,
                timeout            : silenceTimeout ,
                useEchoSuppression : useEchoSuppression
            };
            return o ;
        }	    
	    
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            str += eden.serialize(toObject()) ;
            str += "]" ;
            return str ;
        } 
	    
    }
}
