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
├─ .git
│  ├─ COMMIT_EDITMSG
│  ├─ FETCH_HEAD
│  ├─ HEAD
│  ├─ ORIG_HEAD
│  ├─ branches
│  ├─ config
│  ├─ description
│  ├─ hooks
│  │  ├─ applypatch-msg.sample
│  │  ├─ commit-msg.sample
│  │  ├─ fsmonitor-watchman.sample
│  │  ├─ post-update.sample
│  │  ├─ pre-applypatch.sample
│  │  ├─ pre-commit.sample
│  │  ├─ pre-merge-commit.sample
│  │  ├─ pre-push.sample
│  │  ├─ pre-rebase.sample
│  │  ├─ pre-receive.sample
│  │  ├─ prepare-commit-msg.sample
│  │  ├─ push-to-checkout.sample
│  │  └─ update.sample
│  ├─ index
│  ├─ info
│  │  └─ exclude
│  ├─ logs
│  │  ├─ HEAD
│  │  └─ refs
│  │     ├─ heads
│  │     │  ├─ main
│  │     │  ├─ modules
│  │     │  ├─ update-pull-request
│  │     │  └─ update-tfc-backend
│  │     └─ remotes
│  │        └─ origin
│  │           ├─ main
│  │           ├─ modules
│  │           ├─ update-pull-request
│  │           └─ update-tfc-backend
│  ├─ objects
│  │  ├─ 01
│  │  │  ├─ 180b10af4f3ca9340b9faf82bb8229ef1a7791
│  │  │  ├─ db96ff1f88433a12c72451985f2ec0642b434c
│  │  │  └─ f34b0d47e58cc69bb9a4a2e4df0e3069e7b145
│  │  ├─ 02
│  │  │  ├─ 695ce8b9285e6a3be61a26e4d4bd1014a57765
│  │  │  └─ 935d37485cd6c9555fe399b3c6e04cf499e484
│  │  ├─ 04
│  │  │  └─ f759a2fd51e26a520b1e36f480e401bc5f75d6
│  │  ├─ 05
│  │  │  ├─ 1dac564fb2b953dc6d8620d73c76d976c6db6a
│  │  │  ├─ 3c5693e0163d429fed8d3a4365c36499171f15
│  │  │  ├─ 7aa333a69bba4c6952f67cf381ff3e2bdf272d
│  │  │  └─ e8d16828d130b306cc54250061fc41ba4b329b
│  │  ├─ 06
│  │  │  ├─ 2332c8c3b73d69c9b3fafbefbcb140326b114b
│  │  │  └─ a89d58206c9f27bfc68be13ba595922cf1cc51
│  │  ├─ 08
│  │  │  └─ 69ff1ce653d5eb08ccd989fb0875cb051b752e
│  │  ├─ 09
│  │  │  └─ 4cd628819ddf42106685b2663bac52e89fc9fe
│  │  ├─ 0b
│  │  │  ├─ 70c7d3fc38602b31ca77048750b58c707dbd4e
│  │  │  └─ ac111f94eb697858a3adace222a77aa12c1d8c
│  │  ├─ 0d
│  │  │  ├─ 227ebb77f393f472f63e2d8dca47123e45bd53
│  │  │  ├─ 974756d44957972146d10dc866131981e4ea4f
│  │  │  └─ c1b07237758b893e917badda75a8e976781d4c
│  │  ├─ 0f
│  │  │  └─ da98c5d2f2bcd827036bd74c605a4f91ab61d5
│  │  ├─ 16
│  │  │  ├─ 305134ddb687962eaaf395161708c8a729d36f
│  │  │  └─ 47f1c03d287b226602c2226bdea5a715f4074b
│  │  ├─ 1a
│  │  │  ├─ 54115ea2f9c9e70e542d3af60a5ec064e9744d
│  │  │  └─ 6049b79d2096946ff6e79e46b9160c4cef70de
│  │  ├─ 20
│  │  │  └─ 410492a6cb4b13392bac3944c38b145d9c4d8b
│  │  ├─ 21
│  │  │  └─ 45ace654a818bb97c8a43c15d5152f5f0aafad
│  │  ├─ 25
│  │  │  └─ dacb357554e44e3a284ce2cc6a00918fe38d41
│  │  ├─ 26
│  │  │  ├─ 0918855701930ac1bcf6e859245efc9fda6a50
│  │  │  └─ 6bc3fe1c990117b64ee43895200db0444f5752
│  │  ├─ 27
│  │  │  └─ 688a5bdcb7cbcc7491180f0a5ff755666558a2
│  │  ├─ 28
│  │  │  └─ e355e7424c45dd070b614b8a5e169ecfc8c2d8
│  │  ├─ 2c
│  │  │  └─ d34b3d1144cdc4e89c0037c71f8d8409b116f3
│  │  ├─ 2d
│  │  │  ├─ d552af094296ffd04afffc400a1cb807c53e75
│  │  │  └─ da2d0b3c649557effe87bb76713eeeabb62961
│  │  ├─ 30
│  │  │  └─ 9b001d2abc7e5ed2b3e60f19d24af30bbf64b6
│  │  ├─ 31
│  │  │  ├─ 4f38b29d0e43a7a2014f8c48649d7c187a8a1c
│  │  │  └─ 552b3e28fbda685a15b029b35db760dabea78d
│  │  ├─ 33
│  │  │  ├─ 64dded13368d57ff977f9246aa9d95542fbab5
│  │  │  ├─ e92c1e4365bc90a7a226fc72798d2fea5ce76d
│  │  │  └─ fc5280f525642233b5f7140ffa3ad9dacbd4c3
│  │  ├─ 34
│  │  │  ├─ 6f502b9499a9b80684aeaf08e19cc471a11627
│  │  │  └─ f26d1409e62decad57972dc907548d5d82749d
│  │  ├─ 35
│  │  │  ├─ 8baa527eeacd9308eb4d2d68100690b7521aa9
│  │  │  └─ acc8f9bebdfc74b496c9d8098f7cabb5df22f2
│  │  ├─ 38
│  │  │  └─ c23a9880cf8263c83edddc35a86668fa0ae072
│  │  ├─ 39
│  │  │  ├─ 8b3f3cb2777f69345fc285c35f09475820d21b
│  │  │  └─ a1e6ea553d7acc86548505fecba25b02bdf2b3
│  │  ├─ 3b
│  │  │  ├─ 3178e2a0deaadc82e26c815113fdca8d90fab0
│  │  │  └─ 97a8e7811ae359b8fd50d066728b8fba416d30
│  │  ├─ 3d
│  │  │  ├─ 91a39e204195a721c21ce8a110ceae1fbec08d
│  │  │  └─ a6547b78e2903bf97ac1349dd5f23323c90de6
│  │  ├─ 40
│  │  │  └─ e4aec8c3030a14b5e7d59e57c95a6a005327bb
│  │  ├─ 44
│  │  │  └─ 359a79a20df01f995bd6d9ebf38f6bfb416d6c
│  │  ├─ 45
│  │  │  └─ 3fad9a02bd15aef2dc2d9a165e1270c16574a8
│  │  ├─ 46
│  │  │  └─ c4f643c42f1e1e26e56ebde7bc0a29211423b4
│  │  ├─ 47
│  │  │  └─ 2afa50b43fcf901f162e464f8af635ab2701ec
│  │  ├─ 48
│  │  │  ├─ 626ec4ff8f08521e9f0e6fd0c8b27bab86c0be
│  │  │  └─ f1bc051ff5ba5fb34e57f0a0333accbdfff065
│  │  ├─ 4a
│  │  │  └─ f8d2038fc0dd8f2223ae01eddf43d8bb8940a9
│  │  ├─ 4b
│  │  │  ├─ a605d3467dd1c2f6025186f0c983255bce4b96
│  │  │  └─ a79695dd7670f0a2c7b6908b4ac63cf2e2ca95
│  │  ├─ 51
│  │  │  ├─ 7b292998dab1a5dafebc528315fa4bc43fa4d5
│  │  │  └─ 94b6e8a1156cffb08815b3aa6510e0b25177a7
│  │  ├─ 52
│  │  │  ├─ 244776041f47e65f4ebe39e1bd1af0f9274d3e
│  │  │  └─ 4f9429d7c368007e75ff6cd6ba010ab03aa380
│  │  ├─ 53
│  │  │  └─ af4e71c3afddda8d5ffafc7fe5a847b32ec2da
│  │  ├─ 56
│  │  │  ├─ 5dec985d09c51495627920e76fcf84be074f79
│  │  │  └─ e9312fced86eced01ca76f15be073ca45c2a43
│  │  ├─ 57
│  │  │  └─ d1211caa2d93fb142e644d94413e93322a0111
│  │  ├─ 58
│  │  │  └─ 1a873f8e881f97ad2753895d6547650cc2f0f0
│  │  ├─ 5a
│  │  │  ├─ 40d49e01dceb8a0074339c15b7bb3381de8153
│  │  │  ├─ a062c36bd510b1a315213f9ea48943ae52fa4a
│  │  │  └─ b45144027f1186040c76c633cbcdfc8eeb544a
│  │  ├─ 5b
│  │  │  └─ df11674e9471162da9aa946ef9c6fc5b44185b
│  │  ├─ 5c
│  │  │  └─ 79f91afd2c83c465bf10bd5a754f1a58b40291
│  │  ├─ 5d
│  │  │  ├─ 07f0fb7886bdb21dc8391f151eccf9b3d07a95
│  │  │  └─ b116f5d7205cd8a644cab942ccae5c4d3f2db2
│  │  ├─ 5e
│  │  │  ├─ 007a5e6e40c144678bb01ab30119fd988ee07d
│  │  │  └─ 0b3af12ac11a92fc64c165fcbd3bd0c989de2d
│  │  ├─ 62
│  │  │  └─ 3431fdf834d5c988c8278c54cc0625bdc38e03
│  │  ├─ 64
│  │  │  └─ 159c9a2804b01e3acd9ffe99fa2e2ea02776a2
│  │  ├─ 65
│  │  │  └─ 49c295b2112faafce8ff6b45ba4dcda6c6363f
│  │  ├─ 66
│  │  │  └─ 6a58c2b233a337b40c8fe045e3d2302a585e50
│  │  ├─ 69
│  │  │  └─ c9b038fb31a1ff2f33115c8992b4df3bcfb2fb
│  │  ├─ 6a
│  │  │  └─ 7b51d147aa4ba8f578becb348e076cfc43da79
│  │  ├─ 6b
│  │  │  ├─ 08443ed2e2046dff2f007c5f80fbed3cb45ebd
│  │  │  └─ da1fe3ed7ebae58d456447d6ca8486388d7832
│  │  ├─ 6d
│  │  │  └─ 09b1a95d1814ed5e2e747c110376442ff4a7f7
│  │  ├─ 6e
│  │  │  └─ dde982c94314663e5962591379b736b27a870f
│  │  ├─ 6f
│  │  │  └─ 6c159d42d0a0644fb4db1466216ec42911edd6
│  │  ├─ 70
│  │  │  └─ 2c444ea6fe658c27ad425f757e6237a8b4a4a5
│  │  ├─ 71
│  │  │  └─ 15641786284274bff2a34650cc46b9b28a099f
│  │  ├─ 75
│  │  │  └─ dc6f7a434d9c85a258ec05e6da34c808292268
│  │  ├─ 76
│  │  │  └─ ee3539e6c7037ace00be605f72757e5543ef37
│  │  ├─ 77
│  │  │  └─ 7bc96c26cf771c6a2bd37ed1654bc56e01c879
│  │  ├─ 79
│  │  │  ├─ 01e5b2b3e09d660a2814b6ef03d36b49da344e
│  │  │  └─ 9da57a93222af1c178e6d1658bb7f6beb3097c
│  │  ├─ 7c
│  │  │  ├─ 6a5010dff60c75c7c81baf52f61396c55227db
│  │  │  └─ 9d4efba5f9d26ddad238f808585edc12c0e466
│  │  ├─ 7f
│  │  │  └─ c2c2b9afcce340fe20d9361fd0ded4e4246293
│  │  ├─ 80
│  │  │  └─ 7ab0c9fcb8596dd721ac2533441c32e60f9ce8
│  │  ├─ 86
│  │  │  └─ e576ac75cd67b97bce7a58b07ce19d0c3fc898
│  │  ├─ 87
│  │  │  ├─ bd6c1b2473d20b57b2920962488aeb4331eab0
│  │  │  └─ be353de6f1e1bd1285f29dfec56fc047166bc9
│  │  ├─ 8b
│  │  │  ├─ 6a469b7e7252bbb827569141378b552346e7a3
│  │  │  └─ 7c2c1df3e88ad55ba2dadb75fcadacef176695
│  │  ├─ 8d
│  │  │  └─ 758c2d10c217b2ecd413eddb2597db8986a777
│  │  ├─ 8e
│  │  │  └─ e08e1307976b1daa9e899f1e85b76d16c0e476
│  │  ├─ 91
│  │  │  ├─ 2d2e3116e83996f9418efbabeefdaa8f5a5067
│  │  │  └─ dc1f90dcc1c3c66ff7ee0963bd3d880288f3c7
│  │  ├─ 92
│  │  │  └─ a5c47a14a4933a7916dae6707a40ffae7cf269
│  │  ├─ 93
│  │  │  └─ 049e3195e10f77052a7093a7214bbae6a490c7
│  │  ├─ 97
│  │  │  └─ 7fd6509b189ae59e10be15fbdb29e241165909
│  │  ├─ 99
│  │  │  └─ be82502f86119076448cf7567351af5f3bb203
│  │  ├─ 9a
│  │  │  └─ 6694d2d65bbbcd008bbaad669551cf5a26ec2d
│  │  ├─ 9b
│  │  │  └─ 8a46e692b4c85209a91563b4743c52c72b9ca3
│  │  ├─ 9d
│  │  │  └─ e7b498260880713354509c89f0304efeb13aa5
│  │  ├─ 9f
│  │  │  └─ a05128a27066fafa8f81c6c8a462ce9523d8af
│  │  ├─ a0
│  │  │  └─ cab5ab0598c7f5cd40e967699ae4fef2195853
│  │  ├─ a1
│  │  │  └─ 038fbf66fadf6f7ed77f46dd457ec6ac8ab7ae
│  │  ├─ a2
│  │  │  ├─ 27c1e554e8ecbdfd9acbc113cc8314cd736e04
│  │  │  └─ 31bb7ca768eb3265e8e34f7c05b6cae99c66de
│  │  ├─ a3
│  │  │  └─ 38312058efaaa10db069b95fed253ef4fcf74c
│  │  ├─ a4
│  │  │  └─ c9861de98d6ca37c0f9af0a84671174ef15e28
│  │  ├─ a6
│  │  │  └─ 7df8b3086dd40ad5aea419396fdef3c3765224
│  │  ├─ a9
│  │  │  └─ d4e20f370377f0b58e09f7afd7e9691cad3d6c
│  │  ├─ ac
│  │  │  └─ 74949cac6fdcc59b58fe18bb108662d06b5d82
│  │  ├─ ad
│  │  │  └─ 8fd26a9a016be4e905609a73f49247eedce655
│  │  ├─ b0
│  │  │  ├─ 0bf098214dca57ee4bb5f0cea90f848679afe7
│  │  │  ├─ 934182802cdf049097b10a797eba4d834d4554
│  │  │  └─ c611b19fbf27879415f63b61facf0a156a5139
│  │  ├─ b1
│  │  │  ├─ 0c932dbad7672326274cbb2fb7ad68756a5eb3
│  │  │  ├─ 1222762dafe22447875f899bce3b6efa07de56
│  │  │  └─ 129bbeb2bd42bac69a4888090925b922ec67ed
│  │  ├─ b2
│  │  │  └─ 6d0de2b3f84f711502fa43e759d51ccae9b9b4
│  │  ├─ b3
│  │  │  ├─ 269fea7ee3d0985210ed3255391f41a570e981
│  │  │  └─ fd613557fb6b81ac696b333282f1bdaf9ca382
│  │  ├─ b4
│  │  │  ├─ 325e2984cac5951283d3d41f84a7d03cf2f907
│  │  │  └─ afbe3a0ef98fa061f50c7648e8188fbdfe5f03
│  │  ├─ b5
│  │  │  ├─ 4d1fd371aea320b8c29720215fb893e66aab7e
│  │  │  └─ 9daa0aa5ee6591ed435637d486d050a3d78070
│  │  ├─ b7
│  │  │  └─ 39ceea5907b884ce918484a2f5e6acc18f2613
│  │  ├─ b8
│  │  │  ├─ 11b29e673f99ff6fe6ce36e2426432a4555c8e
│  │  │  └─ 366202979244d023381051288635a4bd418819
│  │  ├─ b9
│  │  │  ├─ 4c7a5ae12aa7a490e7199d24ebc72276a047eb
│  │  │  └─ 4d7d72e824349953a4f15e0d38255c0835fb01
│  │  ├─ ba
│  │  │  └─ 57e37452e8a94be6713c08bd4013313703d52e
│  │  ├─ bb
│  │  │  ├─ 64638a6beb413cba140ee8efb79be386a432cb
│  │  │  └─ c9b92a09bad5c73f40bca6545e243fff041c7d
│  │  ├─ bc
│  │  │  ├─ 385833e91f116ec70bb604830c7abb8f1b9313
│  │  │  └─ 938cf3d523591ef45d9a058fff3f6bbf8dbbfc
│  │  ├─ bd
│  │  │  ├─ 6d2129a2ad99b01b7fa8253b4b8d1d761a220a
│  │  │  └─ 706ff2257513d7c24881afe1ebc443daa5c190
│  │  ├─ be
│  │  │  ├─ 21caa1c0c9ae81ff32a75f6097b8f4c12162aa
│  │  │  ├─ 6a1b862774693ab8a21920c1448a3ece7c64ce
│  │  │  └─ 701af260bde6fe31f1ac361f9dba1d569ac9d7
│  │  ├─ c1
│  │  │  └─ 38d3117c1a86629d95b6be54bb3396ff3d8d3a
│  │  ├─ c5
│  │  │  └─ 463fb8e01f513af4145cddcb1d0fe309fc9340
│  │  ├─ c7
│  │  │  ├─ 7981fb273ef308ba747a912ff70495b20a9db7
│  │  │  └─ c0bebd9d91edf0927d9ee6a78c288a0dfd0490
│  │  ├─ c8
│  │  │  └─ fc59fbc60b6cd26c202109e7209953c311f866
│  │  ├─ ca
│  │  │  └─ 561da295819691da9f9a6ecbd96e922d1a746b
│  │  ├─ cb
│  │  │  ├─ 4c2fd5318cb37a64a042ad29fb21f45bf163be
│  │  │  └─ 874326e00c6da4aaf350be4d0f718f5f7f6a8d
│  │  ├─ cd
│  │  │  └─ 4c7b9e4e4e9accd629bb8d5f266dc407f9c064
│  │  ├─ d3
│  │  │  └─ 365cd44aa120e2bb91e9af9546e266a7f3d8c3
│  │  ├─ d7
│  │  │  └─ 00a339f814a5d4e2daa3007ed189befd2aaa6c
│  │  ├─ d8
│  │  │  ├─ 4b13304342a8e12b56feb941cdb9a10521e384
│  │  │  ├─ 5bd18355f99aa6d8e9207f12a6883533e381c0
│  │  │  ├─ 9084f96e9478760020e4dc4fb3af4d2f056671
│  │  │  └─ e67af2d213b6b5e7f954f45e1b76ecdeba9a95
│  │  ├─ d9
│  │  │  └─ 55d07cb9bfe68dbed502c12b1d9c5c5f34b581
│  │  ├─ da
│  │  │  └─ 3d0871d07cd73a119d73df79ceff18e76c42af
│  │  ├─ db
│  │  │  └─ b8dbc9c3882930a34ce13e8b80b2c87984c7cb
│  │  ├─ dc
│  │  │  ├─ 0f77562b1272ce3986fca3032d0719d46acc3f
│  │  │  ├─ 78e97fd9109a4c2312a94c91f7357f204c1c55
│  │  │  └─ f257bcd2e982d123818b8b1960f6280d8fe2ce
│  │  ├─ df
│  │  │  ├─ 564a65a8e6b30303abb7b9894fe9529c295b12
│  │  │  └─ cb218cbfbf14642e194d511ef625c809892c0b
│  │  ├─ e2
│  │  │  └─ 2b2f839959390261612ad9187c3456d4ee9789
│  │  ├─ e4
│  │  │  ├─ 497174ef8544cef74c6a0e7ac34c9ae06bf80c
│  │  │  └─ 828c4d13eb0575afc5eabf6bdc90b3baf4eb53
│  │  ├─ e6
│  │  │  └─ 9de29bb2d1d6434b8b29ae775ad8c2e48c5391
│  │  ├─ e8
│  │  │  └─ 3bd4416ef2537f4106e748e2f1a78b65ace167
│  │  ├─ e9
│  │  │  ├─ 1bfe8c182f48edd392e372921ad8c12f16933d
│  │  │  └─ ddaa44b06716ad32e0c531c407404866879a43
│  │  ├─ eb
│  │  │  ├─ 4cbd25cb4f9098e8d5a8c5aba7bf2cbc980528
│  │  │  └─ 61bf84e537fe565ab4bc730c98796d6113d812
│  │  ├─ ec
│  │  │  └─ 483802a7221458a8525e8f4b976f305598b89a
│  │  ├─ ed
│  │  │  ├─ 78d5211aef5bef24c0051158b4ee5a5fc5083f
│  │  │  └─ 8c31668b08176f2b903ad6ff28d0dcb696961a
│  │  ├─ ee
│  │  │  ├─ 171260679d969c29adf37e89c0e3057668659e
│  │  │  └─ 68383c500c54fc036d31be2d9b5a84f0dd4c2f
│  │  ├─ ef
│  │  │  └─ 33fb0375235c071320fe78231d517ef28a0a72
│  │  ├─ f0
│  │  │  └─ 5bdd86abedfb5a8c55872cb12a40f023a0b46d
│  │  ├─ f1
│  │  │  └─ 97f98477e96e49843427ca2b03ba15ea8f55a2
│  │  ├─ f2
│  │  │  └─ 0724153c97e31e20c943d6127097d7966974f9
│  │  ├─ f4
│  │  │  └─ 532d6879c04c3e1b44443355da7cd397f4853b
│  │  ├─ f8
│  │  │  └─ f11225c73bce4bf9a8e5b2f1b9b9c06141cd44
│  │  ├─ fa
│  │  │  └─ 7129b17b1b81324079fbe0dbb01d3bdd808faa
│  │  ├─ fd
│  │  │  └─ b9cfbff566b6fde3a97eb4e18a4699a6dbadac
│  │  ├─ info
│  │  └─ pack
│  ├─ packed-refs
│  └─ refs
│     ├─ heads
│     │  ├─ main
│     │  ├─ modules
│     │  ├─ update-pull-request
│     │  └─ update-tfc-backend
│     ├─ remotes
│     │  └─ origin
│     │     ├─ main
│     │     ├─ modules
│     │     ├─ update-pull-request
│     │     └─ update-tfc-backend
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