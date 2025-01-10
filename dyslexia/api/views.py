from rest_framework.generics import GenericAPIView
from rest_framework.response import Response
from .models import LetterImage, Letter , GameImage

class AlphabetImagesAPI(GenericAPIView):
    queryset = LetterImage.objects.all()
    lookup_field = "letter"

    def get(self, request, letter):
        try:
            letter_obj = Letter.objects.get(letter=letter.lower())
        except Letter.DoesNotExist:
            return Response({"error": "Letter not found"}, status=404)

        images = LetterImage.objects.filter(letter=letter_obj)

        if not images.exists():
            return Response({"error": "No images found for the requested letter"}, status=404)

        response_data = {
            "character_image_url": request.build_absolute_uri(letter_obj.character_image.url) if letter_obj.character_image else None,
           
            "images": [
                {
                    "image_url": request.build_absolute_uri(image.image.url),
                    "is_correct": image.is_correct,
                }
                for image in images
            ]
        }

        return Response({"status": "success", "data": response_data})

class GameImagesAPI(GenericAPIView):
    queryset = GameImage.objects.all()
    lookup_field = "letter"

    def get(self, request, letter):
        images = GameImage.objects.filter(letter__letter=letter.lower())
        if not images.exists():
            return Response({"error": "No images found for the requested letter"}, status=404)

        response_data = [
            {
                "image_url": request.build_absolute_uri(image.image.url),
            }
            for image in images
        ]

        return Response({"status": "success", "data": response_data})