#!/usr/bin/env bash

set -e

LOCATION=$1
CUSTOMER=$2
ENV=$3
OWNER=$4
EMAIl=$5
REPO=$6
IMAGE_NAME=$7
IMAGE=$8
RESOURCE_GROUP=$9
TEST_SCRIPT=${10}

MODULE_PATH="$( cd "$(dirname "$0")" ; pwd -P )/test/azure/$IMAGE/"

echo "INFO: Running terraform init..."
echo "INFO: MODULE_PATH: $MODULE_PATH"

terraform init "$MODULE_PATH"
terraform validate "$MODULE_PATH"

echo "INFO: Running terraform plan..."

terraform plan \
		-var "test_script=$TEST_SCRIPT" \
		-var "location=$LOCATION" \
		-var "customer=$CUSTOMER" \
		-var "env=$ENV" \
		-var "owner=$OWNER" \
		-var "email=$EMAIl" \
		-var "repo=$REPO" \
		-var "image=$IMAGE_NAME" \
		-var "resource_group=$RESOURCE_GROUP" \
		-out=terraform.tfplan "$MODULE_PATH"
{
    echo "INFO: Running terraform apply..."
    terraform apply -auto-approve terraform.tfplan

    echo "INFO: Running terraform destroy..."
    terraform destroy \
		  -var "test_script=$TEST_SCRIPT" \
      -var "location=$LOCATION" \
      -var "customer=$CUSTOMER" \
      -var "env=$ENV" \
      -var "owner=$OWNER" \
      -var "email=$EMAIl" \
      -var "repo=$REPO" \
      -var "image=$IMAGE_NAME" \
		  -var "image_resource_group=$RESOURCE_GROUP" \
      -auto-approve "$MODULE_PATH"

} ||
{
    echo "INFO: Running terraform destroy..."
    terraform destroy \
    	-var "test_script=$TEST_SCRIPT" \
      -var "location=$LOCATION" \
      -var "customer=$CUSTOMER" \
      -var "env=$ENV" \
      -var "owner=$OWNER" \
      -var "email=$EMAIl" \
      -var "repo=$REPO" \
      -var "image=$IMAGE_NAME" \
		  -var "image_resource_group=$RESOURCE_GROUP" \
      -auto-approve "$MODULE_PATH"
}

