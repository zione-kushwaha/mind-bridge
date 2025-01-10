import os
import random
import django
from django.core.files import File
from PIL import Image, ImageDraw, ImageFont

# Initialize Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dyslexia.settings') 
django.setup()

from api.models import Letter, LetterImage


from PIL import Image, ImageDraw, ImageFont

def create_letter_image(letter, font_path, padding=20):
    font = ImageFont.truetype(font_path, 150)
    image_size = (200 + 2 * padding, 200 + 2 * padding)
    image = Image.new('RGB', image_size, (255, 255, 255))
    draw = ImageDraw.Draw(image)
    
    # Use textbbox to get the size of the text
    text_bbox = draw.textbbox((0, 0), letter, font=font)
    text_width = text_bbox[2] - text_bbox[0]
    text_height = text_bbox[3] - text_bbox[1]
    
    # Calculate position to center the text with padding
    position = ((image.width - text_width) / 2, (image.height - text_height) / 2)
    draw.text(position, letter, font=font, fill=(0, 0, 0))

    return image

def rotate_image(image, angle):
    rotated_image = image.rotate(angle, expand=True, fillcolor=(255, 255, 255))
    return rotated_image

# generate and save letter images
def generate_and_save_letter_images():
    letters = "abcdefghijklmnopqrstuvwxyz"
    rotations = [0, 27, 63, 90, 112, 156, 180, 243, 307]
    save_path = "media/alphabet_images/"
    
    # Ensure media directory exists
    if not os.path.exists(save_path):
        os.makedirs(save_path)

    # Iterate through each letter
    for letter in letters:
        letter_obj, created = Letter.objects.get_or_create(letter=letter)

        # Skip if already has 9 images
        if letter_obj.images.count() >= 9:
            print(f"Letter '{letter}' already has 9 images. Skipping.")
            continue

        for i in range(9 - letter_obj.images.count()):
            # Create base letter image with padding
            base_image = create_letter_image(letter, font_path="/System/Library/Fonts/Supplemental/Arial.ttf", padding=20)            
            # Randomly rotate the image
            angle = rotations[i]
            rotated_image = rotate_image(base_image, angle)  # Use the rotate_image function

            # Save the image
            filename = f"{letter}_{i}.png"
            filepath = os.path.join(save_path, filename)
            rotated_image.save(filepath)

            # Save metadata in the database
            with open(filepath, 'rb') as f:
                LetterImage.objects.create(
                    letter=letter_obj,
                    image=File(f, name=filename),
                    is_correct=(angle == 0)
                )
        print(f"Images for letter '{letter}' have been created.")

if __name__ == "__main__":
    print("Starting image generation...")
    generate_and_save_letter_images()
    print("Image generation completed!")