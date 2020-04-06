@echo off
set xv_path=C:\\Users\\DEEKSHITH\\Desktop\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto 2f4b7b3591894a3980bec9029c9f8c47 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot andga_behav xil_defaultlib.andga xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
