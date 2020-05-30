from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import Group
from .forms import AppUserForm, ExtendedUserForm
from .decorators import allowed_users
# Create your views here.


def UserRegister(request):
    if (request.method == 'POST'):
        form1 = ExtendedUserForm(request.POST)
        form2 = AppUserForm(request.POST)
        choice = request.POST['choice']
        if (form1.is_valid and form2.is_valid):
            user = form1.save()
            profile = form2.save(commit=False)
            profile.user = user
            profile.save()
            print(choice)
            group = Group.objects.get(name=choice)
            group.user_set.add(user)

            return redirect('/login')
    else:
        form1 = ExtendedUserForm()
        form2 = AppUserForm()
        args = {'form1': form1, 'form2': form2}
        return render(request, 'registration/register.html', args)

# Like This we can add allowed roles


@allowed_users(allowed_roles=['Government'])
def CheckOnlyGovernMentView(request):
    return render(request, 'gov.html')
    pass


@allowed_users(allowed_roles=['NGO'])
def CheckOnlyNgoView(request):
    return render(request, 'ngo.html')
    pass
