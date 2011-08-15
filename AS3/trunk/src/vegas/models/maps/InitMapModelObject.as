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

package vegas.models.maps
{
    import system.data.ValueObject;
    import system.process.Task;
    
    /**
     * Initialize the model with a Array of ValueObject objects.
     */
    public class InitMapModelObject extends Task
    {
        /**
         * Creates a new InitMapModelObject instance.
         * @param datas The Array representation of all ValueObject to insert in the map model.
         */
        public function InitMapModelObject( datas:Array = null )
        {
            this.datas = datas ;
        }
        
        /**
         * Indicates if the model is autocleared when the process start.
         */
        public var autoClear:Boolean ;
        
        /**
         * Indicates if the first item inserted in the model must be selected.
         */
        public var autoSelect:Boolean ;
        
        /**
         * Indicates if the first attribute must be autocleared when the process is finished.
         */
        public var cleanFirst:Boolean ;
        
        /**
         * The Array representation of all value object. 
         */
        public var datas:Array ;
        
        /**
         * This property define a ValueObject or a specific id to run the map model when is initialized.
         */
        public var first:* ;
        
        /**
         * The model reference.
         */
        public var model:MapModelObject ;
        
        /**
         * Enable the verbose mode of this process.
         */
        public var verbose:Boolean ;
        
        /**
         * Transforms the passed-in value in ValueObject. 
         * This method is used in the run() method to filter all elements in the datas array.
         */
        public function filterValueObject( value:* ):ValueObject
        {
            return value as ValueObject ;
        }
        
        /**
         * Reset the process.
         */
        public function reset():void 
        {
            datas = null ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            if( autoClear && model != null && !model.isEmpty() )
            {
                model.clear() ;
            }
            if ( arguments.length > 0 && arguments[0] is Array )
            {
                datas = arguments[0] as Array ;
            }
            if( datas == null )
            {
                logger.warn(this + " run failed, the datas reference not must be null.") ;
                notifyFinished() ;
                return ;
            } 
            if ( datas == null || datas.length == 0 )
            {
                logger.warn(this + " can't fill the model with a null or empty Array of ValueObject objects.") ;
                notifyFinished() ;
                return ;
            }
            if( verbose )
            {
                logger.debug(this + " run : " + datas) ;
            }
            
            if( model == null )
            {
                logger.warn(this + " run failed, the model reference not must be null.") ;
                notifyFinished() ;
                return ;
            } 
            var vo:ValueObject    ;
            var size:int = datas.length ;
            for( var i:int ; i < size ; i++ )
            {
                try
                {
                    vo = filterValueObject( datas[i] ) ; 
                    model.addVO( vo ) ;
                    if ( first == null && vo != null )
                    {
                        first = vo ;
                    }
                }
                catch( er:Error )
                {
                    logger.warn(this + " " + er.toString()) ; 
                }
            }
            if ( first != null && autoSelect )
            {
                if ( first is ValueObject )
                {
                    model.setCurrentVO( first ) ;
                }
                else if ( model.containsByID( first ) )
                {
                    model.setCurrentVO( model.getVO( first )  ) ;
                }
                if ( cleanFirst )
                {
                    first = null ;
                }
            }
            notifyFinished() ;
        }
    }
}