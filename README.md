[Cloud Module - Final Project.pdf](https://drive.google.com/file/d/1ZZeKjo0MPhqRPQETKPmf0opmLLtfOGY0/view?usp=sharing)

## Todo:
1. Complete Github Actions
2. Storing and retrieving
   * db_username
   * db_password
3. [Managing Amazon S3 access with VPC endpoints and S3 Access Points
](https://aws.amazon.com/blogs/storage/managing-amazon-s3-access-with-vpc-endpoints-and-s3-access-points/)
4. FE
5. Connect FE to API
6. TLS - Transfer Layer Security
7. 



### 


[terragrunt]: https://terragrunt.gruntwork.io/

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
Next moved on to `Using Amazon ECR with the AWS CLI` section to pull the image onto EC2 instance

## Monday, 16 January

Spent time trying to pull the API Docker image from AWS ECR Private repo. No success there. Proceeded to attempt a manual pull of the image from AWS ECR. Again, No success. Then tried to access the DB from EC2 instance and realised the DB was not in the same VPC as the DB. Will try to create the DB in my custom VPC to access it.

## Tueday, 17 January

Moved on to FE. Started with *reate-react-app* to work on connecting FE to API

## Wednesday, 18 January

Installed [Postgres](https://computingforgeeks.com/installing-postgresql-database-server-on-ubuntu/) on ubuntu partition to set up FE > API > DB connection. 
I'm facing a challenge with rolling power cutsin ZA escalated to 3 times per day.

## Thursday, 19 January

Postgres testDB is set up. Hopefully complete the Full Stack flow.
Then move the flow to AWS within my Custom VPC, implementing it all in Terraform.

## Friday, 20 January

Full Stack app is running on local.
Next step is to Dockerise the FE, 
apdate the API Dockerfile with the Postgres changes
Set up new Postgres data tier in Terraform

## Friday. 27 January

Had a challenging week with rolling power cuts scheduled in the middle of my side-project focus time
Not much to report this week.
Mainly worked on pulling an image from AWS ECR to EC2 instance
Also had an issue connecting to PostgreSQL DB on on AWS RDS. Found the problem where i made the DB publicly accessible but still could not connect to the DB inistance on DBeaver.
The problem was, I needed to add a rule to the SG Security Group to allow the IP of my local machine access

## Monday, 06 February

Spend time on docker-compose to connect Frontend, Backend and Database.
This morning I managed to run docker compose up and visit https://localhost:3000 to view the Frontend.
On the Frontend, I managed to perform basic CRUD operations.
Also, used the volumes to persist the data added to the Database via the app.

```
Volumes are the preferred mechanism for persisting data generated by and used by Docker containers. While bind mounts are dependent on the directory structure and OS of the host machine, volumes are completely managed by Docker
```
## Monday, 20 February

For the past 2 weeks I've working pulling images from AWS ECR to AWS EC2 instance then deploying the container.
Went down the AWS ECS rabbit hole and incurred charges for using AWS ECS and Fargate. 
Did manage, by using AWS ECS, to deploy the ReactApp container and view it in the browser.
When trying to deploy all 3 containers, "out of memory" message popped up.
I gracefully shut down the "rabbit hole" as to not incur any more charges.

Back to the drawing board.
Will try pulling images from Docker Hub as it worked when using AWS ECS.
My only issue is that it's from my public repo on Docker Hub.
I'm first going to get it working then work on securing the infrastructure.



*******
**
**
*******
### NGINX

[How To Setup Nginx Web Server
](https://fosslife.com/how-to-setup-nginx-web-server/)

[Using NGINX As Load Balancer](https://fosslife.com/using-nginx-as-load-balancer/)

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

```
cloud_mods_final_project
│     └─ tags
├─ .github
│  └─ workflows
│     └─ terraform.yml
├─ .gitignore
├─ .terraform
│  └─ providers
│     └─ registry.terraform.io
│        └─ hashicorp
│           ├─ aws
│           │  └─ 4.38.0
│           │     └─ linux_amd64
│           │        └─ terraform-provider-aws_v4.38.0_x5
│           └─ null
│              └─ 3.2.1
│                 └─ linux_amd64
│                    └─ terraform-provider-null_v3.2.1_x5
├─ .terraform.lock.hcl
├─ README.md
├─ global
│  └─ s3
│     ├─ .terraform
│     │  └─ providers
│     │     └─ registry.terraform.io
│     │        └─ hashicorp
│     │           ├─ aws
│     │           │  ├─ 3.26.0
│     │           │  │  └─ linux_amd64
│     │           │  │     └─ terraform-provider-aws_v3.26.0_x5
│     │           │  └─ 4.49.0
│     │           │     └─ linux_amd64
│     │           │        └─ terraform-provider-aws_v4.49.0_x5
│     │           └─ random
│     │              └─ 3.0.1
│     │                 └─ linux_amd64
│     │                    └─ terraform-provider-random_v3.0.1_x5
│     ├─ .terraform.lock.hcl
│     ├─ main.tf
│     ├─ outputs.tf
│     └─ variables.tf
├─ main.tf
├─ modules
│  └─ stage
│     ├─ data-stores
│     │  └─ mysql
│     │     └─ .terraform
│     │        └─ providers
│     │           └─ registry.terraform.io
│     │              └─ hashicorp
│     │                 └─ aws
│     │                    └─ 4.49.0
│     │                       └─ linux_amd64
│     │                          └─ terraform-provider-aws_v4.49.0_x5
│     └─ services
│        └─ webserver-cluster
└─ stage
   ├─ data-stores
   │  └─ mysql
   │     ├─ .terraform
   │     │  └─ providers
   │     │     └─ registry.terraform.io
   │     │        └─ hashicorp
   │     │           └─ aws
   │     │              └─ 4.49.0
   │     │                 └─ linux_amd64
   │     │                    └─ terraform-provider-aws_v4.49.0_x5
   │     ├─ .terraform.lock.hcl
   │     ├─ main.tf
   │     ├─ outputs.tf
   │     └─ variables.tf
   └─ services
      └─ webserver-cluster
         ├─ main.tf
         ├─ outputs.tf
         └─ variables.tf

```
