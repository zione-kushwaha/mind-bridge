import os
import django
from django.core.files import File
from django.conf import settings

# Initialize Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dyslexia.settings')
django.setup()

from api.models import Letter

# Path to the folder containing the images
image_folder = os.path.join(settings.BASE_DIR, 'Alphabet figure')

# Loop through each letter and add the corresponding image
for i in range(1, 27):
    letter_char = chr(96 + i)  # Convert number to corresponding lowercase letter (1 -> a, 2 -> b, etc.)
    image_path = os.path.join(image_folder, f'{i}.png')  # Assuming images are named 1.png, 2.png, etc.
    
    if os.path.exists(image_path):
        with open(image_path, 'rb') as image_file:
            letter, created = Letter.objects.get_or_create(letter=letter_char)
            letter.character_image.save(f'{letter_char}.png', File(image_file), save=True)
            print(f'Added image for letter {letter_char}')
    else:
        print(f'Image for letter {letter_char} not found')