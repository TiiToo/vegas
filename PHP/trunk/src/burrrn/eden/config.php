<?php

/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation PHP. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

$config = new stdClass();
$config->directorySeparator = "/"; // / -> Linux , \\ -> Windows
/* packagesRepository:
   where we kept all the packages and classes
*/
$config->packagesRepository           = "packages";
$config->classFileExtensions          = ".php";
/* serializeUnserializableClass:
   if an object got a class but not toSource method
   we return null instead of a serialized object
*/
$config->serializeUnserializableClass = true;
$config->compress                     = true;
$config->copyObjectByValue            = true;
$config->strictMode                   = true;
$config->undefineable                 = null;
$config->verbose                      = false;

?>