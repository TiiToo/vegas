/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is NinjAS Framework.
  
  The Initial Developer of the Original Code is 
  ALCARAZ Marc <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2009-2010
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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
*/

package lunas.components.labels 
{
    import graphics.FillStyle;
    import graphics.geom.EdgeMetrics;
    
    import vegas.text.CoreStyleSheet;
    
    /**
     * The style of the PaginationTitle component.
     */
    public class PaginationLabelStyle extends LabelStyle 
    {
        /**
         * Creates a new ProfileTitleStyle instance.
         * @param init An object that contains properties with which to populate the newly Style object. If init is not an object, it is ignored.
         * @param id The id of the object.
         */
        public function PaginationLabelStyle( init:* = null , id:* = null )
        {
            super( init , id );
        }
        
        //////////////
        
        /**
         * The default css string expression.
         */
        public static var DEFAULT_CSS_EXPRESSION:String = "" ;
        
        DEFAULT_CSS_EXPRESSION  += "p{font-family:Verdana;font-size:11px;color:#FFFFFF;font-weight:bold;}" ;
        DEFAULT_CSS_EXPRESSION  += ".pagination_label_current{font-size:10px;color:#FFFFFF;font-weight:bold;}" ;
        DEFAULT_CSS_EXPRESSION  += ".pagination_label_first{font-size:10px;color:#FCF3AD;font-weight:bold;}" ;
        DEFAULT_CSS_EXPRESSION  += ".pagination_label_last{font-size:10px;color:#FCF3AD;font-weight:bold;}" ;
        DEFAULT_CSS_EXPRESSION  += ".pagination_label_next{font-size:10px;color:#CCCCCC;font-weight:bold;}" ;
        DEFAULT_CSS_EXPRESSION  += ".pagination_label_previous{font-size:10px;color:#CCCCCC;font-weight:bold;}" ;
        DEFAULT_CSS_EXPRESSION  += ".pagination_label_body{font-size:10px;color:#FFFF66;}" ;
        DEFAULT_CSS_EXPRESSION  += "a:hover{font-size:10px;color:#BABA01;}" ;
        
        //////////////
        
        /**
         * The stylesheet style name of the current page label.
         */
        public var currentStyleName:String = "pagination_label_current" ;
        
        /**
         * The first pattern
         */
        public var firstPattern:String = "<a class='pagination_label_first' href='event:{0}'>{1} </a>" ;
        
        /**
         * The last pattern
         */
        public var lastPattern:String = "<a class='pagination_label_last' href='event:{0}'>{1}</a>" ;
        
        /**
         * The link pattern
         */
        public var linkPattern:String = "<a class='pagination_label_body' href='event:{0}'>{1}</a>" ;
        
        /**
         * The next pattern
         */
        public var nextPattern:String = "<a class='pagination_label_next' href='event:{0}'>{1} </a>" ;
        
        /**
         * The pagination string format pattern of the p pattern.
         */
        public var pattern:String = "{title} {first} {previous} {body} {next} {last}" ;
        
        /**
         * The previous pattern
         */
        public var previousPattern:String = "<a class='pagination_label_previous' href='event:{0}'>{1} </a>" ;
        
        /**
         * The separator between two links.
         */
        public var separator:String = " " ;
        
        /**
         * Initialize the IStyle object.
         */
        public override function initialize():void 
        {
            multiline    = false ;
            padding      = new EdgeMetrics( 2, 2, 2, 2 ) ;
            theme        = new FillStyle( 0 , 0.4 ) ;
            themeBorder  = null ;
            useTextColor = false ;
            styleSheet   = new CoreStyleSheet( DEFAULT_CSS_EXPRESSION ) ;
            wordWrap     = true ;
        }
    }
}
