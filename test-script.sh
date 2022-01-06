#!/bin/bash


aws emr list-clusters | jq --raw-output '.Clusters[].Id' >> hello.txt



i=0;
while read line; 
do a[$i]=$line;
aws emr describe-cluster --cluster-id ${a[$i]} | jq --raw-output '.Cluster.Ec2InstanceAttributes.EmrManagedSlaveSecurityGroup' >> ggjsgdj.json
aws emr describe-cluster --cluster-id ${a[$i]} | jq --raw-output '.Cluster.Ec2InstanceAttributes.EmrManagedMasterSecurityGroup' >> ggjsgdj.json
i=$(( i+1 )); 
done <hello.txt








