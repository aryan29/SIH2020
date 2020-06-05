from .serializer import AppUserSerializer, NGOUserSerializer, UserSerializer
from proj.models import AppUser, NGOUser
from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication, SessionAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.parsers import FileUploadParser
from ..decorators import allowed_users
from django.contrib.auth.models import User
from rest_framework.response import Response
from rest_framework.views import APIView
from proj.MLModel.Detector_class.garbage_detector import GarbageDetector

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
    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        content = {"ngolist": ["nerby ngos list"]}
        return Response(content)


class CheckImage(APIView):
    parser_class = (FileUploadParser, )
    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        if 'file' not in request.data:
            return Response("File not received")

        upfile = request.FILES['file']
        print(upfile.name)
        with open(upfile.name, 'wb+') as f1:
            for chunks in upfile.chunks():
                f1.write(chunks)
        print(GarbageDetector().detect(upfile.name))
        return Response("Image saved successfull checkin occuring")


#Some More API Views Here