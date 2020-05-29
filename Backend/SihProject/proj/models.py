from django.db import models
from phonenumber_field.modelfields import PhoneNumberField


class AppUser(models.Model):
    name = models.CharField(max_length=30)
    email = models.EmailField()
    mob = PhoneNumberField()
    address = models.CharField(blank=True, null=True, max_length=100)
    contributions = models.PositiveIntegerField(default=0)

    def __str__(self):
        return self.name


class NGOUser(models.Model):
    name = models.CharField(max_length=30)
    email = models.EmailField()
    mob = PhoneNumberField()
    address = models.CharField(blank=True, null=True, max_length=100)
    contributions = models.PositiveIntegerField(default=0)
    reg_num = models.PositiveIntegerField(blank=False, null=False)

    def __str__(self):
        return self.name
