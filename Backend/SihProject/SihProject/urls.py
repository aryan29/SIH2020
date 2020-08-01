"""SihProject URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from .router import router
from rest_framework.authtoken import views
from django.contrib.auth.views import LoginView
from proj.views import UserRegister, CheckOnlyGovernMentView, CheckOnlyNgoView, activate, UserRegisterMobile, GetLocationList, GetAllRegisteredNGOs, NGOsHomePage, CustomRedirect, NGOProfilePage, UsersLeaderboard, NGOLeaderboard, RunDaily, LogoutView, HomeView, SubmitQuery, Home2, UpdateRating, GetRatingHistory, tryview
from proj.api.viewsets import getNGOList, CheckImage, GetContributions, GetMyContribution, getActiveImagesData, getDataPlotting, SubmitQueryAPI
from django.conf import settings
from proj.forms import MyForm1

from django.conf.urls.static import static
urlpatterns = [
    path('', HomeView),
    path('any/', tryview),
    path('home/', Home2),
    path('query/', SubmitQuery, name="submit-queries"),
    path('api/query/', SubmitQueryAPI.as_view(), name="submit-queries-api"),
    path('admin/', admin.site.urls),
    path('login/', LoginView.as_view(authentication_form=MyForm1)),
    path('api/getcontributions/',
         GetContributions.as_view(),
         name='get-contributions'),
    path('api/checkimage/', CheckImage.as_view(), name='check-image'),
    path('api/myimages/', GetMyContribution.as_view(), name='get-my-contribution'),
    path('api/ngoslist/', getNGOList.as_view(), name='ngo-list'),
    path('api/', include(router.urls)),
    path('api-token-auth/', views.obtain_auth_token, name='api-auth-token'),
    path('api/admin/getActiveImagesData',
         getActiveImagesData.as_view(), name='admin-data'),
    path('api/admin/getPlottingData',
         getDataPlotting.as_view(), name='admin-plot-data'),
    path('gov-update-rating', UpdateRating, name='update-rating'),
    path('get-rating-history/', GetRatingHistory, name='rating history'),
    path('api/register/', UserRegisterMobile, name='mobile-register'),
    path('gov-reviewed/', GetLocationList, name='reviewed'),
    path('gov-ngoreviewed/', GetAllRegisteredNGOs, name='ngo-reviewed'),
    path('register/', UserRegister, name='register'),
    path('gov/', CheckOnlyGovernMentView, name='gov-view'),
    path('ngolist/', NGOsHomePage, name='ngo-view'),
    path('ngo-profile/', NGOProfilePage, name='ngo-profile'),
    path('user-leaderboard/', UsersLeaderboard, name='UsersLeaderboard'),
    path('ngos-leaderboard/', NGOLeaderboard, name='NGOLeaderboard'),
    path('profiles/home/', CustomRedirect),
    path('admin/check/', RunDaily),
    path("logout/", LogoutView, name="logout"),
    path(
        r'^activate/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$',
        activate,
        name='activate'),
]+static('download/', document_root=settings.MEDIA_ROOT)
