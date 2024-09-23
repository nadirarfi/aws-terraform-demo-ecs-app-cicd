from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from . import views

urlpatterns = [
    path('', views.root_health_check, name="root"),
    path('api/', include('app.api.urls')),  # Ensure 'api/' is pointing to your app's URLs
]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)