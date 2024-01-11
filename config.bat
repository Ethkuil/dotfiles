@echo off
call D:\etc\lib\batch_remklink.bat "%~dp0" "%USERPROFILE%" .*

reg add "HKEY_CURRENT_USER\Environment" /v "PYTHONSTARTUP" /t REG_EXPAND_SZ /d "%%USERPROFILE%%\.pythonstartup" /f
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
