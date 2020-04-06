@echo off
set xv_path=C:\\Xilinx\\Vivado\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto 02e81634fe7342029086fba40d3b2e2f -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot ag_behav xil_defaultlib.ag xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
