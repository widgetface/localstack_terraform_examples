import json


def lambda_handler(event, context):
    print("Lambda orking")
    return {"statusCode": 200, "body": json.dumps("Hello")}
