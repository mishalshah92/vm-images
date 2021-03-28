#!/usr/bin/env bash

set -e

MODULE_PATH="$( cd "$(dirname "$0")" ; pwd -P )/test/"
REGION=$1
CUSTOMER=$2
ENV=$3
OWNER=$4
EMAIl=$5
REPO=$6
IMAGE=$7


echo "INFO: Running terraform init..."
echo "INFO: MODULE_PATH: $MODULE_PATH"

terraform init "$MODULE_PATH"
terraform validate "$MODULE_PATH"

echo "INFO: Running terraform plan..."

terraform plan \
		-var "region=$REGION" \
		-var "customer=$CUSTOMER" \
		-var "env=$ENV" \
		-var "owner=$OWNER" \
		-var "email=$EMAIl" \
		-var "repo=$REPO" \
		-var "image=$IMAGE" \
		-out=terraform.tfplan "$MODULE_PATH"
{
    echo "INFO: Running terraform apply..."
    terraform apply -auto-approve terraform.tfplan

    echo "INFO: Running terraform destroy..."
    terraform destroy \
      -var "region=$REGION" \
      -var "customer=$CUSTOMER" \
      -var "env=$ENV" \
      -var "owner=$OWNER" \
      -var "email=$EMAIl" \
      -var "repo=$REPO" \
      -var "image=$IMAGE" \
      -auto-approve "$MODULE_PATH"

} ||
{
    echo "INFO: Running terraform destroy..."
    terraform destroy \
      -var "region=$REGION" \
      -var "customer=$CUSTOMER" \
      -var "env=$ENV" \
      -var "owner=$OWNER" \
      -var "email=$EMAIl" \
      -var "repo=$REPO" \
      -var "image=$IMAGE" \
      -auto-approve "$MODULE_PATH"
}

