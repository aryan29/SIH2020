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
