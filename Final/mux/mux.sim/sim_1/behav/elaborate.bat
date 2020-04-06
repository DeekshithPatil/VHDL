@echo off
set xv_path=C:\\Users\\DEEKSHITH\\Desktop\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto c6a38a6f0e3d4d65b0a62805c106c23b -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot mux_behav xil_defaultlib.mux xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
