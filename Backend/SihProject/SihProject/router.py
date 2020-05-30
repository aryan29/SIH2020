from proj.api.viewsets import MyViewSet1, MyViewSet2
from rest_framework import routers
router = routers.DefaultRouter()
router.register('users2', MyViewSet2, 'user-details2')
router.register('users1', MyViewSet1, 'user-details1')
