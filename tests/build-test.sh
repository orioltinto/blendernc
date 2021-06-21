#!/bin/sh

$BLENDERPY -m ensurepip --default-pip

$BLENDERPY -m pip install -r requirements.txt --progress-bar off

$BLENDERPY -m pip install coverage pytest --progress-bar off

$BLENDERPY -m pip install -e . --progress-bar off

COVERAGE_PROCESS_START=${PWD}"/.coveragerc"
export COVERAGE_PROCESS_START=$COVERAGE_PROCESS_START
export PYTHONPATH=$PYTHONPATH:${PWD}

cd tests

echo -e "import coverage \n\ncov=coverage.process_startup()\n"> sitecustomize.py
echo -e "print('Initiate coverage')" >> sitecustomize.py
echo -e "print(cov)" >> sitecustomize.py

export PYTHONPATH=$PYTHONPATH:${PWD}

# blender -b --python bpy_activate_addon.py

$BLENDERPY run_tests.py

coverage combine
coverage report
coverage xml