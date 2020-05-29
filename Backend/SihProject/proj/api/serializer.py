from rest_framework import serializers
from proj.models import AppUser, NGOUser


class AppUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppUser
        fields = "__all__"


class NGOUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = NGOUser
        fields = "__all__"
