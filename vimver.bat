@echo off

if not exist version.c (
	curl -L https://raw.githubusercontent.com/vim/vim/master/src/version.c --output version.c
)
if not exist version.h (
	curl -L https://raw.githubusercontent.com/vim/vim/master/src/version.h --output version.h
)
set VIMSCRIPT=join(filter(map(readfile('version.h'),{_,s-^>matchstr(s,'^#define VIM_VERSION_\(MAJOR\^|MINOR\)\s\+\zs\d\+$')}),'!empty(v:val)') + filter(map(readfile('version.c'),{_,s-^>printf('%%04d',matchstr(s,'^\s\+\zs\d\+\ze,$'))}),'str2nr(v:val)')[:0], '.')
set VIMSCRIPT=":call writefile(['::set-output name=vimver::' .. %VIMSCRIPT%], 'version.txt')"
vim.exe -u NONO -N --cmd %VIMSCRIPT% --cmd ":qa!"
type version.txt

