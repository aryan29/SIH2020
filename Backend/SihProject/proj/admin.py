from django.contrib import admin
from .models import AppUser, UserContributionModel, ActiveImages, ActiveArea, Queries
admin.site.register(AppUser)
admin.site.register(UserContributionModel)
admin.site.register(ActiveImages)
admin.site.register(ActiveArea)
admin.site.register(Queries)
# admin.site.register(Queries)

# Register your models here.
