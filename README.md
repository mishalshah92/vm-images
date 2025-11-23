# VM Images

A unified build framework for creating production-ready VM machine images (AMIs for AWS, VMs for Azure) using 
Packer and Ansible.

## What it does
- Uses Packer templates to build machine images for both AWS and Azure with predefined tooling and configurations installed via Ansible.
- Maintains separate image variants (for example: app-image, ops-image) for different use-cases.
- Supports validation, building, and testing workflows (including spinning up instances for validation) of generated images.
- Provides automation via a Makefile to streamline common operations like validate, build, test.

## Key Features
- Cross-cloud: Support for AWS (EC2 AMIs) and Azure VM images.
- Pre-installed tooling: Use Ansible to configure OS, install packages, prepare image for production workloads.
- CI/CD readiness: Validate and test images automatically before promotion.
- Tagging and naming standards: Generated images follow structured naming (e.g., app-image-YYYY-MM-DDT…).
- Modular & extensible: Add new image definitions, build scripts, or cloud providers as needed.

Base Image: `Ubuntu 18.04 LTS`

## Images

**AWS**
- [app-image](images/aws/app-image)
- [ops-image](images/aws/ops-image)

**Azure**
- [app-image](images/azure/app-image)
- [ops-image](images/azure/ops-image)

## Developing

- We use the [Packer](https://packer.io/) to build the VM Images.
- We use [Ansible](https://www.ansible.com/) to install and configure base tools and libraries.

```shell
$ make [Target]
```

#### **Make Targets**

- `$ make validate-aws / make validate-azure`

    Execute command `$ packer validate...` to validate the packer template configurations.
 
- `$ make build-aws IMAGE={image_name}  / make build-azure IMAGE={image_name}`
    
    Execute command `$ packer build..` that will build the AWS AMI.

- `make test-aws IMAGE={image_name}  / make test-azure IMAGE={image_name}`
    
   This executes the test for Images, by launching the VM instance. Source code inside [test/](test). We use the 
   Terraform to automate the test.
   
Terraform version: `>= 0.14`

## How to find Images?

#### For AWS - By tag
```
app-image-YYYY-MM-DDThh-mm-ssZ-<hash>
ops-image-YYYY-MM-DDThh-mm-ssZ-<hash>
```

#### For Azure - The name of the Azure machine can be like below.
```
app-image_<region>_YYYY-MM-DDThh-mm-ssZ-<hash>
```

## Directory Structure

```shell
├── images/
│   ├── aws/
│   │   ├── app-image/
│   │   └── ops-image/
│   └── azure/
│       ├── app-image/
│       └── ops-image/
├── test/
│   └── terraform/           # workflows to test built images
├── Makefile
├── README.md
└── RELEASES.md
```

## Maintainer

Mishal Shah -- _mishalshah92@gmail.com_

## Releases

Click [here](RELEASES.md) to view Releases!!!
