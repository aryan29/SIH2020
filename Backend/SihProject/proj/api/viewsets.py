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
from proj.MLModel.garbage_final.test_on_cpu import GarbageDetector
from proj.MLModel.Detector_class_animal.animal_detector import AnimalDetector
from proj.models import UserContributionModel, ActiveImages, AppUser, ActiveArea, Queries
from proj.maps_api import nearbyngo
from django.db.models import Q
import threading
import json
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.gis.geos import Point
from django.contrib.gis.measure import D
from django.contrib.gis.geos import GEOSGeometry
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
class GetContributions(APIView):
    def get(self, request):

        obj = UserContributionModel.objects.get(user=self.request.user)
        print(obj.contribution)
        return Response(obj.contribution)

    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]


class SubmitQueryAPI(APIView):
    def post(self, request):
        q1 = Queries.objects.create(
            user=request.user,
            name=request.user.username,
            email=request.user.email,
            message=request.data['message']
        )
        return Response(1)

    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]


class GetMyContribution(APIView):
    def get(self, request):
        print("Coming to getMyImages")
        print(self.request.user.activeimages_set.all().values('name'))
        # print(obj.name)
        return Response(self.request.user.activeimages_set.all().values_list('name', flat=True))

    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]


class getNGOList(APIView):
    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        lat = request.data['lat']
        lon = request.data['lon']
        content = nearbyngo.get_list(lat, lon)
        return Response(content)


class getActiveImagesData(APIView):
    def post(self, request):

        if(request.data["password"] == "letitbeanything"):  # Save in ev variables later
            z = ActiveImages.objects.filter(completed=False).filter(area=None)
            print(z)
            li = []
            for x in z:
                di = {
                    "pk": x.id,
                    "latitude": x.lat,
                    "longitude": x.lon,
                    "animals": x.animals,
                }
                li.append(di)
            return Response(li)
        else:
            Response("Invalid Password")


class getDataPlotting(APIView):
    def post(self, request):
        print(request.data)
        if(request.data["password"] == "letitbeanything"):  # Save in ev variables later
            z = ActiveArea.objects.filter(completed=False)
            li = []
            for x in z:
                di = {
                    "index": x.index/10.0,
                    "latitude": x.lat,
                    "longitude": x.lon,
                }
                li.append(di)
            l = json.dumps(li)
            print(l)
            return Response(l)
        else:
            Response("Invalid Password")


class CheckImage(APIView):
    parser_class = (FileUploadParser, )
    authentication_classes = [TokenAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        if 'file' not in request.data:
            return Response("File not received")

        upfile = request.FILES['file']
        lat = request.data['lat']
        lon = request.data['lon']
        print(upfile.name)
        with open(upfile.name, 'wb+') as f1:
            for chunks in upfile.chunks():
                f1.write(chunks)

        res = GarbageDetector().detect(upfile.name)
        print(res)
        ###################################
        # Do Checking related to image in seperate thread here
        ###################################
        if(res == 1):
            #############################################################
            # Can be done in a seperate thread
            animals = AnimalDetector().get_number_of_animals(upfile.name)
            imgModel = ActiveImages(
                name=upfile.name, lat=lat, lon=lon, animals=animals, contributinguser=self.request.user, point=Point(x=lon, y=lat, srid=4326))
            imgModel.save()
            obj = UserContributionModel.objects.get(user=self.request.user)
            obj.contribution = obj.contribution + 1
            obj.save()
            # Assuming File Name will not have "%"
            # print(userField.user)
            # print(userField.mob)
            # print(userField.contributionImages)
            # contributionImages
            # Go through Animal Mod

        return Response(res)
# def doChecking(lat ,lon,status):
#     error=0.0005
#     obj=ActiveImages().objects.filter(Q(lat=lat) & Q(lon=lon) & Q(completed=False))
#     if(status==0):
#         #Now no garabage
#         if(obj.reviewed==True):
#             #Increase Work Done by NGO


# class MyThread(threading.Thread):
#     def __init__(self,*args, **kwargs):
#         super(PreserializeThread, self).__init__(*args, **kwargs)

#     def run(self):
#         pass
