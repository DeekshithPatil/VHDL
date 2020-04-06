@echo off
set xv_path=C:\\Users\\DEEKSHITH\\Desktop\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto 482e146326d1484e9b5ade2e3e67ddbf -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot jkf_behav xil_defaultlib.jkf xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
