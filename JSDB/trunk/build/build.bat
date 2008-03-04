
@echo off

rem ############################# 

set library=../library

set src=../src

rem ############################# 

set jsdb=../jsdb.exe

rem #############################

set arguments= %src%/main.js

start %jsdb% %arguments%
