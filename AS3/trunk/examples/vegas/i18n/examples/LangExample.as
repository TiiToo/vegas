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
    import vegas.i18n.Lang;

    import flash.display.Sprite;

    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class LangExample extends Sprite 
    {
        public function LangExample()
        {
            trace( "Lang.ES.toString()        : " + Lang.ES.toString() ) ; // es
            trace( "Lang.ES.valueOf()         : " + Lang.ES.valueOf() ) ; // es
            trace( "Lang.ES.toSource()        : " + Lang.ES.toSource() ) ; // new vegas.i18n.Lang("es","Spanish")
            trace( "Lang.ES.label             : " + Lang.ES.label ) ; // Spanish
            
            trace( "Lang.get('fr') == Lang.FR : " + ( Lang.get("fr") == Lang.FR ) ) ; // true
            
            trace( "Lang.validate('fr')       : " + Lang.validate('fr') ) ; // true
            trace( "Lang.validate( Lang.FR )  : " + Lang.validate( Lang.FR ) ) ; // true
            
            trace( "Lang.LANGS                : " + Lang.LANGS ) ;
            // {pl:pl,nl:nl,es:es,tr:tr,it:it,da:da,pt:pt,fi:fi,zh-CN:zh-CN,no:no,ja:ja,de:de,ru:ru,fr:fr,zh-TW:zh-TW,xu:xu,ko:ko,en:en,sv:sv,cs:cs,hu:hu}
            trace( "Lang.LANGS.size()         : " + Lang.LANGS.size() ) ; // 21
        }
    }
}
