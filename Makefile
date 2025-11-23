REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
TAG:=$(DATE)-$(REV)

.PHONY: validate-aws validate-azure build-aws build-azure test-aws test-azure clean

IMAGE:=app-image

## AWS_Config
AWS_VM_SIZE=m4.large
AWS_SOURCE_AMI_NAME:="ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
AWS_SOURCE_IMAGE_OWNER:=099720109477

## AWS_Identity
AWS_RESOURCE_GROUP:=terraform-res
AWS_REGION:=ap-south-1
AWS_AMI_ACCOUNTS:=6sd54f616sd51fs
AWS_AMI_REGIONS:=ap-south-1,us-east-1

## Azure_Config
AZURE_VM_SIZE=Standard_DS2_v2
AZURE_OS_TYPE=Linux
AZURE_IMAGE_PUBLISHER:=Canonical
AZURE_IMAGE_OFFER:=UbuntuServer
AZURE_IMAGE_SKU:=18.04-LTS

## Azure_Identity
Azure_RESOURCE_GROUP:=terraform-rg
Azure_SUBSCRIPTION_ID:=a14f85b3-2720-42fc-9c8d-7187e5278613
Azure_LOCATION:=centralindia

AZURE_TEST_SCRIPT:=app_test.sh

## Tags
IMAGE_NAME=$(IMAGE)_$(LOCATION)_$(TAG)
CUSTOMER:=customer
ENV:=test
OWNER:=Mishal Shah
EMAIL:=mishalshah92@gmail.com
REPO:=https://github.com/mishalshah92/vm-images.git

validate-aws:
	packer validate images/aws/$(IMAGE)/worker_template.json

validate-azure:
	packer validate images/azure/$(IMAGE)/worker_template.json


build-aws: validate-aws
	packer build \
		-var "name=$(IMAGE_NAME)" \
		-var "region=$(AWS_REGION)" \
		-var "vm_size=$(AWS_VM_SIZE)" \
		-var "source_ami_name=$(AWS_SOURCE_AMI_NAME)" \
		-var "source_image_owner=$(AWS_SOURCE_IMAGE_OWNER)" \
		-var "ami_accounts=$(AWS_AMI_ACCOUNTS)" \
		-var "resource_group=$(AWS_RESOURCE_GROUP)" \
		-var "ami_regions=$(AWS_AMI_REGIONS)" \
		-var "dest_ami_name=$(AWS_IMAGE_NAME)" \
		-var "repo=$(REPO)" \
		-var "customer=$(CUSTOMER)" \
		-var "owner=$(OWNER)" \
		-var "email=$(EMAIL)"  images/aws/$(IMAGE)/worker_template.json

build-azure: validate-azure
	packer build \
		-var "vm_size=$(Azure_VM_SIZE)" \
		-var "os_type=$(Azure_OS_TYPE)" \
		-var "image_publisher=$(Azure_IMAGE_PUBLISHER)" \
		-var "image_offer=$(Azure_IMAGE_OFFER)" \
		-var "image_sku=$(Azure_IMAGE_SKU)" \
		-var "vm_size=$(Azure_VM_SIZE)" \
		-var "resource_group=$(Azure_RESOURCE_GROUP)" \
		-var "subscription_id=$(Azure_SUBSCRIPTION_ID)" \
		-var "location=$(Azure_LOCATION)" \
		-var "image_name=$(IMAGE_NAME)" \
		-var "customer=$(CUSTOMER)" \
		-var "repo=$(REPO)" \
		-var "owner=$(OWNER)" \
		-var "email=$(EMAIL)"  images/azure/$(IMAGE)/worker_template.json

test-azure:
	sh .test/test-azure.sh $(LOCATION) $(CUSTOMER) $(ENV) $(OWNER) $(EMAIl) $(REPO) $(IMAGE_NAME) $(IMAGE) $(RESOURCE_GROUP) $(AZURE_TEST_SCRIPT)

test-aws:
	sh .test/test-aws.sh $(REGION) $(CUSTOMER) $(ENV) $(OWNER) $(EMAIl) $(REPO) $(IMAGE)

install:
	tfenv install

clean:
	rm -rf .terraform/ || true
	rm *.tfplan  || true
