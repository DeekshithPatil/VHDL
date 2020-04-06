# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/msjk/msjk.cache/wt} [current_project]
set_property parent.project_path {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/msjk/msjk.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
read_verilog -library xil_defaultlib {
  {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/msjk/msjk.srcs/sources_1/new/msjk.v}
  {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/msjk/msjk.srcs/sources_1/new/msj.v}
}
synth_design -top msj -part xc7a35tcpg236-1
write_checkpoint -noxdef msj.dcp
catch { report_utilization -file msj_utilization_synth.rpt -pb msj_utilization_synth.pb }
