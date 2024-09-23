from django.urls import path
from . import views


urlpatterns = [
    path('todos/', views.todo_list, name='todos'),
    path('health/', views.health_check, name='health_check'),
]