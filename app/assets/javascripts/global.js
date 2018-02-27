document.addEventListener('turbolinks:load', () => {
  /* Enable tooltips. */
  $('[data-toggle="tooltip"]').tooltip();
  /* Enable expand textarea on focus. */
  [...document.getElementsByTagName('textarea')].forEach(textarea => {
    textarea.addEventListener('focus', () => autosize(textarea));
    textarea.addEventListener('blur', () => autosize.destroy(textarea));
  });
  /* Display file names using Bootstrap custom file input. */
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
