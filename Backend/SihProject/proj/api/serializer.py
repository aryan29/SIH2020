from rest_framework import serializers
from proj.models import AppUser, NGOUser, Queries
from django.contrib.auth.models import User


class AppUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppUser
        fields = "__all__"


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"


class NGOUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = NGOUser
        fields = "__all__"


class Queries(serializers.ModelSerializer):
    class Meta:
        model = Queries
        fields = "__all__"
