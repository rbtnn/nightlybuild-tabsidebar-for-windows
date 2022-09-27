
set NAME=nightlybuild-tabsidebar-for-windows

if exist "%NAME%" (
	rmdir /S /Q "%NAME%"
)
mkdir "%NAME%"
mkdir "%NAME%\runtime"

curl -L https://github.com/rprichard/winpty/releases/download/0.4.3/winpty-0.4.3-msvc2015.zip --output winpty.zip
powershell -Command "Expand-Archive winpty.zip"
copy winpty\ia32\bin\winpty.dll               "%NAME%\winpty32.dll"
copy winpty\ia32\bin\winpty-agent.exe         "%NAME%"
copy winpty\ia32\bin\winpty-debugserver.exe   "%NAME%"
rmdir /S /Q winpty
del   /Q    winpty.zip

curl -L https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-i686-pc-windows-msvc.zip --output ripgrep.zip
powershell -Command "Expand-Archive ripgrep.zip"
copy ripgrep\ripgrep-13.0.0-i686-pc-windows-msvc\rg.exe    "%NAME%"
rmdir /S /Q ripgrep
del   /Q    ripgrep.zip

curl -L https://github.com/universal-ctags/ctags-win32/releases/download/2022-09-27/p5.9.20220925.0-2-g34f1c6a/ctags-2022-09-27_p5.9.20220925.0-2-g34f1c6a-x86.zip --output ctags.zip
powershell -Command "Expand-Archive ctags.zip"
copy ctags\ctags.exe    "%NAME%"
rmdir /S /Q ctags
del   /Q    ctags.zip

copy src\gvim.exe      "%NAME%"
copy src\vim.exe       "%NAME%"
copy src\vimrun.exe    "%NAME%"
copy src\xxd\xxd.exe   "%NAME%"
copy src\tee\tee.exe   "%NAME%"
xcopy /S runtime       "%NAME%\runtime"

if exist "%NAME%.zip" (
	del /Q "%NAME%.zip"
)
powershell -Command Compress-Archive -Path "%NAME%" -DestinationPath "%NAME%.zip"
if exist "%NAME%" (
	rmdir /S /Q "%NAME%"
)

