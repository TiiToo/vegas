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

package observer.models
{
    import system.data.Iterator;
    import system.data.Set;
    import system.data.sets.ArraySet;
    import system.process.Runnable;
    import system.signals.Signal;
    
    /**
     * This model contains a set of picture urls to load in the application.
     */
    public class PictureModel extends Signal implements Runnable
    {
        /**
         * Creates a new PictureModel.
         */
        public function PictureModel()
        {
            _set = new ArraySet() ;
        }
        
        /**
         * Inserts a new picture url in the model, if the url exist the url isn't inserted.
         * @return 'true' if the url is inserted else 'false' if the url allready exist in the model.
         */
        public function addUrl( url:String ):Boolean
        {
            var b:Boolean = _set.add( url ) ;
            if ( b )
            {
                notifyChanged( PictureMessage.ADD , url ) ;
            }
            return b ;
        }
        
        /**
         * Clears the model.
         */
        public function clear():void
        {
            _set.clear() ;
            _it = _set.iterator() ;
            notifyChanged( PictureMessage.CLEAR ) ;
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
            notifyChanged( PictureMessage.VISIBLE, null, false ) ;
        }
        
        /**
         * Launch the loading of the next Picture in the model. If the model hasn't a next picture, the model load the first picture.
         * This method used an Iterator to keep the next url in the model. If the user use the 
         */
        public function run( ...arguments:Array ):void
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
        public function notifyChanged( type:String = null , url:String = null , visible:Boolean = false ):void
        {
            emit( new PictureMessage( type , url , visible ) );
        }
        
        /**
         * Loads the picture defined bu the url specified in argument.
         * @param url the string representation of the file name to load.
         */
        public function load( url:String ):void
        {
            _url = url ;
            notifyChanged( PictureMessage.LOAD , _url ) ;
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
            notifyChanged( PictureMessage.VISIBLE, null, true ) ;
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