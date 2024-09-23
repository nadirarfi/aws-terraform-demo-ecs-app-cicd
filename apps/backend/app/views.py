from rest_framework.response import Response
from rest_framework.decorators import api_view
import logging


logger = logging.getLogger('app')

@api_view(['GET'])
def root_health_check(request):
    logger.info("Root endpoint called")
    try:
        logger.info("Connection healthy")
    except Exception as e:
        logger.error(f"Health check failed: {str(e)}")
        return Response({'status': 'unhealthy', 'error': str(e)}, status=500)
    return Response({'status': 'healthy'}, status=200)
