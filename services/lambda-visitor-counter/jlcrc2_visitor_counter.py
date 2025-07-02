# Import libraries
import boto3
import json
import os
from botocore.exceptions import ClientError
from decimal import Decimal

# ENVs
TABLE_NAME = os.environ.get("TABLE_NAME", "jlcrc2-visitor-counter")
PARTITION_KEY = os.environ.get("PARTITION_KEY", "pk")
PARTITION_VALUE = os.environ.get("PARTITION_VALUE", "visitorCounter")
COUNTER_ATTRIBUTE = os.environ.get("COUNTER_ATTRIBUTE", "visitCount")

# Initialize DynamoDB service client
dynamodb = boto3.resource("dynamodb")

# Connect to specific table using its name
table = dynamodb.Table(TABLE_NAME)

def increment_visitor_count():
    """
    Increments the visitor counter in DynamoDB table and returns the updated value.
    """
    try:
        response = table.update_item(
            Key={PARTITION_KEY: PARTITION_VALUE}, # Look for item with this partition key
            UpdateExpression=f"ADD {COUNTER_ATTRIBUTE} :incr", # Increment the counter
            ExpressionAttributeValues={":incr": Decimal("1")}, # Increment by 1
            ReturnValues="UPDATED_NEW" # Return the new value of the counter
        )
        
        # Extract updated count from response
        updated_count = response["Attributes"][COUNTER_ATTRIBUTE]

        if isinstance(updated_count, Decimal):
            updated_count = int(updated_count)

        return updated_count
    
    except ClientError as e:
        print(f"Error updating visitor count: {e.response['Error']['Message']}")
        raise
              
def lambda_handler(event, context):
    """
    Entry point for the Lambda function. Triggered by API Gateway when a request is made.
    This function updates the visitor count and returns the new value.
    """
    try:
        # Call the increment_visitor_count function to update the count in DynamoDB
        updated_count = increment_visitor_count()

        # Create a successful HTTP response with CORS headers so browsers don't block it
        return {
            "statusCode": 200, # HTTP 200 = OK
            "headers": {
                "Access-Control-Allow-Origin": "*", # Allows any site to make the request (CORS)
                "Access-Control-Allow-Headers": "Content-Type"
            },
            "body": json.dumps({"count": updated_count}) # Send back the new count in JSON format
        }
    
    except Exception as e:
        # In case of error (network, DynamoDB, etc.), return a 500 Internal Server Error
        print(f"Error in lambda_handler:{str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Internal Server Error"})
        }
    
    # test workflow