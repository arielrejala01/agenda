from django.db import models
from django.urls import reverse
from django import forms

# Create your models here.
class Cliente(models.Model):
    ci = models.PositiveIntegerField(unique=True,verbose_name='Cédula de Identidad')
    nombre = models.CharField(max_length=100,default='',verbose_name='Nombre')
    apellido = models.CharField(max_length=100,default='',verbose_name='Apellido')
    email = models.EmailField(max_length=100,default='',verbose_name='Email',unique=True)
    tel = models.CharField(max_length=20,default='',verbose_name='Teléfono')
    direccion = models.CharField(max_length=150,default='',verbose_name="Dirección")

    def __str__(self):
        return str(self.ci)

    def get_absolute_url(self):
        return reverse('basic_app:detalle_cliente',kwargs={'pk':self.id})

class Agenda(models.Model):
    cliente = models.ForeignKey(Cliente,related_name='Cliente',on_delete=models.CASCADE,verbose_name='Cédula del Cliente')
    fecha_hora = models.DateTimeField(unique=True,verbose_name='Fecha y Hora de la consulta')
    descripcion = models.TextField(verbose_name='Descripción')

    def save(self, *args, **kwargs):
        from django.utils import timezone
        now = timezone.now()
        if self.fecha_hora < now:
            raise forms.ValidationError("La fecha y hora no puede estar en el pasado")
        super(Agenda, self).save(*args, **kwargs)

    def __str__(self):
        return self.cliente.nombre

    def get_absolute_url(self):
        return reverse('basic_app:detalle_agenda',kwargs={'pk':self.id})