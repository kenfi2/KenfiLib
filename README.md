# KenfiLib
Lib for TFS 0.3/0.4/OTX

This repository was created so that the servers, which use TFS 0.3 / 0.4 / OTX2.X, can use scripts and systems developed for the version TFS 1.3.

For the installation of lib to be effective you need to install the repository in 'data/lib'. After installation, create a .lua file in the 'data/lib' folder and place the following function inside it: dofile('data/lib/KenfiLib/lib.lua') and then immediately go to file '032-position.lua' and delete the function 'Position'.

You can also insert function 'dofile('data/lib/KenfiLib/lib.lua')' in file 050-function.lua
