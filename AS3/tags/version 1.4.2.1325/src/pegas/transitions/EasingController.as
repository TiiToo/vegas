/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.transitions 
{
    import system.data.Map;
    import system.data.maps.HashMap;

    /**
     * The EasingController register easing methods. 
     * This controller can be use with an external configuration or a dynamic easing engine.
     * This controller centralize all easing method in the application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import pegas.transitions.easing.* ;
     * import pegas.transitions.EasingController ;
     * import pegas.transitions.Tween ;
     * 
     * var controller:EasingController = new EasingController() ;
     * 
     * controller.add( "elastic_ease_out" , Elastic.easeOut ) ;
     * controller.add( "elastic_ease_in"  , Elastic.easeIn ) ;
     * 
     * // in the code
     * 
     * var easing:Function = controller.getEasing( "elastic_ease_out" ) ;
     * 
     * var tw:Tween = new Tween( mc, "_x" , easing, mc._x, 500, 24 , false, true) ; // mc a display on the root.
     * </pre>
     */
    public class EasingController 
    {

        /**
         * Creates a new EasingController instance.
         * <p><b>Usage :</b> 
         * <pre class="prettyprint">
         * var ec:EasingController = new EasingController() ;
         * </pre>
         */    
        public function EasingController()
        {
            _map = new HashMap() ;
        }
        
        /**
         * Adds a new entry into the EasingController.
         * @param id the <code class="prettyprint">id</code> of the easing method mapped in the EasingController.
         * @param easing The function to register in the EasingController.
         */
        public function add( id:String, easing:Function ):void 
        {
            _map.put( id, easing ) ;
        }
        
        /**
         * Removes all elements in this controller.
         */
        public function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">id</code> passed in argument is registered in the EasingController.
         * @param id the <code class="prettyprint">id</code> of the easing method mapped in the EasingController.
         * @return <code class="prettyprint">true</code> if the <code class="prettyprint">id</code> passed in argument is registered in the EasingController.
         */
        public function contains( id:String  ):Boolean 
        {
            return _map.containsKey( id ) ;
        }
        
        /**
         * Returns a easing method register in the EasingController with the specified <code class="prettyprint">id</code> passed in argument.
         * If the id isn't find in the controller, this method return a Regular.easeOut function.
         * @param  id the <code class="prettyprint">id</code> of the easing method mapped in the EasingController.
         * @param defaultEasing A default easing method invoked if the specified id isn't register in the controller.
         * @return the easing method mapped in the EasingController.  
         */
        public function getEasing( id:String , defaultEasing:Function=null ):Function
        {
            return contains(id) ? _map.get( id ) : (defaultEasing || null) ;
        }
        
        /**
         * Remove an entry into the EasingController.
         * @param id the name of the easing method mapped in the EasingController.
         */
        public function remove( id:String ):void 
        {
            _map.remove( id ) ;
        }
        
        /**
         * Returns the number of elements in the EasingController.
         * @return the number of elements in the EasingController.
         */
        public function size():Number
        {
            return _map.size() ;
        }
        
        /**
         * @private
         */
        private var _map:Map ;
        
    }
    
}
