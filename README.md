# VM Images

Using Packer this is building AWS EC2 machine images (AMI) with Ansible pre-installing packages.

Base AMI: `Ubuntu 18.04 LTS`

### Images

- [app-image](images/aws/app-image)
- [ops-image](images/aws/ops-image)

### Developing

- We use the [Packer](https://packer.io/) to build the AWS AMI.
- We use [Ansible](https://www.ansible.com/) to install and configure base tools and libraries.

```
$ make [Target]
```

### **Targets**

- `$ make validate`

    Execute command `$ packer validate...` to validate the packer template configurations.
 
- `$ make build IMAGE={image_name}`
    
    Execute command `$ packer build..` that will build the AWS AMI.

- `make test IMAGE={image_name}`
    
   This executes the test for Image, by launching the  AWS EC2 instance. Source code inside [test/](test). We use the 
   Terraform to automate the test.
   
   Terraform version: `>= 0.14`

### How to find AMIs

#### By tag
```
"Name": "app-image-2019-11-08T09-55-47Z-d12c461" OR "ops-image-2019-11-08T09-55-47Z-d12c461" 
```

## Maintainer

Mishal Shah -- _mishalshah92@gmail.com_

## Releases

Click [here](RELEASES.md) to view Releases!!!
