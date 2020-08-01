from django.db import models
from phonenumber_field.modelfields import PhoneNumberField
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.forms import UserCreationForm
from field_history.tracker import FieldHistoryTracker
from django.contrib.gis.db import models
from django.contrib.gis.geos import Point


class AppUser(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    mob = PhoneNumberField()
    address = models.CharField(blank=True, null=True, max_length=100)

    def __str__(self):
        return self.user.username


class UserContributionModel(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    contribution = models.PositiveSmallIntegerField(default=0)
    workCompleted = models.PositiveSmallIntegerField(
        default=0)  # Specific for NGO
    field_history = FieldHistoryTracker(['contribution'])


class NGOUser(models.Model):
    name = models.CharField(max_length=30)
    email = models.EmailField()
    mob = PhoneNumberField()
    address = models.CharField(blank=True, null=True, max_length=100)
    contributions = models.PositiveIntegerField(default=0)
    reg_num = models.PositiveIntegerField(blank=False, null=False)

    def __str__(self):
        return self.name


class ActiveArea(models.Model):
    index = models.PositiveIntegerField(default=0)
    lat = models.FloatField(default=80.0)  # latitude
    lon = models.FloatField(default=50.0)  # longitude
    point = models.PointField(srid=4326, geography=True, default=Point(78, 22))
    timestamp = models.DateTimeField(auto_now_add=True)
    completed = models.BooleanField(default=False)
    reviewed = models.BooleanField(default=False)
    ngo = models.ForeignKey(
        User, null=True, blank=True, on_delete=models.CASCADE)
    # ngoName = models.CharField(default="", max_length=100, blank=True)


class ActiveImages(models.Model):
    # Remove after debugging
    area = models.ForeignKey(
        ActiveArea, null=True, blank=True, on_delete=models.CASCADE)
    contributinguser = models.ForeignKey(
        User, null=True, blank=True, on_delete=models.CASCADE)
    name = models.CharField(default="13232", max_length=100)
    lat = models.FloatField(default=80.0)  # latitude
    lon = models.FloatField(default=50.0)  # longitude
    point = models.PointField(srid=4326, geography=True, default=Point(78, 22))
    timestamp = models.DateTimeField(auto_now_add=True)
    animals = models.PositiveSmallIntegerField(default=0)
    # If completed we will remove entry from this DB as this will be queried everyday and store it somewhere else
    completed = models.BooleanField(default=False)
    # Is reviewed by governement or not will show on govn dashboard (If not)

    # otherwise on ngo dashboard


class Queries(models.Model):
    user = models.ForeignKey(
        User, null=True, blank=True, on_delete=models.SET_NULL)
    message = models.CharField(max_length=1000, default="any")
    name = models.CharField(max_length=30, default="any")
    email = models.EmailField()
