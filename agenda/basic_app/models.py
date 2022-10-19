from django.db import models
from django.urls import reverse

# Create your models here.
class Cliente(models.Model):
    ci = models.PositiveIntegerField(unique=True)
    nombre = models.CharField(max_length=100,default='')
    apellido = models.CharField(max_length=100,default='')
    email = models.EmailField(max_length=100,default='')
    tel = models.CharField(max_length=20,default='')
    direccion = models.CharField(max_length=150,default='',verbose_name="Dirección")

    def __str__(self):
        return self.nombre

    def get_absolute_url(self):
        return reverse('basic_app:detalle_cliente',kwargs={'pk':self.id})

class Agenda(models.Model):
    cliente = models.ForeignKey(Cliente,related_name='Cliente',on_delete=models.DO_NOTHING)
    fecha_hora = models.DateTimeField()
    descripcion = models.TextField()

    def __str__(self):
        return self.cliente.nombre