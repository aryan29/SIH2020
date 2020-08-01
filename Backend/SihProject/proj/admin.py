from django.contrib import admin
from .models import AppUser, UserContributionModel, ActiveImages, ActiveArea, Queries
from django.contrib.gis import admin
admin.site.register(AppUser)
admin.site.register(UserContributionModel)

admin.site.register(Queries)


class LocationAdmin(admin.OSMGeoAdmin):
    point_zoom = 5


admin.site.register(ActiveImages, LocationAdmin)
admin.site.register(ActiveArea, LocationAdmin)
# admin.site.register(Queries)

# Register your models here.
