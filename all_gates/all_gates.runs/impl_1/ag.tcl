proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7a35tcpg236-1
  set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/all_gates/all_gates.cache/wt} [current_project]
  set_property parent.project_path {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/all_gates/all_gates.xpr} [current_project]
  set_property ip_repo_paths {{c:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/all_gates/all_gates.cache/ip}} [current_project]
  set_property ip_output_repo {{c:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/all_gates/all_gates.cache/ip}} [current_project]
  add_files -quiet {{C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/all_gates/all_gates.runs/synth_1/ag.dcp}}
  link_design -top ag -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force ag_opt.dcp
  catch {report_drc -file ag_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file ag.hwdef}
  place_design 
  write_checkpoint -force ag_placed.dcp
  catch { report_io -file ag_io_placed.rpt }
  catch { report_utilization -file ag_utilization_placed.rpt -pb ag_utilization_placed.pb }
  catch { report_control_sets -verbose -file ag_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force ag_routed.dcp
  catch { report_drc -file ag_drc_routed.rpt -pb ag_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file ag_timing_summary_routed.rpt -rpx ag_timing_summary_routed.rpx }
  catch { report_power -file ag_power_routed.rpt -pb ag_power_summary_routed.pb }
  catch { report_route_status -file ag_route_status.rpt -pb ag_route_status.pb }
  catch { report_clock_utilization -file ag_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

