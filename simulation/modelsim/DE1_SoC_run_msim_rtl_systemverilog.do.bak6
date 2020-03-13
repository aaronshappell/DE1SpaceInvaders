transcript on
if ![file isdirectory DE1_SoC_iputf_libs] {
	file mkdir DE1_SoC_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/CLOCK25_PLL_sim/CLOCK25_PLL.vo"

vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/clock_generator.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/audio_codec.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/audio_and_video_config.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_SYNC_FIFO.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_Slow_Clock_Generator.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_I2C_AV_Auto_Initialize.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_I2C.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_Clock_Edge.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_Audio_Out_Serializer.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_Audio_In_Deserializer.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/Altera_UP_Audio_Bit_Counter.v}
vlog -vlog01compat -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/altera_up_avalon_video_vga_timing.v}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/sprite.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/music.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/bcd.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/score_disp.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/enemy.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/player.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/score.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/enemy_col.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/enemy_grid.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/video_driver.sv}
vlog -sv -work work +incdir+D:/OneDrive/Documents/UW/2019-2020/EE371/lab6 {D:/OneDrive/Documents/UW/2019-2020/EE371/lab6/DE1_SoC.sv}

