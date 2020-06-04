from .serializer import AppUserSerializer, NGOUserSerializer, UserSerializer
from proj.models import AppUser, NGOUser
from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication, SessionAuthentication
from rest_framework.permissions import IsAuthenticated
from ..decorators import allowed_users
from django.contrib.auth.models import User
from rest_framework.response import Response
from rest_framework.views import APIView

# Token Authentication for Our Mobile App
# Session Authentication for Our Website

# These 2 Viewsets to Store User Personal Information


class MyViewSet1(viewsets.ModelViewSet):
    def get_queryset(self):
        user = self.request.user
        return AppUser.objects.filter(user=user)
    serializer_class = AppUserSerializer
    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]


class MyViewSet2(viewsets.ModelViewSet):
    def get_queryset(self):
        user = self.request.user

        return User.objects.filter(username=user.username)
    serializer_class = UserSerializer
    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

# Returning List of Nearby NGO for User


class getNGOList(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        content = {
            "ngolist": ["nerby ngos list"]
        }
        return Response(content)
class CheckImage(APIView):
    permission_classes = [IsAuthenticated]
    def post(self, request):
        #This request will be getting a photo
        #and based on if photo contains grabage or not
        #we will generate a response
        pass
#Some More API Views Here

