from django.contrib import admin
from .models import AppUser, UserContributionModel
admin.site.register(AppUser)
admin.site.register(UserContributionModel)

# Register your models here.
