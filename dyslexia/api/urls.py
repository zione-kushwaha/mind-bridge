from django.urls import path
from api.views import AlphabetImagesAPI , GameImagesAPI

urlpatterns = [
    path('api/alphabet-images/<str:letter>/', AlphabetImagesAPI.as_view(), name='alphabet-images'),
    path('api/game-images/<str:letter>/',GameImagesAPI.as_view(),name='game-images') 
]