set enable_cosim 0

open_project fc_proj 
set_top fc_layer
add_files ../fc_test/fc_layer.cpp 
add_files -tb ../fc_test/fc_layer_test.cpp -cflags "-I ../"
add_files -tb ../util/shared.cpp
add_files -tb ../nn_params
open_solution "solution1"
set_part {xcvu095-ffvc1517-2-e} -tool vivado
create_clock -period 10 -name default
csynth_design


exec mkdir -p results/fc
exec cp fc_proj/solution1/syn/report/fc_layer_csynth.rpt results/fc/synth.rpt

#test 1
csim_design -compiler gcc -argv "nn_params/fc1/"
if {$enable_cosim} {
  cosim_design -argv "nn_params/fc1"
  exec cp fc_proj/solution1/sim/report/fc_layer_cosim.rpt results/fc/fc1_cosim.rpt
}
#test 2
csim_design -compiler gcc -argv "nn_params/fc2/"
if {$enable_cosim} {
  cosim_design -argv "nn_params/fc2"
  exec cp fc_proj/solution1/sim/report/fc_layer_cosim.rpt results/fc/fc2_cosim.rpt
}

#test 3
csim_design -compiler gcc -argv "nn_params/fc3/"
if {$enable_cosim} {
  cosim_design -argv "nn_params/fc3"
  exec cp fc_proj/solution1/sim/report/fc_layer_cosim.rpt results/fc/fc2_cosim.rpt
}

#export_design -format ip_catalog
