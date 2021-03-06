# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/project_2/project_2.cache/wt} [current_project]
set_property parent.project_path {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/project_2/project_2.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
read_verilog -library xil_defaultlib {{C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/project_2/project_2.srcs/sources_1/new/xffd.v}}
read_xdc {{C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/Basys3_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/Basys3_Master.xdc}}]

synth_design -top xffd -part xc7a35tcpg236-1
write_checkpoint -noxdef xffd.dcp
catch { report_utilization -file xffd_utilization_synth.rpt -pb xffd_utilization_synth.pb }
