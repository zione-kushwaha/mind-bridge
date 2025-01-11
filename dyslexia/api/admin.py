# Register your models here.
from django.contrib import admin
from .models import *

admin.site.register(Letter)
admin.site.register(LetterImage)
admin.site.register(GameImage)
admin.site.register(User)
admin.site.register(TestProgress)