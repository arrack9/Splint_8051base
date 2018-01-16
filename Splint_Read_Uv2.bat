@echo off
setlocal enabledelayedexpansion
goto :main

:main
setlocal

title ReadUv2File
rem /r 搜尋目前目錄下的全部子目錄名所有.Uv2檔案 

set CURRENTPATH=%~dp0
set LineCount=0

for /r .\ %%a in (*.Uv2) do ( 
	set %%a=%%~na
	set Uv2PATH=%%a
	set Uv2FileName=%%~na
	Set FindPath=""
rem copy NUL !Uv2FileName!.rc
		for /f "tokens=1,2,3 delims=>" %%j in (!Uv2PATH!) do (
		set HeadString=%%j
		for /f "tokens=1,2,3,4 delims=<..\..\" %%k in ("!HeadString!") do (	
			if "!HeadString:~0,4!"=="File" (
			    set /a LineCount=LineCount+1
			    echo %%l\%%m\ >> !Uv2FileName!_C.txt	
				)
			)
		)
		set Flag=true
)

rem 比對是否有重覆的路徑
set LoopCount=1
set Kstring=""
:BackLoop
for /f "skip=%LoopCount%" %%k in (!Uv2FileName!_C.txt) do (
	  set Kstring=%%k
	  set /a LoopCount=LoopCount+1
	
	  goto :CompareStr
)
:CompareStr

rem 搜尋同樣路徑下的Inc folder
findstr /C:%Kstring% splint_8051.rc
IF ERRORLEVEL 1 echo -I.\%Kstring%>>splint_8051.rc
IF ERRORLEVEL 1 set "INCPATH=%CURRENTPATH%%Kstring%"
IF ERRORLEVEL 1 for /d /r "%INCPATH%" %%a in (*) do if /i "%%~nxa"=="Inc" echo -I.\%Kstring%Inc >>splint_8051.rc
if %LoopCount% NEQ %LineCount% goto :BackLoop

del !Uv2FileName!_C.txt

	echo -nestcomment >> splint_8051.rc
	echo -booltype Bool >> splint_8051.rc
	echo -boolfalse FALSE >> splint_8051.rc
	echo -booltrue TRUE >> splint_8051.rc
	echo -macrovarprefixexclude >> splint_8051.rc
	echo -unsignedcompare >> splint_8051.rc
	echo +charindex #To allow char types to index arrays >> splint_8051.rc

	echo -type >> splint_8051.rc
	echo -incondefs >> splint_8051.rc
	echo -nullderef >> splint_8051.rc
	echo -exportlocal >> splint_8051.rc
	echo -retvalbool #Result returned by function call is not used. >> splint_8051.rc
	
endlocal

start Splint_CMD.bat
goto :eof