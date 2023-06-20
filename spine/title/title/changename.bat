@echo off
setlocal enabledelayedexpansion

set "sourceFolder=D:\NodeJS_Flutter_Game\spine\title"

for /R "%sourceFolder%" %%F in (title-*.gif) do (
  set "filename=%%~nxF"
  set "newFilename=!filename:title-=!"
  ren "%%F" "!newFilename!"
)

echo Thay thế tên file thành công.