@echo off

echo %%~1: %~1
echo %%~2: %~2

:: test if source_path is a directory
if exist "%~1\" (
  mklink /d "%~2" "%~1"
) else (
  mklink "%~2" "%~1"
)
