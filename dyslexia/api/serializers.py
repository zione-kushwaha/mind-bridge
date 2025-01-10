from .models import Letter, LetterImage
from rest_framework import serializers

class LetterSerializer(serializers.ModelSerializer):
	class Meta:
		model = Letter
		fields = '__all__'

class LetterImageSerializer(serializers.ModelSerializer):
	class Meta:
		model = LetterImage
		fields = '__all__'
