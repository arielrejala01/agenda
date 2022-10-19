from django.urls import path
from . import views

app_name = 'basic_app'

urlpatterns = [
    path('index/',views.indexView.as_view(),name='index'),
    path('logout/',views.user_logout,name='logout'),
    path('lista_cliente/',views.lista_cliente.as_view(),name='lista_cliente'),
    path('detalle_cliente/<int:pk>/',views.detalle_cliente.as_view(),name='detalle_cliente'),
    path('crear_cliente/',views.cliente_crear.as_view(),name='crear_cliente'),
    path('actualizar_cliente/<int:pk>/',views.cliente_actualizar.as_view(),name='actualizar_cliente'),
    path('eliminar_cliente/<int:pk>/',views.cliente_eliminar.as_view(),name='eliminar_cliente'),
    path('lista_agenda/',views.lista_agenda.as_view(),name='lista_agenda'),
    path('detalle_agenda/<int:pk>/',views.detalle_agenda.as_view(),name='detalle_agenda'),
    path('crear_agenda/', views.AgendaCrear.as_view(), name='crear_agenda'),
    path('actualizar_agenda/<int:pk>/', views.AgendaActualizar.as_view(), name='actualizar_agenda'),
    path('eliminar_agenda/<int:pk>/', views.AgendaEliminar.as_view(), name='eliminar_agenda')
]