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
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package observer.model
{
    import observer.events.PictureModelEvent;
    
    import system.data.Iterator;
    import system.data.Set;
    import system.data.sets.HashSet;
    import system.events.MessageBroadcaster;
    import system.process.Runnable;
    
    /**
     * The model to change the Picture with differents external files.
     */
    public class PictureModel extends MessageBroadcaster implements Runnable
    {
        /**
         * Creates a new PictureModel.
         */
        public function PictureModel()
        {
            _set = new HashSet() ;
        }
        
        /**
         * Inserts a new picture url in the model, if the url exist the url isn't inserted.
         * @return 'true' if the url is inserted else 'false' if the url allready exist in the model.
         */
        public function addUrl( url:String ):Boolean
        {
            var b:Boolean = _set.add( url ) ;
            notifyChanged( new PictureModelEvent( PictureModelEvent.ADD , url ) );
            return b ;
        }
        
        /**
         * Clears the model.
         */
        public function clear():void
        {
            _set.clear() ;
            _it = _set.iterator() ;
            notifyChanged( new PictureModelEvent( PictureModelEvent.CLEAR ) );
        }
        
        /**
         * Returns the string representation of the current picture url.
         * @return the string representation of the current picture url.
         */
        public function getUrl():String
        {
            return _url ;
        }
        
        /**
         * Hide the picture.
         */
        public function hide():void
        {
            notifyChanged(new PictureModelEvent( PictureModelEvent.VISIBLE, null, false ) ) ;
        }
        
        /**
         * Launch the loading of the next Picture in the model. If the model hasn't a next picture, the model load the first picture.
         * This method used an Iterator to keep the next url in the model. If the user use the 
         */
        public function run(...arguments):void
        {
            if (_it == null)
            {
                _it = _set.iterator() ;
            }
            if (!_it.hasNext()) 
            {
                _it.reset() ;
            }
            var uri:String = _it.next() ;
            trace(this + " run : " + uri) ;
            load( uri ) ;
        }
        
        /**
         * Notify a change in the model.
         */
        public function notifyChanged( e:PictureModelEvent ):void
        {
            broadcastMessage( "change" , e );
        }
        
        /**
         * Loads the picture defined bu the url specified in argument.
         * @param url the string representation of the file name to load.
         */
        public function load( url:String ):void
        {
            _url = url ;
            notifyChanged( new PictureModelEvent( PictureModelEvent.LOAD , _url ) ) ;
        }
        
        /**
         * Reset the internal Iterator of this model.
         */
        public function reset():void
        {
            _it.reset() ;
        }
        
        /**
         * Show the picture.
         */
        public function show():void
        {
            notifyChanged(new PictureModelEvent( PictureModelEvent.VISIBLE, null, true ) ) ;
        }
        
        /**
         * Defined the internal Iterator of this model.
         */
        private var _it:Iterator ;
        
        /**
         * The internal Set of this model.
         */
        private var _set:Set ;
        
        /**
         * @private
         */
        private var _url:String ;
    }

}