#
# Made by godison
# https://github.com/DisonGo
#

##	Перед вызовами любых целей нужно вызвать цель переключающую тип сборки (Debug/d, Release/r)
# По умолчанию стоит Release сборка

##	Шаблон вызова целей для проекта
# make ${тип сборки *не обязательный*} ${цель мейка}

##	Как собрать проект в Release сборке
#
# make init_b MLP
# make open

# Или

# make i MLP
# make o

##	Как собрать проект в Debug сборке

# make Debug init_b MLP
# make Debug open

# Или

# make d i MLP
# make d o


PROJECT_NAME 				= MLP
BUILD_TYPE 					= Release
BUILD_PATH_DEBUG		= ./build_debug
BUILD_PATH_RELEASE	= ./build
EXE_DIR 						= /exe
TESTS_TARGET				= TESTING

CMAKE_PATH					= .
CMAKE_TARGETS				= clean ${PROJECT_NAME} Network ${TESTS_TARGET}
CMAKE_BUILD_TYPES		= Debug Release

UNAME_S							:= $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	OPEN_CMD 					= xdg-open
endif
ifeq ($(UNAME_S),Darwin)
	EXE_EXT 					= .app
	OPEN_CMD 					= open
endif

CUR_BUILD_PATH 			= ./build_${BUILD_TYPE}
PROJECT_EXE_PATH 		= ${PROJECT_NAME}${EXE_EXT}
EXE_PATH 						= ${CUR_BUILD_PATH}${EXE_DIR}/${PROJECT_EXE_PATH}


install: i MLP
all: install
run: all
tests: setup_tests TESTING open
d: Debug
r: Release
i: init_b
t: tests
o: open
un: uninstall
# Инициализирует билд папку под текущий тип сборки
init_b:
	@cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -DEXE_DIR=${EXE_DIR} -Wno-dev -B ${CUR_BUILD_PATH} ${CMAKE_PATH}

# Переключатель типов сборки
${CMAKE_BUILD_TYPES}:
	$(eval BUILD_TYPE = $@)
	$(eval CUR_BUILD_PATH = ./build_${BUILD_TYPE})
	$(eval EXE_PATH = ${CUR_BUILD_PATH}${EXE_DIR}/${PROJECT_EXE_PATH})
	@echo Project set in $@ mode
# Цель для вызова целей в смейке
${CMAKE_TARGETS}:
	@cmake --build ${CUR_BUILD_PATH} --target $@ --parallel 8

setup_tests:
	$(eval EXE_PATH = ${CUR_BUILD_PATH}${EXE_DIR}/${TESTS_TARGET})
uninstall:
	@rm -rf ${CUR_BUILD_PATH}
open:
	@$(OPEN_CMD) ${EXE_PATH}
dist: install
	@tar cvzf ${PROJECT_NAME}.tgz ${CUR_BUILD_PATH}
clang:
	clang-format --style=Google -n $(shell find . -name '*.cc') $(shell find . -name '*.h')
clang-replace:
	clang-format --style=Google -i $(shell find . -name '*.cc') $(shell find . -name '*.h')

.PHONY: all setup_tests init_b ${CMAKE_TARGETS} ${CMAKE_BUILD_TYPES} d i t o un run install tests uninstall open dist clang clang-replace