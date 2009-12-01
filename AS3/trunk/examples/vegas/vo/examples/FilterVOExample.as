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
package examples 
{
    import vegas.vo.FilterVO;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example of the FilterVO class.
     */
    public class FilterVOExample extends Sprite 
    {
        public function FilterVOExample()
        {
            var VIDEO :uint = 1 ;
            var MP3   :uint = 2 ; 
            
            var filter:FilterVO = new FilterVO() ;
            
            trace( "filter : " +  filter ) ; 
            //output: filter : [FilterVO:0]
            
            filter.toggleFilter( VIDEO , true ) ;
             
            trace( "filter : " +  filter ) ; 
            //output: filter : [FilterVO:1]
            
            trace( "filter.toggleFilter( MP3, true ) : " + filter.toggleFilter( MP3, true ) ) ; 
            //output: filter.toggleFilter( MP3, true ) : true
            
            trace( "filter.toggleFilter( MP3, true ) : " + filter.toggleFilter( MP3, true ) ) ;
            //output: filter.toggleFilter( MP3, true ) : false
            
            trace("filter : " +  filter ) ;
            //output: filter : [FilterVO:3]
            
            filter.toggleFilter( VIDEO , false ) ;
            
            trace( "filter : " +  filter ) ;
             //output: filter : [FilterVO:2]
             
            trace( "filter.contains( VIDEO ) : " + filter.contains( VIDEO ) ) ;
            //output: filter.contains( VIDEO ) : false
            
            trace( "filter.contains( MP3 )   : " + filter.contains( MP3 ) ) ;
            //output: filter.contains( MP3 )   : true
        }
    }
}
