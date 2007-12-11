
class test.CustomTextField extends TextField
{

     public function CustomTextField()
     {
         
         setNewTextFormat( new TextFormat("arial", 11) ) ;

         background      = true ;
         backgroundColor = 0xFFFFFF ;
         selectable  = false ;
         text       = "my text" ;
         textColor   = 0xFF0000 ;

         _width      = 100 ;
         _height     = 20 ;
         
     }

}