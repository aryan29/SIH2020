from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import Group
from .forms import AppUserForm, ExtendedUserForm
from .decorators import allowed_users
from django.template.loader import render_to_string
from .models import UserContributionModel
from django.views.decorators.csrf import csrf_exempt
from django.core.mail import send_mail
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.contrib.auth.models import User
from django.utils.encoding import force_bytes, force_text
from django.contrib.sites.shortcuts import get_current_site
from django.http import HttpResponse
import json
from .tokens import account_activation_token
from .models import AppUser
# Create your views here.

# All Views which user can see


@csrf_exempt
def UserRegister(request):
    if (request.method == 'POST'):
        print(request.POST)
        form1 = ExtendedUserForm(request.POST)
        form2 = AppUserForm(request.POST)
        choice = request.POST['choice']

        if (form1.is_valid() and form2.is_valid() and form1.clean()):
            user = form1.save(commit=False)
            print("Form validated")
            user.is_active = False
            user.save()
            current_site = get_current_site(request)
            message = render_to_string('registration/activate.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                'token': account_activation_token.make_token(user),
            })
            email = "nk28agra@gmail.com"
            send_mail(message=message,
                      from_email=email,
                      recipient_list=[user.email],
                      subject="Activate Your account")
            profile = form2.save(commit=False)
            profile.user = user
            profile.save()
            UserContributionModel.objects.create(user=user)
            group = Group.objects.get(name=choice)
            group.user_set.add(user)
            return redirect('/login')
        else:
            args = {
                'form1': form1,
                'form2': form2,
                "errors1": form1.errors,
                "errors2": form2.errors
            }
            return render(request, 'registration/register.html', args)

    else:
        form1 = ExtendedUserForm()
        form2 = AppUserForm()
        args = {'form1': form1, 'form2': form2}
        return render(request, 'registration/register.html', args)


# Like This we can add allowed roles
@csrf_exempt
def UserRegisterMobile(request):
    if (request.method == 'POST'):
        print("Here we are")
        print(request.POST)
        form1 = ExtendedUserForm(request.POST)
        print(form1.is_valid())
        form2 = AppUserForm(request.POST)
        print(form2.is_valid())
        choice = request.POST['choice']
        print(choice)

        if (form1.is_valid() and form2.is_valid() and form1.clean()):
            user = form1.save(commit=False)
            print("Form validated")
            user.is_active = False
            user.save()
            current_site = get_current_site(request)
            message = render_to_string('registration/activate.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                'token': account_activation_token.make_token(user),
            })
            email = "nk28agra@gmail.com"
            send_mail(message=message,
                      from_email=email,
                      recipient_list=[user.email],
                      subject="Activate Your account")
            profile = form2.save(commit=False)
            profile.user = user
            profile.save()
            UserContributionModel.objects.create(user=user)
            group = Group.objects.get(name=choice)
            group.user_set.add(user)
            return HttpResponse(json.dumps({"status": 1}))
        else:
            print("Form Not validated")
            args = {
                'form1': form1,
                'form2': form2,
                "errors1": form1.errors,
                "errors2": form2.errors
            }
            z = {**form1.errors, **form2.errors}
            return HttpResponse(json.dumps({"status": 0, "errors": z}))

    else:
        form1 = ExtendedUserForm()
        print("Form Not validated")
        form2 = AppUserForm()
        args = {'form1': form1, 'form2': form2}
        z = {**form1.errors, **form2.errors}
        return HttpResponse(json.dumps({"status": 0, "errors": z}))


@allowed_users(allowed_roles=['Government'])
def CheckOnlyGovernMentView(request):
    return render(request, 'gov.html')
    pass


# @allowed_users(allowed_roles=['NGO'])
def CheckOnlyNgoView(request):
    user = request.user
    return render(request, 'ngo.html')


def activate(request, uidb64, token):
    try:
        uid = force_text(urlsafe_base64_decode(uidb64))
        user = User.objects.get(pk=uid)
    except (TypeError, ValueError, OverflowError, User.DoesNotExist):
        user = None
    if user is not None and account_activation_token.check_token(user, token):
        user.is_active = True
        user.save()

        return HttpResponse(
            'Thank you for your email confirmation. Now you can login your account.'
        )
    else:
        return HttpResponse('Activation link is invalid!')
