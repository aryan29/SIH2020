from django.contrib import admin
from .models import AppUser, UserContributionModel, ActiveImages, ActiveArea
admin.site.register(AppUser)
admin.site.register(UserContributionModel)
admin.site.register(ActiveImages)
admin.site.register(ActiveArea)

# Register your models here.
