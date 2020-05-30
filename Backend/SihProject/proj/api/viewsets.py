from .serializer import AppUserSerializer, NGOUserSerializer
from proj.models import AppUser, NGOUser
from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication, SessionAuthentication
from rest_framework.permissions import IsAuthenticated

# Token Authentication for Our Mobile App
# Session Authentication for Our Website


class MyViewSet(viewsets.ModelViewSet):
    queryset = AppUser.objects.all()
    serializer_class = AppUserSerializer
    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]
    
