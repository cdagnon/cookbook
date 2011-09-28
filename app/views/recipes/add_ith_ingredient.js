$('#input_ingredients').append('<%= (render :partial => 'add_ingredient_form').gsub("\n"," ") %>');
$('a[name="href_add_ingredient_<%= @row_index -1 %>"]').remove()
$("#quantity_<%= @row_index %>").focus()
