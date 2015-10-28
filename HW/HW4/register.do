vlog -reportprogress 300 -work work register.v
vsim -voptargs="+acc" testRegister
run -all