function initUpdateNavbarOnScroll() {
  const navbar = document.querySelector('.navbar-wagon');
  if (navbar && navbar.classList.contains('navbar-scroll')) {
    console.log("here")
    window.addEventListener('scroll', (e) => {
      if (window.scrollY >= window.innerHeight - 120) {
        navbar.classList.add('navbar-wagon-scrolled');
      } else {
        navbar.classList.remove('navbar-wagon-scrolled');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
