
#!/bin/bash

set -e

true> sg-all.csv
true> sg-all-us-east-1.csv
true> sg-all-us-east-2.csv
true> sg-all-us-west-1.csv
true> sg-all-us-west-2.csv
true> sg-used-us-east-1.csv
true> sg-used-us-east-2.csv
true> sg-used-us-west-1.csv
true> sg-used-us-west-2.csv
true> sg-used-sorted-us-east-1.csv
true> sg-used-sorted-us-east-2.csv
true> sg-used-sorted-us-west-1.csv
true> sg-used-sorted-us-west-2.csv
true> sg-all-sorted-us-east-1.csv
true> sg-all-sorted-us-east-2.csv
true> sg-all-sorted-us-west-1.csv
true> sg-all-sorted-us-west-2.csv
true> sg-unused.csv


echo "Getting unused SecurityGroups..."


printf "\nstep 1: list all security groups of us-east-1"
aws ec2 describe-security-groups  --region  us-east-1 | jq --raw-output '.SecurityGroups[].GroupId' | sort | uniq >> sg-all-us-east-1.csv
aws ec2 describe-instances  --region  us-east-1 | jq --raw-output '.Reservations[].Instances[].SecurityGroups[].GroupId' >> sg-used-us-east-1.csv
aws ec2 describe-network-interfaces --region  us-east-1 | jq --raw-output '.NetworkInterfaces[].Groups[].GroupId' >> sg-used-us-east-1.csv
aws elb describe-load-balancers --region  us-east-1 | jq --raw-output '.LoadBalancerDescriptions[].SecurityGroups[]' >> sg-used-us-east-1.csv
aws rds describe-db-security-groups  --region  us-east-1 | jq --raw-output '.DBSecurityGroups[].EC2SecurityGroups[].EC2SecurityGroupId' >> sg-used-us-east-1.csv
aws lambda list-functions  --region  us-east-1| jq --raw-output '.Functions[].VpcConfig.SecurityGroupIds[]?' >> sg-used-us-east-1.csv
aws elasticache describe-cache-clusters  --region  us-east-1 | jq --raw-output '.CacheClusters[].SecurityGroups[].SecurityGroupId' >> sg-used-us-east-1.csv


sort sg-used-us-east-1.csv | uniq >> sg-used-sorted-us-east-1.csv
sort sg-all-us-east-1.csv | uniq >>sg-all-sorted-us-east-1.csv
rm sg-all.csv


echo "us-east-1" >> sg-unused.csv
comm -23 sg-all-sorted-us-east-1.csv sg-used-sorted-us-east-1.csv >>sg-unused.csv

printf "\nstep 2: list all security groups of us-east-2"
aws ec2 describe-security-groups  --region  us-east-2 | jq --raw-output '.SecurityGroups[].GroupId' | sort | uniq >> sg-all-us-east-2.csv
aws ec2 describe-instances  --region  us-east-2 | jq --raw-output '.Reservations[].Instances[].SecurityGroups[].GroupId' >> sg-used-us-east-2.csv
aws ec2 describe-network-interfaces --region  us-east-2 | jq --raw-output '.NetworkInterfaces[].Groups[].GroupId' >> sg-used-us-east-2.csv
aws elb describe-load-balancers --region  us-east-2 | jq --raw-output '.LoadBalancerDescriptions[].SecurityGroups[]' >> sg-used-us-east-2.csv
aws rds describe-db-security-groups  --region  us-east-2 | jq --raw-output '.DBSecurityGroups[].EC2SecurityGroups[].EC2SecurityGroupId' >> sg-used-us-east-2.csv
aws lambda list-functions  --region  us-east-2| jq --raw-output '.Functions[].VpcConfig.SecurityGroupIds[]?' >> sg-used-us-east-2.csv
aws elasticache describe-cache-clusters  --region  us-east-2 | jq --raw-output '.CacheClusters[].SecurityGroups[].SecurityGroupId' >> sg-used-us-east-2.csv



sort sg-used-us-east-2.csv | uniq >> sg-used-sorted-us-east-2.csv
sort sg-all-us-east-2.csv | uniq >>sg-all-sorted-us-east-2.csv


echo "us-east-2" >> sg-unused.csv
comm -23 sg-all-sorted-us-east-2.csv sg-used-sorted-us-east-2.csv >>sg-unused.csv



