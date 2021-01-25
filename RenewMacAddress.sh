## Script for renewing the IP address in security group
## default region: eu-west-1
## default security group name: [YOUR_SECURITY_GROUP]
## usage: ./RenewMacAddress [-r DEFAULT_REGION_NAME]

#!/bin/bash

if [[ $1 = "-h" ]]; then
   echo "Usage:"
   echo "/RenewMacAddress [-r DEFAULT_REGION_NAME]"
   echo "If no -r option is given, the default region will be set to eu-west-1"
   exit 1
elif [[ $1 = "-r" ]]; then
   export AWS_DEFAULT_REGION=$2
   echo "AWS_DEFAULT_REGION is set to $2"
else
   export AWS_DEFAULT_REGION=eu-west-1
   echo "AWS_DEFAULT_REGION is set to eu-west-1"
fi

SG_NAME=[YOUR_SG_NAME]
RC=0
old_cidr=`aws ec2 describe-security-groups --group-names=${SG_NAME} --query 'SecurityGroups[*].IpPermissions[*].IpRanges' --output text`
new_ip=`curl -s monip.org | sed -n 's/.*IP : \([0-9.]*\).*/\1/p'`
new_cidr=`echo ${new_ip}/32`
aws ec2 revoke-security-group-ingress \
    --group-name ${SG_NAME} \
    --cidr ${old_cidr} \
    --protocol tcp \
    --port 22 \
    || RC=$?
aws ec2 authorize-security-group-ingress \
    --group-name ${SG_NAME} \
    --cidr ${new_cidr} \
    --protocol tcp \
    --port 22 \
    || RC=$?
echo "old access ip " $old_cidr
echo "new access ip " $new_cidr
exit ${RC}
