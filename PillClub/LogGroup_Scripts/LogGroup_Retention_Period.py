import boto3
import json


client = boto3.client('logs')

ConditionString = True
prefix = input("Enter prefix: ")
response = client.describe_log_groups(
    logGroupNamePrefix=prefix,
)
FirstResponse = response['logGroups']
for Response in FirstResponse:
    if('retentionInDays') in Response:
        days = Response['retentionInDays']
        print(days)
    else:
        response = client.put_retention_policy(
            logGroupName=Response['logGroupName'],
            retentionInDays=365
        )

while ConditionString == True:
    if "NextToken" in response:
        response = client.describe_log_groups(
            logGroupNamePrefix=prefix,
            nextToken=response['nextToken'],
        )
        FirstResponse = response['logGroups']
        for Response in FirstResponse:
            if('retentionInDays') in Response:
                days = Response['retentionInDays']
                print(days)
            else:
                response = client.put_retention_policy(
                    logGroupName=Response['logGroupName'],
                    retentionInDays=365
                )
    else:
        ConditionString = False          

print("Retention period updated")   
         
