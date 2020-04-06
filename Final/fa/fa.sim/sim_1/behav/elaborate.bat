@echo off
set xv_path=C:\\Users\\DEEKSHITH\\Desktop\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto 820f0597714947de89a7672e413b9584 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot fa_behav xil_defaultlib.fa -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
