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

$strings = new stdClass();
$strings->requirePairValue     = "multiSerialize require pairs of values";
$strings->pairIsIgnored        = "name \"%1\$s\" is not a string, pair[%2\$s,%3\$s] is ignored";
$strings->reservedKeyword      = "\"%1\$s\" is a reserved keyword";
$strings->futurReservedKeyword = "\"%1\$s\" is a future reserved keyword";
$strings->notValidPath         = "\"%1\$s\" is not a valid path";
$strings->unterminatedComment  = "unterminated comment";
$strings->errorComment         = "syntax error (comment)";
$strings->errorIdentifier      = "bad identifier";
$strings->notValidConstructor  = "\"%1\$s\" is not a valid constructor";
$strings->doesNotExist         = "\"%1\$s\" does not exists";
$strings->errorConstructor     = "bad constructor";
$strings->errorLineTerminator  = "bad string (found line terminator in string)";
$strings->errorString          = "bad string (unterminated string)";
$strings->errorArray           = "bad array (unterminated array)";
$strings->errorObject          = "bad object (unterminated object)";
$strings->malformedHexadecimal = "bad number (malformed hexadecimal)";
$strings->errorNumber          = "bad number (not finite)";
$strings->extRefDoesNotExist   = "external reference \"%1\$s\" does not exists";
$strings->errorKeyword         = "syntax error";

?>