# stns-backend-api  
AWS serverless stns backend  

# Description  
It is a stns backend consisting of AWS DynamoDB and APIGatyeway. Lambda is also used for token identification as token authentication is required.   
If you do not need authentication, please remove Lambda. There is no custom domain setting, so if you need it, please set it manually or add it to CloudFormation.  

STNS  
https://stns.jp/  


# stns-backend setup

1.Set Token in the SystemManager parameter store  

```
$ aws ssm put-parameter --name /stns/parameter/token \
  --value "YOURTOKEN" \
  --type SecureString \
  --key-id alias/aws/ssm
```

2.Build the backend API with CloudFormation (takes roughly 10 minutes)  

```
$ git clone https://github.com/Otazoman/stns-backend-api.git
$ cd stns-backend-api
$ aws cloudformation create-stack \
  --stack-name stns-backend-api-stack \
  --template-body file://stns_backend.yaml \
  --parameters ParameterKey=KmsKeyParam,ParameterValue=YOUR_SSM_KMS_KEY_ID \
  --capabilities CAPABILITY_NAMED_IAM

```

## add group and user  
1.Edit the Shell script to register groups and users to DynamoDB  
```
$ ./add_user_group.sh
```

# Setup stns-client for AmazonLinux2023  
1.Installing stns client and chache on AmazonLinux2023  
```
$ sudo dnf install -y libnss-stns-v2 https://github.com/STNS/libnss/releases/download/v2.6.8/libnss-stns-v2-2.6.8-1.x86_64.el9.rpm \
cache-stnsd https://github.com/STNS/cache-stnsd/releases/download/v0.3.18/cache-stnsd_0.3.18-1_amd64.rpm
```

2.stns client configuration file preparation  
```
$ SERVER=https://YOURAPIGATEWAY.execute-api.ap-northeast-1.amazonaws.com/prod/
$ TOKEN=YOURTOKEN
$ sudo tee -a /etc/stns/client/stns.conf <<_EOS_
api_endpoint = "${SERVER}"
auth_token = "${TOKEN}"

[cached]
enable = true
_EOS_

$ sudo systemctl restart cache-stnsd
$ sudo systemctl enable cache-stnsd

# test
$ /usr/lib/stns/stns-key-wrapper YOURADDEDUSER
```

3.nsswitch configuration file modified  
```
$ sudo vi /etc/nsswitch.conf
----------------------
passwd:     sss files stns   # stns added
shadow:     files sss stns   # stns added
group:      sss files stns   # stns added
----------------------
```

4.ssh configuration file modified  
```
$ sudo vi /etc/ssh/sshd_config
-----------------------------
PubkeyAuthentication yes     # Comments Unsubscribe 

#AuthorizedKeysCommand /opt/aws/bin/eic_run_authorized_keys %u %f #Comment out
#AuthorizedKeysCommandUser ec2-instance-connect                   #Comment out

AuthorizedKeysCommand /usr/lib/stns/stns-key-wrapper   # added
AuthorizedKeysCommandUser root                         # added
-----------------------------

$ sudo tee -a /etc/pam.d/sshd <<_EOS_
session    required     pam_mkhomedir.so skel=/etc/skel/ umask=0022
_EOS_

$ sudo systemctl restart sshd.service
```
