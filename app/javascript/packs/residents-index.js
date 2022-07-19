$(document).ready(function(){
  $('.phone_with_area_code').mask('55 (00) 00000-0000');
  $('.cpf').mask('000.000.000-00', {reverse: true});
  $('.brazilian_health_code_number').mask('000 0000 0000 0000', {reverse: true});
});
