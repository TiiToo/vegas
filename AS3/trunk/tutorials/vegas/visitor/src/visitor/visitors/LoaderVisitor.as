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
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package visitor.visitors
{
    import vegas.utils.visitors.Visitable;
    import vegas.utils.visitors.Visitor;
    
    import visitor.display.Picture;
    
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    
    /**
     * The loader visitor of the Picture class.
     */
    public class LoaderVisitor implements Visitor
    {
        /**
         * Creates a new LoaderVisitor instance.
         * @param loader The loader reference of this visitor.
         * @param url The String representation of the full qualified file name to load.
         */
        public function LoaderVisitor( loader:Loader , url:String )
        {
            if ( loader == null )
            {
                throw new ArgumentError( this + " constructor failed, the loader reference not must be null.") ;
            }
            if ( loader == null )
            {
                throw new ArgumentError( this + " constructor failed, the loader reference not must be null.") ;
            }
            _request = new URLRequest( url ) ;
            _loader  = loader ;
            _loader.contentLoaderInfo.addEventListener( Event.COMPLETE, complete ) ;
        }
        
        /**
         * Disposes the visitor.
         */
        public function dispose():void
        {
            if( _loader != null )
            {
                _loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, complete ) ;
                _loader = null ;
            }
            _request = null ;
        }
        
        /**
         * Loader a Picture object. Visit the Visitable object. 
         */
        public function visit( o:Visitable ):void
        {
            _picture = o as Picture ;
            if ( _picture == null )
            {
                throw new Error(this + " 'visit' method failed, the visitor must be a Picture instance.") ;
            }
            _loader.load( _request ) ;
        }
        
        /**
         * Invoked when the picture loading is complete.
         */
        protected function complete( e:Event ):void
        {
            _picture.update() ;
            _picture.accept( new CenterVisitor( _loader ) ) ;
            _picture = null ;
        }
        
        
        /**
         * The loader reference.
         */
        private var _loader:Loader ;
        
        /**
         * The URLRequest of the visitor.
         */
        private var _request:URLRequest ;
        
        /**
         * @private
         */
        private var _picture:Picture ;
    }
}
