from django.db import models
from phonenumber_field.modelfields import PhoneNumberField
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.forms import UserCreationForm


class AppUser(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    mob = PhoneNumberField()
    address = models.CharField(blank=True, null=True, max_length=100)
    # As it is not possible to store array in sqlite db in django
    contributionImages = models.CharField(
        blank=True, default="", max_length=100000)

    def __str__(self):
        return self.user.username


class UserContributionModel(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    contribution = models.PositiveSmallIntegerField(default=0)


class NGOUser(models.Model):
    name = models.CharField(max_length=30)
    email = models.EmailField()
    mob = PhoneNumberField()
    address = models.CharField(blank=True, null=True, max_length=100)
    contributions = models.PositiveIntegerField(default=0)
    reg_num = models.PositiveIntegerField(blank=False, null=False)

    def __str__(self):
        return self.name


class ActiveImages(models.Model):
    # Remove after debugging
    name = models.CharField(default="13232", max_length=50)
    lat = models.FloatField(default=80.0)  # latitude
    lon = models.FloatField(default=50.0)  # longitude
    timestamp = models.DateTimeField(auto_now_add=True)
    # If completed we will remove entry from this DB as this will be queried everyday and store it somewhere else
    completed = models.BooleanField(default=False)
    # Is reviewed by governement or not will show on govn dashboard (If not)
    reviewed = models.BooleanField(default=False)

    # otherwise on ngo dashboard
