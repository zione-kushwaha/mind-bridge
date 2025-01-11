from django.db import models

class Letter(models.Model):
    letter = models.CharField(max_length=1, unique=True)  # Single character (e.g., 'a', 'b', etc.)
    character_image = models.ImageField(upload_to='character_images/' ,default='default.png' , blank=True, null=True) 
    
    def __str__(self):
        return self.letter

    def image_count(self):
        return self.images.count()  
    
    def save(self, *args, **kwargs):
        if not self.character_image:
            self.character_image = 'character_images/default.png'
        super().save(*args, **kwargs)


class LetterImage(models.Model):
    letter = models.ForeignKey(Letter, related_name='images', on_delete=models.CASCADE) 
    image = models.ImageField(upload_to='alphabet_images/')
    is_correct = models.BooleanField(default=False) 

    def __str__(self):
        return f"{self.letter.letter} - {'Correct' if self.is_correct else 'Incorrect'}"
    
class GameImage(models.Model):
    letter = models.ForeignKey(Letter , on_delete=models.CASCADE)
    description = models.TextField(max_length=100, blank=True, null=True, default='This is and alphabet')
    image = models.ImageField(upload_to='game_images/')
    additional_image_1 = models.ImageField(upload_to='game_images/', blank=True, null=True)
    additional_image_2 = models.ImageField(upload_to='game_images/', blank=True, null=True)
    def __str__(self):
        return self.letter.letter
    

class User(models.Model):
    firebase_uid = models.CharField(max_length=100, unique=True)  # Unique ID from Firebase
    email = models.EmailField(unique=True)
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name or self.email


class TestProgress(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="progress")
    test_id = models.IntegerField()
    score = models.FloatField()
    time_spent = models.FloatField()  # In seconds
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Test {self.test_id} for {self.user.name}"