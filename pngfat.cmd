@echo off

REM Jump to this directory
pushd "%~dp0"

echo. && echo %cd% && echo.

REM Title
echo PNG Fat && echo.

REM Check if FFmpeg exists
for %%x in (pngcrush.exe) do if not [%%~$PATH:x]==[] goto Initialized

echo Can't find PNG Crush, install PNG Crush then try again, press any key to exit...
echo.

pause > nul

exit /b

:Initialized

REM Check for input directory
if not exist "images" goto MakeImages

:QueryImages

REM Alert user
echo The images directory already exists, do you want to continue?
echo.

set /p m="Enter 'y' for yes or 'n' for no: "
echo.

if %m%==y goto UseImages
if %m%==n exit

REM If neither of the above
goto QueryImages

:MakeImages

mkdir "images"

:UseImages

echo Put the png files in the images folder then press any key to continue...

pause > nul

for %%f in (images\*.png) do (
  pngcrush -reduce -brute -ow %%f temp.png
)

echo.

echo Finished. && echo. && echo Press any key to exit...

pause > nul

exit /b
