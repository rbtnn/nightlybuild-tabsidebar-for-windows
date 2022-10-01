
set NAME=nightlybuild-tabsidebar-for-windows

if exist "%NAME%.zip" (
	del /Q "%NAME%.zip"
)
if exist "%NAME%" (
	rmdir /S /Q "%NAME%"
)
if exist winpty (
	rmdir /S /Q winpty
)
if exist winpty.zip (
	del   /Q    winpty.zip
)
if exist ripgrep (
	rmdir /S /Q ripgrep
)
if exist ripgrep.zip (
	del   /Q    ripgrep.zip
)
if exist ctags (
	rmdir /S /Q ctags
)
if exist ctags.zip (
	del   /Q    ctags.zip
)

mkdir "%NAME%"
mkdir "%NAME%\runtime"

curl -L https://github.com/rprichard/winpty/releases/download/0.4.3/winpty-0.4.3-msvc2015.zip --output winpty.zip
curl -L https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-i686-pc-windows-msvc.zip --output ripgrep.zip
curl -L https://github.com/universal-ctags/ctags-win32/releases/download/2022-09-27/p5.9.20220925.0-2-g34f1c6a/ctags-2022-09-27_p5.9.20220925.0-2-g34f1c6a-x86.zip --output ctags.zip

copy src\gvim-x86.exe      "%NAME%\gvim.exe"
copy src\vim-x86.exe       "%NAME%\vim.exe"
copy src\vimrun.exe    "%NAME%"
copy src\xxd\xxd.exe   "%NAME%"
copy src\tee\tee.exe   "%NAME%"
xcopy /S runtime       "%NAME%\runtime"

powershell -Command "Expand-Archive winpty.zip"
powershell -Command "Expand-Archive ripgrep.zip"
powershell -Command "Expand-Archive ctags.zip"

copy winpty\ia32\bin\winpty.dll               "%NAME%\winpty32.dll"
copy winpty\ia32\bin\winpty-agent.exe         "%NAME%"
copy winpty\ia32\bin\winpty-debugserver.exe   "%NAME%"
copy ripgrep\ripgrep-13.0.0-i686-pc-windows-msvc\rg.exe    "%NAME%"
copy ctags\ctags.exe    "%NAME%"

powershell -Command Compress-Archive -Path "%NAME%" -DestinationPath "%NAME%.zip"
