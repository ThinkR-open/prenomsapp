function showIfChecked(checkbox, toToggle){
  if (document.getElementById(checkbox).checked) {
    $(toToggle).show();
  } else {
    $(toToggle).hide();
  }
}
