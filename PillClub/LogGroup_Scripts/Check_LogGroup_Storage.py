import boto3
import json


client = boto3.client('logs')
ThreashHold_Size = 110 # ThreshHold size in MBs
ConditionString = True

response = client.describe_log_groups()

print("Following are the LogGroups that exceeds the Size Limit ("+str(ThreashHold_Size)+"MB):")
FirstResponse = response['logGroups']
for Response in FirstResponse:
    logGroupName=Response['logGroupName']
    LogGroup_Size=Response['storedBytes']
    LogGroup_Size_KB = LogGroup_Size/1024
    LogGroup_Size_MB = LogGroup_Size_KB/1024
    if LogGroup_Size_MB > ThreashHold_Size:
        print(str(logGroupName))
    else:
        continue    


while ConditionString == True:
    if "nextToken" in response:
        response = client.describe_log_groups(
            nextToken=response['nextToken'],
        )

        FirstResponse = response['logGroups']
        for Response in FirstResponse:
            logGroupName=Response['logGroupName']
            LogGroup_Size=Response['storedBytes']
            LogGroup_Size_KB = LogGroup_Size/1024
            LogGroup_Size_MB = LogGroup_Size_KB/1024
            if LogGroup_Size_MB > ThreashHold_Size:
                print(str(logGroupName))
            else:
                continue
    else:
        ConditionString = False     
