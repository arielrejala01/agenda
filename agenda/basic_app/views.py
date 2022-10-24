from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from . import models
from basic_app.forms import AgendaFormCrear,AgendaFormActualizar
from django.http import HttpResponse,HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.contrib.auth import authenticate,login,logout
from django.views.generic import TemplateView, DetailView, ListView, CreateView, UpdateView, DeleteView

# Create your views here.
class lista_cliente(ListView):
    context_object_name = 'lista_cliente'
    model = models.Cliente
    paginate_by = 10
    template_name = 'basic_app/lista_cliente.html'

    def get_queryset(self):
        query = self.request.GET.get('buscar')
        if query:
            object_list = self.model.objects.filter(ci__icontains=query)
        else:
            object_list = self.model.objects.all()
        return object_list

class detalle_cliente(DetailView):
    context_object_name = 'detalle_cliente'
    model = models.Cliente
    template_name = 'basic_app/detail_view_cliente.html'

class lista_agenda(ListView):
    context_object_name = 'lista_agenda'
    paginate_by = 10
    model = models.Agenda
    template_name = 'basic_app/lista_agenda.html'

    def get_queryset(self):
        query = self.request.GET.get('buscar')
        if query:
            object_list = self.model.objects.filter(cliente__ci__icontains=query)
        else:
            object_list = self.model.objects.all()
        return object_list

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
    form_class = AgendaFormCrear
    model = models.Agenda

class AgendaActualizar(UpdateView):
    form_class = AgendaFormActualizar
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
                return HttpResponse("Usuario no está activo")
        else:
            print("Alguien ha intentado ingresar y falló")
            print("Username: {} y password {}".format(username,password))
            return HttpResponse("Login inválido")
    else:
        return render(request,"login.html",{})

@login_required
def user_logout(request):
    logout(request)
    return HttpResponseRedirect(reverse('login'))