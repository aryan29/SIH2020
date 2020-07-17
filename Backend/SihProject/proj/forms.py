from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User
from .models import AppUser
from django.forms import ModelForm
from django.shortcuts import render, redirect
from django.core.exceptions import ValidationError


class ExtendedUserForm(UserCreationForm):
    email = forms.EmailField(
        required=True, widget=forms.TextInput(attrs={"class": "input"}))
    first_name = forms.CharField(
        max_length=30, required=False, widget=forms.TextInput(attrs={"class": "input"}))
    last_name = forms.CharField(
        max_length=50, required=False, widget=forms.TextInput(attrs={"class": "input"}))
    password1 = forms.CharField(
        label="Password", widget=forms.PasswordInput(attrs={"class": "input"}))
    password2 = forms.CharField(
        label="Confirm Password", widget=forms.PasswordInput(attrs={"class": "input"}))

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
        widgets = {
            'username': forms.TextInput(attrs={"class": "input"}),
        }

    def clean(self):
        data = super().clean()
        if data['email'] and User.objects.filter(email=data['email']).exists():
            self.add_error('email', "This email is already registered")
        return data

    def save(self, commit=True):
        print("In form save")
        user = super(ExtendedUserForm, self).save(commit=False)
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.email = self.cleaned_data['email']
        print(user.first_name)
        print(user.email)
        if commit:
            user.save()
        return user


class AppUserForm(ModelForm):
    class Meta:
        model = AppUser
        fields = ['mob', 'address']
        widgets = {
            'mob': forms.TextInput(attrs={"class": "input"}),
            'address': forms.TextInput(attrs={"class": "input"})
        }


class MyForm1(AuthenticationForm):
    def __init__(self, *args, **kwargs):
        super(MyForm1, self).__init__(*args, **kwargs)
    username = forms.CharField(
        required=True, widget=forms.TextInput(attrs={"class": "input"}))
    password = forms.CharField(
        label="Password", widget=forms.PasswordInput(attrs={"class": "input"}))
