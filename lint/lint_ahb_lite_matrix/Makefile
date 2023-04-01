export SHELL :=/bin/bash
# include config parameter for simulator
include ./cfg.mk

#novas
VERDI_PLI  := -P ${VERDI_HOME}/share/PLI/VCS/LINUX64/novas.tab
VERDI_PLI  +=    ${VERDI_HOME}/share/PLI/VCS/LINUX64/pli.a

# env set
export TCL_TOP_MODULE 			:= ${TOP_MODULE}
export TCL_FILELIST_FILE   	:= $(patsubst -F,,$(patsubst -f,,${OPTS_CMP_LIST}))
export TCL_SDC_FILE   			:= ${SDC_FILE}
export TCL_SGDC_FILE   			:= ${SGDC_FILE}
export TCL_WAIVER_FILE   		:= ${WAIVER_FILE}
# @ref vcs
VCS_BASIC_OPTS := +v2k -full64 -timescale=1ns/1ps  -sverilog +plusarg_save
VCS_BASIC_OPTS += -debug_access+all -ntb_opts check +notimingchek +nospecif
VCS_BASIC_OPTS += ${VERDI_PLI} +vcs+lic+waity +lint=TFIPC-L
VCS_BASIC_OPTS += -top ${TOP_MODULE}
VCS_BASIC_OPTS += ${OPTS_CMP_LIST}
VCS_BASIC_OPTS += ${COM_USR_OPTS}
VCS_BASIC_OPTS += -l vcs_compile.log

# @ref verdi
VERDI_BASIC_OPTS := +v2k -lca -nologo -sv
VERDI_BASIC_OPTS += -top ${TOP_MODULE}
VERDI_BASIC_OPTS += ${OPTS_SIM_LIST}
VERDI_BASIC_OPTS += ${COM_USR_OPTS}
#VERDI_BASIC_OPTS += -ntb_opts uvm
VERDI_BASIC_OPTS += -logfile verdi_compile.log

# make command
run_vcs:
	vcs ${VCS_BASIC_OPTS}

run_verdi:
	verdi ${VERDI_BASIC_OPTS} &

sg_lint:
	sg_shell -tcl ${IPCHK_ROOT}/spyglass_scripts/spy_lint.tcl | tee -i sg_lint.log

sg_gui:
	spyglass -project ${TOP_MODULE}.prj &

sg_cdc:
	sg_shell -tcl ${IPCHK_ROOT}/spyglass_scripts/spy_cdc.tcl | tee -i sg_cdc.log

dc_setup:
	mkdir -p syn/logs
	mkdir -p syn/results
	mkdir -p syn/reports
	@echo -e "${RTL_LIST}\n${CBB_LIST}" > ./syn/rtl.lst

dc_elab:
	cd syn; bsub -q design -I dcnxt_shell -x "set DESIGN_NAME ${TOP_MODULE}; set icg_use no; set RTL_SRC_LIST ./rtl.lst; set SDC_INPUT_FILE ${SDC_FILE}; set ADDITIONAL_LINK_LIB_FILES ${ADD_LINK_LIB};" -f ${IPCHK_ROOT}/quick_dc_syn/scripts/elab.tcl         | tee -i ./logs/elab.log

dc_comp:
	cd syn; bsub -q design -I dcnxt_shell -x "set DESIGN_NAME ${TOP_MODULE}; set icg_use no; set RTL_SRC_LIST ./rtl.lst; set SDC_INPUT_FILE ${SDC_FILE}; set ADDITIONAL_LINK_LIB_FILES ${ADD_LINK_LIB};" -f ${IPCHK_ROOT}/quick_dc_syn/scripts/compile.tcl         | tee -i ./logs/comp.log

dc_incr_comp:
	cd syn; bsub -q design -I dcnxt_shell -x "set DESIGN_NAME ${TOP_MODULE}; set icg_use no; set RTL_SRC_LIST ./rtl.lst; set SDC_INPUT_FILE ${SDC_FILE}; set ADDITIONAL_LINK_LIB_FILES ${ADD_LINK_LIB};" -f ${IPCHK_ROOT}/quick_dc_syn/scripts/incr_compile.tcl         | tee -i ./logs/incr_comp.log

dc:
	make dc_setup;
	make dc_elab;
	make dc_comp;
	make dc_incr_comp;

clean:
	rm -rf *.log novas* verdiLog sg_* ${TOP_MODULE}* csrc simv* syn
