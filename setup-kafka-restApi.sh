#!/bin/sh

set -e
set -x

################

echo "*** kafka-rest api  kafka set up ..."


##############
### set up required folder
echo "*** setting up the directory ..."

mkdir -p tmp

mkdir -p docker/rest-connector/tmp
##############


############## clone ret api a and build ##############
echo "*** cloning the kafka rest connector files and building it ..."


git clone https://github.com/llofberg/kafka-connect-rest.git tmp/rest-connector

cd tmp/rest-connector
mvn clean install && \
cd examples/spring/gs-rest-service && \
mvn clean install 
#######################################################




########################## copying the files to the docker/rest-connector/tmp #######################################################
############ once copied the file will be copied from docker/rest-connector/tmp into docker, 
###########  by the docker file in docker/rest-connector folder

echo "*** copying jars to the docker file ..."

# mvn package -f custom-extensions/pom.xml
cp  kafka-connect-rest-plugin/target/kafka-connect-rest-plugin-*-shaded.jar \
        ../../docker/rest-connector/tmp/

cp kafka-connect-transform-velocity-eval/target/kafka-connect-transform-velocity-eval-*-shaded.jar \
        ../../docker/rest-connector/tmp

cp kafka-connect-transform-add-headers/target/kafka-connect-transform-add-headers-*-shaded.jar \
        ../../docker/rest-connector/tmp


cp kafka-connect-transform-from-json/kafka-connect-transform-from-json-plugin/target/kafka-connect-transform-from-json-plugin-*-shaded.jar \
        ../../docker/rest-connector/tmp

##############################################################################################################################

