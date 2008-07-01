/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Andromeda Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.evaluators 
{
    import andromeda.ioc.factory.IObjectFactory;
    
    import system.evaluators.IEvaluator;
    
    import vegas.core.CoreObject;    

    /**
     * Evaluates a reference string expression and return the property value who corresponding in the target object specified in this evaluator.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
	 * 
     * </pre>
     * @author eKameleon
     */
    public class ReferenceEvaluator extends CoreObject implements IEvaluator 
    {
        
        /**
         * Creates a new ReferenceEvaluator instance.
         * @param factory The IObjectFactory use in the evaluator.
         */
        public function ReferenceEvaluator( factory:IObjectFactory = null  )
        {
            this.factory = factory ;
        }
        
        /**
         * The IObjectFactory use in the evaluator.
         */
        public function get factory():*
        {
        	return _factory ;
        }
        
        /**
         * @private
         */
        public function set factory( factory:* ):void
        {
        	_factory = factory ;
        }        
        
        /**
         * The separator of the expression evaluator.
         */
        public var separator:String = "." ;
        
        /**
         * The reference pattern who represents the current factory.
         */
        public var thisPattern:String = "#this" ;
        
        /**
         * The undefineable value returns in the eval method if the expression can't be evaluate.
         */
        public var undefineable:* = null ;
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if ( o is String && factory != null )
            {
            	var exp:String = o as String ;
            	
            	if ( exp.length > 0 )
            	{
            		if ( exp == thisPattern )
            		{
            			return factory ;
            		}
            		else
            		{
                        var members:Array = exp.split( separator ) ;
                        if ( members.length > 0 )
                        {
                            var ref:String = members.shift() ;
            			    var value:*    = factory.getObject( ref ) ;
                            if ( value != null && members.length > 0 )
                            {
            				    _propEvaluator.target = value ;
            				    value = _propEvaluator.eval( members.join(".") ) ;
            				    _propEvaluator.target = null ;
                            }
            			    return value ;
                        }
            		}
                }
                
            }        	
            return undefineable ;
        }
        
        /**
         * @private
         */
        private var _factory:IObjectFactory ;
        
        /**
         * @private
         */
        private var _propEvaluator:PropertyEvaluator = new PropertyEvaluator() ;
        
    }
}
