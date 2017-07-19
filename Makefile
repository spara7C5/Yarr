########################################
#  This file was generated by hdlmake  #
#  http://ohwr.org/projects/hdl-make/  #
########################################

TOP_MODULE := top_level
PWD := $(shell pwd)
PROJECT := yarr
PROJECT_FILE := $(PROJECT).xpr
#~~~~~~~added metacharacter to matche version~~~~~~
TOOL_PATH := /opt/Xilinx/Vivado/*/bin
TCL_INTERPRETER := vivado -mode tcl -source
ifneq ($(strip $(TOOL_PATH)),)
TCL_INTERPRETER := $(TOOL_PATH)/$(TCL_INTERPRETER)
endif

SYN_FAMILY := 
#~~~~~~~~changed ID PART~~~~~~
SYN_DEVICE := xc7k325
SYN_PACKAGE := tfbg676
SYN_GRADE := -2

TCL_CREATE := create_project -force $(PROJECT) ./
TCL_OPEN := open_project $(PROJECT_FILE)
TCL_CLOSE := exit
ifneq ($(wildcard $(PROJECT_FILE)),)
TCL_CREATE := $(TCL_OPEN)
endif

#target for performing local synthesis
all: bitstream

SOURCES_XDCFile := \
xpressk7.xdc

SOURCES_XCIFile := \
../../../ip-cores/kintex7/fifo_4x16/fifo_4x16.xci \
../../../ip-cores/kintex7/fifo_96x512_1/fifo_96x512.xci \
../../../ip-cores/kintex7/ila_axis/ila_axis.xci \
../../../ip-cores/kintex7/cross_clock_fifo/cross_clock_fifo.xci \
../../../ip-cores/kintex7/ila_pd_pdm/ila_pd_pdm.xci \
../../../ip-cores/kintex7/ila_dma_ctrl_reg/ila_dma_ctrl_reg.xci \
../../../ip-cores/kintex7/fifo_27x16/fifo_27x16.xci \
../../../ip-cores/kintex7/fifo_315x16/fifo_315x16.xci \
../../../ip-cores/kintex7/fifo_32x512/fifo_32x512.xci \
../../../ip-cores/kintex7/ila_l2p_dma/ila_l2p_dma.xci \
../../../ip-cores/kintex7/ila_wsh_pipe/ila_wsh_pipe.xci \
../../../ip-cores/kintex7/fifo_64x512/fifo_64x512.xci \
../../../ip-cores/kintex7/mig_7series_0/mig_7series_0.xci \
../../../ip-cores/kintex7/l2p_fifo64/l2p_fifo64.xci \
../../../ip-cores/kintex7/fifo_256x16/fifo_256x16.xci \
../../../ip-cores/kintex7/ila_ddr/ila_ddr.xci \
../../../ip-cores/kintex7/pcie_7x_0/pcie_7x_0.xci

SOURCES_VHDLFile := \
../../../rtl/common/common_pkg.vhd \
../../../rtl/kintex7/wshexp-core/p2l_decoder.vhd \
../../../rtl/kintex7/app_package.vhd \
../../../rtl/common/simple_counter.vhd \
top_level.vhd \
../../../rtl/kintex7/app.vhd \
../../../rtl/common/bcf_bram32.vhd \
../../../rtl/kintex7/wshexp-core/generic_async_fifo_wrapper.vhd \
../../../rtl/kintex7/wshexp-core/dma_controller_wb_slave.vhd \
../../../rtl/kintex7/wshexp-core/debugregisters.vhd \
../../../rtl/kintex7/wshexp-core/p2l_dma_master.vhd \
../../../rtl/kintex7/wshexp-core/l2p_fifo.vhd \
../../../rtl/kintex7/wshexp-core/dma_controller.vhd \
../../../rtl/kintex7/ddr3k7-core/ddr3_ctrl_wb.vhd \
../../../rtl/common/m_clk_sync.vhd \
../../../rtl/common/k_bram.vhd \
../../../rtl/kintex7/wshexp-core/wbmaster32.vhd \
../../../rtl/common/wshexp_core_pkg.vhd \
../../../rtl/kintex7/wshexp-core/l2p_arbiter.vhd \
../../../rtl/kintex7/ddr3k7-core/ddr3_ctrl_pkg.vhd \
../../../rtl/kintex7/wshexp-core/l2p_dma_master.vhd

###~~~~~~~~~~~~~added loop for IP upgrade + IP status~~~~~~
files.tcl: 
		@$(foreach sourcexci, $(SOURCES_XCIFile), echo "add_files -norecurse $(sourcexci); set_property IS_GLOBAL_INCLUDE 1 [get_files $(sourcexci)]; set locked [get_property IS_LOCKED [get_ips $(basename $(notdir $(sourcexci)))]] ; set upgrade [get_property UPGRADE_VERSIONS [get_ips $(basename $(notdir $(sourcexci)))]] ; if {"'$$'"upgrade != "'"''"'" && "'$$'"locked} {upgrade_ip [get_ips $(basename $(notdir $(sourcexci)))]} " >> $@ &)
		@echo "report_ip_status" >> $@ &
		@$(foreach sourcefile, $(SOURCES_XDCFile), echo "add_files -norecurse $(sourcefile); set_property IS_GLOBAL_INCLUDE 1 [get_files $(sourcefile)]" >> $@ &)
		@$(foreach sourcefile, $(SOURCES_VHDLFile), echo "add_files -norecurse $(sourcefile); set_property IS_GLOBAL_INCLUDE 1 [get_files $(sourcefile)]" >> $@ &)

SYN_PRE_PROJECT_CMD := 
SYN_POST_PROJECT_CMD := 

SYN_PRE_SYNTHESIZE_CMD := 
SYN_POST_SYNTHESIZE_CMD := 

SYN_PRE_PAR_CMD := 
SYN_POST_PAR_CMD := 

SYN_PRE_BITSTREAM_CMD := 
SYN_POST_BITSTREAM_CMD := 

project.tcl:
		echo $(TCL_CREATE) >> $@
		echo set_property "part" "$(SYN_DEVICE)$(SYN_PACKAGE)$(SYN_GRADE)" [current_project] >> $@
		echo set_property "target_language" "VHDL" [current_project] >> $@
		echo set_property "top" "$(TOP_MODULE)" [get_property srcset [current_run]] >> $@
		echo source files.tcl >> $@
		echo update_compile_order -fileset sources_1 >> $@
		echo update_compile_order -fileset sim_1 >> $@
		echo $(TCL_CLOSE) >> $@

project: files.tcl project.tcl
		$(SYN_PRE_PROJECT_CMD)
		$(TCL_INTERPRETER) $@.tcl
		$(SYN_POST_PROJECT_CMD)
		touch $@

synthesize.tcl:
		echo $(TCL_OPEN) >> $@
		echo  >> $@
		echo reset_run synth_1 >> $@
		echo launch_runs synth_1 >> $@
		echo wait_on_run synth_1 >> $@
		echo set result [get_property STATUS [get_runs synth_1]] >> $@
		echo set keyword [lindex [split '$$'result " "] end] >> $@
		echo if { '$$'keyword != \"Complete!\" } { >> $@
		echo     exit 1 >> $@
		echo } >> $@
		echo $(TCL_CLOSE) >> $@

synthesize: project synthesize.tcl
		$(SYN_PRE_SYNTHESIZE_CMD)
		$(TCL_INTERPRETER) $@.tcl
		$(SYN_POST_SYNTHESIZE_CMD)
		touch $@

par.tcl:
		echo $(TCL_OPEN) >> $@
		echo  >> $@
		echo reset_run impl_1 >> $@
		echo launch_runs impl_1 >> $@
		echo wait_on_run impl_1 >> $@
		echo set result [get_property STATUS [get_runs impl_1]] >> $@
		echo set keyword [lindex [split '$$'result " "] end] >> $@
		echo if { '$$'keyword != \"Complete!\" } { >> $@
		echo     exit 1 >> $@
		echo } >> $@
		echo $(TCL_CLOSE) >> $@

par: synthesize par.tcl
		$(SYN_PRE_PAR_CMD)
		$(TCL_INTERPRETER) $@.tcl
		$(SYN_POST_PAR_CMD)
		touch $@

bitstream.tcl:
		echo $(TCL_OPEN) >> $@
		echo set_property STEPS.WRITE_BITSTREAM.TCL.PRE /home/stefano/Desktop/bitstreamPRE.tcl [get_runs impl_1] >> $@
		echo launch_runs impl_1 -to_step write_bitstream >> $@
		echo wait_on_run impl_1 >> $@
		echo $(TCL_CLOSE) >> $@

bitstream: par bitstream.tcl
		$(SYN_PRE_BITSTREAM_CMD)
		$(TCL_INTERPRETER) $@.tcl
		$(SYN_POST_BITSTREAM_CMD)
		touch $@

CLEAN_TARGETS := $(LIBS) .Xil *.jou *.log *.pb $(PROJECT).cache $(PROJECT).data work $(PROJECT).runs $(PROJECT).hw $(PROJECT).ip_user_files $(PROJECT_FILE)

clean:
		rm -rf $(CLEAN_TARGETS)
		rm -rf project synthesize translate map par bitstream
		rm -rf project.tcl synthesize.tcl translate.tcl map.tcl par.tcl bitstream.tcl files.tcl

mrproper: clean
		rm -rf *.bit *.bin

.PHONY: mrproper clean all
