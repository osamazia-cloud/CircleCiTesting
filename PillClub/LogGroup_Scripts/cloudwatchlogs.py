import boto3
from datetime import datetime

loggroupname = '/aws/lambda/yasir-lambda-snapshot'
client = boto3.client('logs')
String = True
response = client.describe_log_groups(
    # logGroupNamePrefix=loggroupname
)
CurrentTime = datetime.now()
LoggroupResponse=response['logGroups']
for group in LoggroupResponse:
    Log_Name=group['logGroupName']
    CreationDate = group['creationTime']
    logdate = datetime.fromtimestamp(CreationDate/1000.0)
    CreationMonth = logdate.strftime("%m")
    CreationDay = logdate.strftime("%d")
    CreationYear = logdate.strftime("%Y")
    CurrentMonth = CurrentTime.strftime("%m")
    CurrentDay = CurrentTime.strftime("%d")
    CurrentYear = CurrentTime.strftime("%Y")

    TotalDays = (int(CurrentDay)-int(CreationDay))+((int(CurrentMonth)-int(CreationMonth))*30)+((int(CurrentYear)-int(CreationYear))*365)
    print (Log_Name, "\nTotal days after creation of this loggroup:",TotalDays)
    if TotalDays > 90:
        # response = client.delete_log_group(
        # logGroupName=Log_Name,
        # )
        print("This log group are older than 90 days")  
        print("----------------------") 
    else:  
        print("This log group is less then 90 days, we will not delete them")
        print("----------------------") 
        
        
while String == True:
    if "nextToken" in response:
        response = client.describe_log_groups(
        #   logGroupNamePrefix=loggroupname,
        nextToken=response['nextToken']
        )
        LoggroupResponse=response['logGroups']
        for group in LoggroupResponse:
            Log_Name=group['logGroupName']
            CreationDate = group['creationTime']
            logdate = datetime.fromtimestamp(CreationDate/1000.0)
            CreationMonth = logdate.strftime("%m")
            CreationDay = logdate.strftime("%d")
            CreationYear = logdate.strftime("%Y")
            CurrentMonth = CurrentTime.strftime("%m")
            CurrentDay = CurrentTime.strftime("%d")
            CurrentYear = CurrentTime.strftime("%Y")
            TotalDays = (int(CurrentDay)-int(CreationDay))+((int(CurrentMonth)-int(CreationMonth))*30)+((int(CurrentYear)-int(CreationYear))*365)
            print (Log_Name, "\nTotal days after creation of this loggroup:",TotalDays)
            if TotalDays > 90:
            #     response = client.delete_log_group(
            #     logGroupName=Log_Name,
            # )
                print("This log group are older than 90 days")  
                print("----------------------") 
            else:  
                print("This log group is less then 90 days, we will not delete them")
                print("----------------------") 
                continue 
    else:
        String = False  





