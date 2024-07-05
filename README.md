# AksLearn
## Repository created to learn AKS

### 1. How to create infrastructure

#### 1.1 Terraform
Infrastructure can be created using *terraform*. You need to have a setup of *terraform* stack before you can run any infrastructure migrations.

#### 1.2 Backend configuration
If you need to have a terraform state shared between computers/users/environment (as yousually me) you need to create a correct configuration for a backend. I'm storing this information in separate repository. Example of my file is:

``` backend.hcl
resource_group_name  = "resource-group-name"
storage_account_name = "storage-account-name"
container_name       = "container-name"
key                  = "where-to-store-a-state"
```

If you will follow the same approach, you can initiate your *terraform* folder with command:

```
terraform init --backend-config=/path_to_file/backend.hcl
```