printf "\nstep 3: list all security groups of us-west-1"
aws ec2 describe-security-groups  --region  us-west-1 | jq --raw-output '.SecurityGroups[].GroupId' | sort | uniq >> sg-all-us-west-1.csv
aws ec2 describe-instances  --region  us-west-1 | jq --raw-output '.Reservations[].Instances[].SecurityGroups[].GroupId' >> sg-used-us-west-1.csv
aws ec2 describe-network-interfaces --region  us-west-1 | jq --raw-output '.NetworkInterfaces[].Groups[].GroupId' >> sg-used-us-west-1.csv
aws elb describe-load-balancers --region  us-west-1 | jq --raw-output '.LoadBalancerDescriptions[].SecurityGroups[]' >> sg-used-us-west-1.csv
aws rds describe-db-security-groups  --region  us-west-1 | jq --raw-output '.DBSecurityGroups[].EC2SecurityGroups[].EC2SecurityGroupId' >> sg-used-us-west-1.csv
aws lambda list-functions  --region  us-west-1| jq --raw-output '.Functions[].VpcConfig.SecurityGroupIds[]?' >> sg-used-us-east-1.csv
aws elasticache describe-cache-clusters  --region  us-west-1 | jq --raw-output '.CacheClusters[].SecurityGroups[].SecurityGroupId' >> sg-used-us-west-1.csv


sort sg-used-us-west-1.csv | uniq >> sg-used-sorted-us-west-1.csv
sort sg-all-us-west-1.csv | uniq >>sg-all-sorted-us-west-1.csv



echo "us-west-1" >> sg-unused.csv
comm -23 sg-all-sorted-us-west-1.csv sg-used-sorted-us-west-1.csv >>sg-unused.csv





printf "\nstep 4: list all security groups of us-west-2"
aws ec2 describe-security-groups  --region  us-west-2 | jq --raw-output '.SecurityGroups[].GroupId' | sort | uniq >> sg-all-us-west-2.csv
aws ec2 describe-instances  --region  us-west-2 | jq --raw-output '.Reservations[].Instances[].SecurityGroups[].GroupId' >> sg-used-us-west-2.csv
aws ec2 describe-network-interfaces --region  us-west-2 | jq --raw-output '.NetworkInterfaces[].Groups[].GroupId' >> sg-used-us-west-2.csv
aws elb describe-load-balancers --region  us-west-2 | jq --raw-output '.LoadBalancerDescriptions[].SecurityGroups[]' >> sg-used-us-west-2.csv
aws rds describe-db-security-groups  --region  us-west-2 | jq --raw-output '.DBSecurityGroups[].EC2SecurityGroups[].EC2SecurityGroupId' >> sg-used-us-west-2.csv
aws lambda list-functions  --region  us-west-2| jq --raw-output '.Functions[].VpcConfig.SecurityGroupIds[]?' >> sg-used-us-west-2.csv
aws elasticache describe-cache-clusters  --region  us-west-2 | jq --raw-output '.CacheClusters[].SecurityGroups[].SecurityGroupId' >> sg-used-us-west-2.csv



sort sg-used-us-west-2.csv | uniq >> sg-used-sorted-us-west-2.csv
sort sg-all-us-west-2.csv | uniq >>sg-all-sorted-us-west-2.csv


printf "\nstep 5: generate the list of unused security groups, FILE NAME IS sg-unused.csv \n"
echo "us-west-2" >> sg-unused.csv
comm -23 sg-all-sorted-us-west-2.csv sg-used-sorted-us-west-2.csv >>sg-unused.csv

rm sg-all-sorted-us-west-2.csv
rm sg-all-sorted-us-west-1.csv
rm sg-all-sorted-us-east-2.csv
rm sg-all-sorted-us-east-1.csv
rm sg-used-sorted-us-east-1.csv
rm sg-used-sorted-us-east-2.csv
rm sg-used-sorted-us-west-1.csv
rm sg-used-sorted-us-west-2.csv
rm sg-all-us-east-1.csv
rm sg-all-us-east-2.csv
rm sg-all-us-west-1.csv
rm sg-all-us-west-2.csv
rm sg-used-us-east-1.csv
rm sg-used-us-east-2.csv
rm sg-used-us-west-1.csv
rm sg-used-us-west-2.csv
