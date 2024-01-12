@echo off

:: test if source_path is a directory
if exist "%~1\" (
  mklink /d "%~2" "%~1"
) else (
  mklink "%~2" "%~1"
)
