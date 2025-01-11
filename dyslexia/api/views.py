from rest_framework.generics import GenericAPIView
from rest_framework.response import Response
from .models import LetterImage, Letter , GameImage 
from rest_framework.permissions import DjangoModelPermissionsOrAnonReadOnly
from django.http import JsonResponse
from firebase_admin import auth
from firebase_admin import firestore
from .models import User , TestProgress
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
import speech_recognition as sr
import os


class AlphabetImagesAPI(GenericAPIView):
    permission_classes = [AllowAny]

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
    permission_classes = [AllowAny]

    queryset = GameImage.objects.all()
    lookup_field = "letter"

    def get(self, request, letter):
        try:
            letter_obj = Letter.objects.get(letter=letter.lower())
        except Letter.DoesNotExist:
            return Response({"error": "Letter not found"}, status=404)

        images = GameImage.objects.filter(letter=letter_obj)
        if not images.exists():
            return Response({"error": "No images found for the requested letter"}, status=404)

        response_data = {
            "character_image_url": request.build_absolute_uri(letter_obj.character_image.url) if letter_obj.character_image else None,
            "images": [
                {
                    "image_url": request.build_absolute_uri(image.image.url),
                    "description": image.description,
                    "additional_image_1_url": request.build_absolute_uri(image.additional_image_1.url) if image.additional_image_1 else None,
                    "additional_image_2_url": request.build_absolute_uri(image.additional_image_2.url) if image.additional_image_2 else None,
                }
                for image in images
            ]
        }

        return Response({"status": "success", "data": response_data})



def test_firebase(request):
    try:
        # Retrieve a list of users (for testing purposes)
        users = auth.list_users().iterate_all()
        user_list = [{"uid": user.uid, "email": user.email} for user in users]
        return JsonResponse({"users": user_list})
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)
    

    


class SyncFirebaseUsers(APIView):
    queryset = User.objects.all()  # Required for permissions like DjangoModelPermissions
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            users = auth.list_users().iterate_all()
            created_count = 0
            for user in users:
                obj, created = User.objects.get_or_create(
                    firebase_uid=user.uid,
                    defaults={
                        'email': user.email,
                        'name': user.display_name or "Anonymous"
                    }
                )
                if created:
                    created_count += 1
            return Response({
                "message": f"Firebase users synced successfully. {created_count} users created."
            })
        except Exception as e:
            return Response({"error": str(e)}, status=500)
        
class SaveProgress(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            firebase_uid = request.data.get('firebase_uid')
            test_id = request.data.get('test_id')
            score = request.data.get('score')
            time_spent = request.data.get('time_spent')  # e.g., '00:10:30'

            user = User.objects.get(firebase_uid=firebase_uid)
            TestProgress.objects.create(
                user=user,
                test_id=test_id,
                score=score,
                time_spent=time_spent,
            )
            return Response({"message": "Progress saved successfully."})
        except User.DoesNotExist:
            return Response({"error": "User not found."}, status=404)
        except Exception as e:
            return Response({"error": str(e)}, status=500)


class VoiceRecognitionAPIView(APIView):
    permission_classes = [AllowAny]
    parser_classes = (MultiPartParser, FormParser)

    def post(self, request):
        audio_file = request.FILES.get('audio')
        if not audio_file:
            return Response({"error": "No audio file provided"}, status=400)

        # Save the audio file temporarily
        temp_file_path = "temp_audio.wav"
        with open(temp_file_path, "wb") as f:
            for chunk in audio_file.chunks():
                f.write(chunk)

        # Recognize voice
        recognizer = sr.Recognizer()
        try:
            with sr.AudioFile(temp_file_path) as source:
                audio = recognizer.record(source)
                text = recognizer.recognize_google(audio, language='en-US', show_all=False)
                os.remove(temp_file_path)  # Clean up temp file
                return Response({"text": text}, status=200)
        except sr.UnknownValueError:
            return Response({"error": "Could not understand audio"}, status=400)
        except sr.RequestError:
            return Response({"error": "Speech Recognition service error"}, status=500)
        except Exception as e:
            return Response({"error": str(e)}, status=500)
        


class SyncProgressData(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            db = firestore.client()
            progress_docs = db.collection('progress').stream()

            created_count = 0
            for doc in progress_docs:
                data = doc.to_dict()
                firebase_uid = data.get('firebase_uid')
                test_id = data.get('testid')
                score = data.get('score')
                time_spent = data.get('timespent')  

                # Fetch corresponding user
                try:
                    user = User.objects.get(firebase_uid=firebase_uid)
                except User.DoesNotExist:
                    print("user doesnt exists")
                    continue 

                # Create ProgressReport entry
                TestProgress.objects.create(
                    user=user,
                    test_id=test_id,
                    score=score,
                    time_spent=time_spent,
                )
                created_count += 1

            return Response({
                "message": f"Progress data synced successfully. {created_count} records created."
            })
        except Exception as e:
            return Response({"error": str(e)}, status=500)
        
class ProgressDataApi(APIView):
    permission_classes = [AllowAny]
    queryset = TestProgress.objects.all()

    def get(self, request , uuid):
        try:
            
            progress_data = TestProgress.objects.get(user__firebase_uid=uuid)
            response_data = {
                "user": progress_data.user.name,
                "test_id": progress_data.test_id,
                "score": progress_data.score,
                "time_spent": progress_data.time_spent,
                "created_at": progress_data.created_at,
            }
            return JsonResponse({"data": response_data})
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)