# stns-backend-apii  

```
aws ssm put-parameter --name /stns/parameter/token \
  --value "abcd1234" \
  --type SecureString \
  --key-id alias/aws/ssm
```

```
$ git clone https://github.com/Otazoman/stns-backend-api.git
$ cd stns-backend-api
$ aws cloudformation create-stack \
  --stack-name stns-backend-api-stack \
  --template-body file://stns_backend.yaml \
  --parameters ParameterKey=KmsKeyParam,ParameterValue=YOUR_SSM_KMS_KEY_ID \
  --capabilities CAPABILITY_NAMED_IAM
$ ./add_user_group.sh

```
