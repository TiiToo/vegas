
@echo off

rem ############# Vegas Documentation properties


set root=../../../..

set as2api=%root%/tools/as2api/as2api.exe

set output=../deploy/

set src=%root%/src

set macromedia=..\dependencies

rem ############# Build the documentation

set classpaths=vegas.* pegas.* asgard.* andromeda.* buRRRn.*

set config=--classpath "%src%" --output-dir "%output%" --sources

echo Build the documentation

start %as2api% %classpaths% %config%

pause