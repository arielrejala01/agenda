from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from . import models
from django.http import HttpResponse,HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.contrib.auth import authenticate,login,logout
from django.views.generic import TemplateView, DetailView, ListView, CreateView, UpdateView, DeleteView

# Create your views here.
class lista_cliente(ListView):
    context_object_name = 'lista_cliente'
    model = models.Cliente
    template_name = 'basic_app/lista_cliente.html'

class detalle_cliente(DetailView):
    context_object_name = 'detalle_cliente'
    model = models.Cliente
    template_name = 'basic_app/detail_view_cliente.html'

class lista_agenda(ListView):
    context_object_name = 'lista_agenda'
    model = models.Agenda
    template_name = 'basic_app/lista_agenda.html'

class cliente_crear(CreateView):
    fields = ('ci','nombre','apellido','email','tel','direccion')
    model = models.Cliente

class cliente_actualizar(UpdateView):
    fields = ('nombre','apellido','email','tel','direccion')
    model = models.Cliente

class cliente_eliminar(DeleteView):
    model = models.Cliente
    success_url = reverse_lazy('basic_app:lista_cliente')
    template_name = 'basic_app/eliminar_cliente.html'

class detalle_agenda(DetailView):
    context_object_name = 'detalle_agenda'
    model = models.Agenda
    template_name = 'basic_app/detail_view_agenda.html'

class AgendaCrear(CreateView):
    fields = ('cliente','fecha_hora','descripcion')
    model = models.Agenda

class AgendaActualizar(UpdateView):
    fields = ('fecha_hora','descripcion')
    model = models.Agenda

class AgendaEliminar(DeleteView):
    model = models.Agenda
    success_url = reverse_lazy('basic_app:lista_agenda')
    template_name = 'basic_app/eliminar_agenda.html'


class indexView(TemplateView):
    template_name = 'index.html'

def user_login(request):

    if request.method == 'POST':
        username = request.POST.get("username")
        password = request.POST.get("password")

        user = authenticate(username=username,password=password)

        if user:
            if user.is_active:
                login(request,user,backend=None)
                return HttpResponseRedirect(reverse('basic_app:index'))
            else:
                return HttpResponse("User is not active")
        else:
            print("Someone tried to login and failed")
            print("Username: {} and password {}".format(username,password))
            return HttpResponse("Invalid login details incovenient")
    else:
        return render(request,"login.html",{})

@login_required
def user_logout(request):
    logout(request)
    return HttpResponseRedirect(reverse('login'))