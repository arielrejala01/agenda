from django import forms
from . import models

class AgendaFormCrear(forms.ModelForm):
    class Meta:
        model = models.Agenda
        fields = ['cliente','fecha_hora', 'descripcion']
        widgets = {
            'fecha_hora': forms.DateInput(attrs={'type': 'datetime-local'})
        }

class AgendaFormActualizar(forms.ModelForm):
    class Meta:
        model = models.Agenda
        fields = ['fecha_hora', 'descripcion']
        widgets = {
            'fecha_hora': forms.DateInput(attrs={'type': 'datetime-local'})
        }
        