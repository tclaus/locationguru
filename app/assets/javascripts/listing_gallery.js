$('.gallery-thumbnail-image').click(function () {
console.log("image-click");
  var id = $(this).data('slideid');
  openModal();
  currentSlide(id);
});

$('#close-modal').click(function() {
  closeModal();
});

$('.prev').click(function() {
  plusSlides(-1)
});

$('.next').click(function() {
  plusSlides(1)
});

function openModal() {
  console.log("open modal");
  document.getElementById("modal-venue-gallery").style.display = "block";
}

function closeModal() {
  console.log("close modal");
  document.getElementById("modal-venue-gallery").style.display = "none";
}

var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var captionText = document.getElementById("caption");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }

  slides[slideIndex-1].style.display = "block";
}
