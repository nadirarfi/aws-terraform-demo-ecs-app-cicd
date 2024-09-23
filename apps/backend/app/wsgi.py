import os
import logging
from django.core.wsgi import get_wsgi_application

# Set the default Django settings module for the 'wsgi' command
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings')

# Setup logging to CloudWatch (if configured in Django settings)
logger = logging.getLogger(__name__)

# Application callable
application = get_wsgi_application()

# Optional: Logging information to ensure that the app is correctly bootstrapped
logger.info("Django application started in ECS environment")

