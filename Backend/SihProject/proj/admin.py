from django.contrib import admin
from .models import AppUser, UserContributionModel, ActiveImages
admin.site.register(AppUser)
admin.site.register(UserContributionModel)
admin.site.register(ActiveImages)

# Register your models here.
