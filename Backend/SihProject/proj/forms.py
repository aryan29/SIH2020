from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import AppUser
from django.forms import ModelForm


class ExtendedUserForm(UserCreationForm):
    email = forms.EmailField(required=True)
    first_name = forms.CharField(max_length=30,required=False)
    last_name = forms.CharField(max_length=50,required=False)

    class Meta:
        model = User
        fields = [
            'username',
            'first_name',
            'last_name',
            'email',
            'password1',
            'password2'
        ]

    def save(self, commit=True):
        user = super(ExtendedUserForm, self).save(commit=False)
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.email = self.cleaned_data['email']
        if commit:
            user.save()
        return user


class AppUserForm(ModelForm):
    class Meta:
        model = AppUser
        fields = ['mob', 'address']
