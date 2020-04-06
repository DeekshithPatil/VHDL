@echo off
set xv_path=C:\\Users\\DEEKSHITH\\Desktop\\Vivado\\2015.1\\bin
call %xv_path%/xsim andga_behav -key {Behavioral:sim_1:Functional:andga} -tclbatch andga.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
