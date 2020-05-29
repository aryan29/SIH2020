from proj.api.viewsets import MyViewSet
from rest_framework import routers
router = routers.DefaultRouter()
router.register('users', MyViewSet)
