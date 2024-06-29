// Function to display image preview
function previewImage(input) {
    var preview = document.getElementById('image-preview');
    preview.innerHTML = '';
    
    if (input.files && input.files[0]) {
      var reader = new FileReader();
  
      reader.onload = function(e) {
        var img = document.createElement('img');
        img.src = e.target.result;
        img.className = 'img-preview';
        preview.appendChild(img);
      }
  
      reader.readAsDataURL(input.files[0]); // Read file as data URL
    }
  }
  
  // Event listener for file input change
  document.addEventListener('DOMContentLoaded', function() {
    var avatarInput = document.getElementById('avatar-input');
    if (avatarInput) {
      avatarInput.addEventListener('change', function() {
        previewImage(this);
      });
    }
  });
  