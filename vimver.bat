@echo off

if not exist version.c (
	curl -L https://raw.githubusercontent.com/vim/vim/master/src/version.c --output version.c
)
if not exist version.h (
	curl -L https://raw.githubusercontent.com/vim/vim/master/src/version.h --output version.h
)

set SAVE_PATH=%PATH%
set PATH=C:\Windows\Microsoft.NET\Framework64\v4.0.30319

echo using System;                                                                                    > main.cs
echo using System.IO;                                                                                 >> main.cs
echo using System.Text.RegularExpressions;                                                            >> main.cs
echo class Prog {                                                                                     >> main.cs
echo 	static void Main() {                                                                          >> main.cs
echo 		var major = 0;                                                                            >> main.cs
echo 		var minor = 0;                                                                            >> main.cs
echo 		var patch = 0;                                                                            >> main.cs
echo 		var rx1 = new Regex(@"^#define VIM_VERSION_MAJOR\s*(?<num>\d+)$");                        >> main.cs
echo 		var rx2 = new Regex(@"^#define VIM_VERSION_MINOR\s*(?<num>\d+)$");                        >> main.cs
echo 		foreach (var line in File.ReadAllLines("version.h")) {                                    >> main.cs
echo 			var matches = rx1.Matches(line);                                                      >> main.cs
echo 			if (0 ^< matches.Count) {                                                             >> main.cs
echo 				major = Convert.ToInt32(matches[0].Groups["num"].Value);                          >> main.cs
echo 			}                                                                                     >> main.cs
echo 			matches = rx2.Matches(line);                                                          >> main.cs
echo 			if (0 ^< matches.Count) {                                                             >> main.cs
echo 				minor = Convert.ToInt32(matches[0].Groups["num"].Value);                          >> main.cs
echo 			}                                                                                     >> main.cs
echo 		}                                                                                         >> main.cs
echo 		var rx3 = new Regex(@"^\s*(?<num>\d+),$");                                                >> main.cs
echo 		foreach (var line in File.ReadAllLines("version.c")) {                                    >> main.cs
echo 			var matches = rx3.Matches(line);                                                      >> main.cs
echo 			if (0 ^< matches.Count) {                                                             >> main.cs
echo 				patch = Convert.ToInt32(matches[0].Groups["num"].Value);                          >> main.cs
echo 				break;                                                                            >> main.cs
echo 			}                                                                                     >> main.cs
echo 		}                                                                                         >> main.cs
echo 		Console.WriteLine("::set-output name=vimver::{0}.{1}.{2:D4}", major, minor, patch);       >> main.cs
echo 	}                                                                                             >> main.cs
echo }                                                                                                >> main.cs

csc /nologo main.cs

main.exe

del /Q main.cs
del /Q main.exe

set PATH=%SAVE_PATH%

