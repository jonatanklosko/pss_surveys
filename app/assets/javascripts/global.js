document.addEventListener('turbolinks:load', () => {
  $('[data-toggle="tooltip"]').tooltip();

  document.querySelectorAll('.custom-file input[type="file"]').forEach(input => {
    const label = input.nextElementSibling;
    const updateLabel = () => {
      const filename = input.files.length && input.files[0].name;
      if (filename) {
        label.innerText = filename;
      }
    };
    input.addEventListener('change', updateLabel);
    updateLabel();
  });
});
