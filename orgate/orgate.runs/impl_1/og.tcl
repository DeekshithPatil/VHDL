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
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7a35tcpg236-1
  set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/orgate/orgate.cache/wt} [current_project]
  set_property parent.project_path {C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/orgate/orgate.xpr} [current_project]
  set_property ip_repo_paths {{c:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/orgate/orgate.cache/ip}} [current_project]
  set_property ip_output_repo {{c:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/orgate/orgate.cache/ip}} [current_project]
  add_files -quiet {{C:/Users/DEEKSHITH/Desktop/Study/5th Sem/VHDL/Lab/orgate/orgate.runs/synth_1/og.dcp}}
  link_design -top og -part xc7a35tcpg236-1
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
  write_checkpoint -force og_opt.dcp
  catch {report_drc -file og_drc_opted.rpt}
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
  catch {write_hwdef -file og.hwdef}
  place_design 
  write_checkpoint -force og_placed.dcp
  catch { report_io -file og_io_placed.rpt }
  catch { report_utilization -file og_utilization_placed.rpt -pb og_utilization_placed.pb }
  catch { report_control_sets -verbose -file og_control_sets_placed.rpt }
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
  write_checkpoint -force og_routed.dcp
  catch { report_drc -file og_drc_routed.rpt -pb og_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file og_timing_summary_routed.rpt -rpx og_timing_summary_routed.rpx }
  catch { report_power -file og_power_routed.rpt -pb og_power_summary_routed.pb }
  catch { report_route_status -file og_route_status.rpt -pb og_route_status.pb }
  catch { report_clock_utilization -file og_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force og.bit 
  catch { write_sysdef -hwdef og.hwdef -bitfile og.bit -meminfo og.mmi -ltxfile debug_nets.ltx -file og.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

