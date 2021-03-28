REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
TAG:=$(DATE)-$(REV)
.PHONY: build test

IMAGE:=app-image

## Config
VM_SIZE=m4.large
SOURCE_AMI_NAME:="ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
SOURCE_IMAGE_OWNER:=099720109477

## Identity
RESOURCE_GROUP:=terraform-res
REGION:=ap-south-1
AMI_ACCOUNTS:=6sd54f616sd51fs
AMI_REGIONS:=ap-south-1,us-east-1

## Tags
SERVICE=app
IMAGE_NAME=$(IMAGE)_$(LOCATION)_$(TAG)
CUSTOMER:=customer
OWNER:=Mishal Shah
EMAIL:=mishalshah1992@gmail.com
REPO:=https://github.com/mishah92/aws-ec2-images.git

validate:
	packer validate src/$(IMAGE)/worker_template.json

build: validate
	packer build \
		-var "name=$(IMAGE_NAME)" \
		-var "region=$(REGION)" \
		-var "vm_size=$(VM_SIZE)" \
		-var "source_ami_name=$(SOURCE_AMI_NAME)" \
		-var "source_image_owner=$(SOURCE_IMAGE_OWNER)" \
		-var "ami_accounts=$(AMI_ACCOUNTS)" \
		-var "resource_group=$(RESOURCE_GROUP)" \
		-var "ami_regions=$(AMI_REGIONS)" \
		-var "dest_ami_name=$(IMAGE_NAME)" \
		-var "repo=$(REPO)" \
		-var "customer=$(CUSTOMER)" \
		-var "owner=$(OWNER)" \
		-var "email=$(EMAIL)"  src/$(IMAGE)/worker_template.json

test:
	sh ./test.sh $(REGION) $(CUSTOMER) $(ENV) $(OWNER) $(EMAIl) $(REPO) $(IMAGE)
