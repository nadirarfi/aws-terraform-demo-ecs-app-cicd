import boto3
import logging
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from rest_framework.parsers import JSONParser

import uuid
from django.conf import settings


logger = logging.getLogger('app')
dynamodb = boto3.resource('dynamodb', region_name=settings.AWS_REGION)
table = dynamodb.Table(settings.DYNAMODB_TABLE_NAME)

@api_view(['GET', 'POST'])
def todo_list(request):
    if request.method == 'GET':
        # Handle GET request to retrieve all todos
        items = []
        try:
            response = table.scan()
            items.extend(response.get('Items', []))
            # Handle pagination if there are more results
            while 'LastEvaluatedKey' in response:
                response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
                items.extend(response.get('Items', []))
        except Exception as e:
            logger.error(f"Error scanning DynamoDB: {str(e)}")
            return Response({"error": "Unable to retrieve todos"}, status=500)
        return Response(items, status=200)

    elif request.method == 'POST':
        if request.method == 'POST':
            # Ensure the request is in JSON format and parse it
            try:
                data = JSONParser().parse(request)
                logger.info(f"Received data from frontend: {data}")  # Print the received data
            except Exception as e:
                logger.error(f"Invalid JSON format: {str(e)}")
                return Response({"error": "Invalid JSON format", "details": str(e)}, status=400)

            # Validate that the 'title' field is present in the request
            if 'title' not in data:
                logger.error("Missing title field in request data")
                return Response({"error": "Title is required"}, status=400)

            # Create the new todo item
            new_todo = {
                "id": str(uuid.uuid4()),  # Generate a unique ID
                "title": data['title']    # Use the title from the request body   
            }

            logger.info(f"New todo to be inserted: {new_todo}")

            # Insert into DynamoDB
            try:
                response = table.put_item(Item=new_todo)
                logger.info(f"DynamoDB response: {response}")
            except Exception as e:
                logger.error(f"Failed to insert into DynamoDB: {str(e)}")
                return Response({"error": "Unable to add todo", "details": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

            # Return the newly created todo item
            return Response(new_todo, status=201)        

@api_view(['GET'])
def health_check(request):
    logger.info("Health check endpoint called")
    try:
        logger.info("Connection healthy")
    except Exception as e:
        logger.error(f"Health check failed: {str(e)}")
        return Response({'status': 'unhealthy', 'error': str(e)}, status=500)
    return Response({'status': 'healthy'}, status=200)

