
## Friday, 06 January 2023

Implement a folder structure to isolate environments

Seperate folders makes it much clearer which environment you're deploying to.

Seperate Terraform folders (and therefore separate state files) for each environment (staging, production, etc.) and for each component (VPC, services, databases) within that environment.

* stage: An environment for pre-production workloads (i.e., testing)
* prod: An environment for production workloads (i.e., user-facing apps)
* mgmt: An environment for DevOps tooling (e.g., bastion host, CI server)
* global: A place to put resources that are used across all environments (e.g., S3, IAM)

Within each environment, there are separate folders for each “component.”

* vpc: The network topology for this environment.
* services: The apps or microservices to run in this environment, such as a Ruby on Rails frontend or a Scala backend. Each app could even live in its own folder to isolate it from all the other apps.
* data-storage: The data stores to run in this environment, such as MySQL or Redis. Each data store could even reside in its own folder to isolate it from all other data stores.

Within each component, there are the actual Terraform configuration files, which are organized according to the following naming conventions:

* variables.tf: Input variables
* outputs.tf: Output variables
* main.tf: Resources and data sources

Using a consistent, predictable naming convention makes your code easier to browse: e.g., you’ll always know where to look to find a variable, output, or resource.

## Disadvantages
### Working with multiple folders:
But it also prevents you from creating your entire infrastructure in one command.
You need to run terraform apply separately in each folder. 

```
Solution: Use [Terragrunt][terragrunt], you can run commands across multiple folders concurrently using the run-all command.
```

### Copy/paste: 
The file layout has a lot of duplication. 

```
Solution: You won’t actually need to copy and paste all of that code! Next step is, how to use Terraform modules to keep all of this code DRY.
```

### Resource dependencies: 
Breaking the code into multiple folders makes it more difficult to use resource dependencies. 
You can no longer directly access attributes of the database using an attribute reference (e.g., access the database address via aws_db_instance.foo.address).

```
Solution: One option is to use dependency blocks in Terragrunt.
Another option is to use the terraform_remote_state data source, as described in the next section.
```
### Completed storage of terraform state in S3 bucket

---
## Sunday, 08 January 2023
Stared with Github Actions

## Monday, 09 January 2023

Yaml file has syntax errors
Also had to brush up on [Git Branching](https://www.varonis.com/blog/git-branching)

A fellow trainee suggested [Github Actions extention](https://marketplace.visualstudio.com/items?itemName=cschleiden.vscode-github-actions) which has automatic syntax highlighting and suggestions

## Sunday, 15 January, 2023

Created private repo on [Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/getting-started-console.html)
where you store your Docker or Open Container Initiative (OCI) images in Amazon 
Each time you push or pull an image from Amazon ECR, 
you specify the repository and the registry location which 
informs where to push the image to or where to pull it from.
```
I was looking for a way to pull an image onto an EC2 instance
Hopefully I can pull the FE and API images to the respective EC2 instances
```
## Todo:
1. Github Actions
2. Storing and retrieving
   * db_username
   * db_password
3. [Managing Amazon S3 access with VPC endpoints and S3 Access Points
](https://aws.amazon.com/blogs/storage/managing-amazon-s3-access-with-vpc-endpoints-and-s3-access-points/)

### AWS Key Management Service

```
Free tier
AWS KMS provides a free tier of 20,000 requests/month calculated across all Regions that the service is available.

*Requests to the GenerateDataKeyPair and GenerateDataKeyPairWithoutPlaintext API operations and requests to API operations such as Sign, Verify, Encrypt, Decrypt, and GetPublicKey that reference asymmetric KMS keys are excluded from the free tier.

```

### AWS Secrets Manager

```
Free Trial
30-DAY TRIAL PERIOD
You can try AWS Secrets Manager at no additional charge with a 30-day free trial. The free trial enables you to rotate, manage, and retrieve secrets over the 30-day period.

Your free trial starts when you store your first secret.

```

### 


[terragrunt]: https://terragrunt.gruntwork.io/
