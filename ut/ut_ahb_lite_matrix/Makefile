# envir
.PHONY: compile tc_all verdi coverage coverage_all

# simulator
simulator := vcs

ifeq (${simulator},vcs)
	CMP_CMD := vcs
	PLI_OPTIONS := ${VERDI_HOME}/share/PLI/VCS/LINUX64/novas.tab
	PLI_OPTIONS += ${VERDI_HOME}/share/PLI/VCS/LINUX64/pli.a
endif
SIM_TOOL := verdi

# Common Setting



TOP := harness
SIM_LIST  := -f ./tb.lst
TIMESCALE := -timescale=1ns/1ps
TIME := $(shell date +"%Y%m%d%H%M%s")

# User Setting
USER_DEF_OPTIONS :=


# wave Setting
wave :=
ifeq (${wave},)
	WAVE := harness
else
	WAVE := ./wave/${wave}
endif
# seed Setting
seed :=
ifeq (${seed},)
	SEED := ${TIME}
else
	SEED := ./wave/${wave}
endif
# TestCase Setting
TC 	   := $(basename $(notdir $(wildcard ./tc/*.sv)))
CASE_NAMES := $(sort ${TC})
CASE_NUM   := $(words ${TC})

# VCS Setting
ifeq (${simulator},vcs)
	CMP_OPTIONS := +vcs+lic+wait -full64 +v2k -sverilog
	CMP_OPTIONS += -top ${TOP} ${SIM_LIST}
	CMP_OPTIONS += -notice +nospecify -ntb_opts check
	CMP_OPTIONS += -debug_access+all+dmptf -debug_region=cell+encrypt
	CMP_OPTIONS += ${TIMESCALE} -P ${PLI_OPTIONS} ${USER_DEF_OPTIONS}
	CMP_OPTIONS += -l vcs_compile.log
endif

#Coverage Setting
CM 	:= -cm line+cond+fsm+branch+tgl -cm_cond full
CM_NAME := -cm_name cov
CM_DIR  := -cm_dir ./${TOP}.vdb

compile:
	${CMP_CMD} ${CMP_OPTIONS} \
	${CM} ${CM_NAME} ${CM_DIR}

tc_all:
	@echo ${CASE_NAMES}
	@echo Total ${CASE_NUM} testcase
	-make ${CASE_NAMES}

$(TC):
	-rm -rf testcase.sv;
	mkdir -p wave
	mkdir -p log
	mkdir -p vdb_file
	cp -rf ./tc/$@.sv testcase.sv
	-make compile
	./simv +ntb_random_seed=${SEED} -l ./log/$@.log ${CM} ${CM_NAME} ${CM_DIR}
	cp -rf ${TOP}.fsdb ./wave/$@_${SEED}.fsdb
	cp -rf ${TOP}.vdb ./vdb_file/$@_${SEED}.vdb

	@echo ======================================================
	@echo compile has completed
	@echo ======================================================
#	-make coverage
#	-make verdi


verdi:
	verdi -sv -nologo -top ${TOP} ${SIM_LIST} -ssf ${WAVE}.fsdb &

coverage:
	dve -full64 -covdir ${TOP}.vdb &

coverage_all:
	urg -dir ./vdb_file/*.vdb -dbname merge.vdb
	dve -full64 -covdir merge.vdb &

clean:
	-rm -rf simv* verdiLog ucli* csrc novas* *.log *.vdb DVEfiles

clean_all:
	-make clean
	-rm -rf wave vdb_file log *.fsdb urgReport
