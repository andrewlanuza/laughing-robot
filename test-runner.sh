#!/bin/bash

# generate test list first by running the command below
# robot \
#         --dryrun \
#         --argumentfile argument_file.txt \
#         --prerunmodifier test_runner.dry_runner.DryRunVisitor \
#         --include <your tag here> \
#         --output NONE \
#         --report NONE \
#         --log NONE \
#         --console none \
#         --nostatusrc \
#         src > tests.txt || exit 0

# get testname from generated test list
testList=(`cat tests.txt`)
testCount=${#testList[*]}

# now traverse list and run tests sequentially
counter=0

# terminate script on interrupt
trap "exit" INT

while [ $counter -lt $testCount ]
do
    outputDir="output/${testList[$counter]}"
    echo "Executing test $counter - ${testList[$counter]}"

    robot -A argument_file.txt --outputdir ${outputDir} -i ${testList[$counter]} .
    counter=$(( $counter + 1 ))

done
