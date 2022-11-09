jQuery(document).ready(function($){
  $(document).on('change', '.variant', function(evt) {
     var variant_id = $(this).val()
    // var variant_id = jQuery('#variant').val()
    _ind = $(this).attr('id').split("attributes")[1].split("_")[1] 
    ind = $(this).attr('id').split("attributes")[2].split("_")[1]
    
    return $.ajax('/admin/variants/' + variant_id + '/get_variant_property', 
      {
        type: 'GET',
        dataType: 'html',
        error: function(jqXHR, textStatus, errorThrown) {
    
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          // Clear all options from course select
          $(`select#product_productvariants_attributes_${_ind}_product_with_variant_properties_attributes_${ind}_variant_property_id.variantP option`).remove();
          //put in a empty default line
          var row = "<option value=\"" + "" + "\">" + "Variant Property" + "</option>";
          $(row).appendTo(`select#product_productvariants_attributes_${_ind}_product_with_variant_properties_attributes_${ind}_variant_property_id.variantP option`);
          // Fill course select
          data = JSON.parse(data)
          $.each(data['variant_properties'], function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
            $(row).appendTo(`select#product_productvariants_attributes_${_ind}_product_with_variant_properties_attributes_${ind}_variant_property_id.variantP`);
          });
        }
      });
  });
  
  $(document).on('change', '.variant', function(evt) {
     var variant_id = $(this).val()
    // var variant_id = jQuery('#variant').val()
    _ind = $(this).attr('id').split("attributes")[1].split("_")[1] 
    ind = $(this).attr('id').split("attributes")[2].split("_")[1]
    
    return $.ajax('/admin/variants/' + variant_id + '/get_variant_property', 
      {
        type: 'GET',
        dataType: 'html',
        error: function(jqXHR, textStatus, errorThrown) {
    
          return console.log("AJAX Error: " + textStatus);
        },
        success: function(data, textStatus, jqXHR) {
          // Clear all options from course select
          $(`select#product_productvariants_attributes_${_ind}_product_with_variant_properties_attributes_${ind}_variant_property_id.variantP option`).remove();
          //put in a empty default line
          var row = "<option value=\"" + "" + "\">" + "Variant Property" + "</option>";
          $(row).appendTo(`select#product_productvariants_attributes_${_ind}_product_with_variant_properties_attributes_${ind}_variant_property_id.variantP option`);
          // Fill course select
          data = JSON.parse(data)
          $.each(data['variant_properties'], function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
            $(row).appendTo(`select#product_productvariants_attributes_${_ind}_product_with_variant_properties_attributes_${ind}_variant_property_id.variantP`);
          });
        }
      });
  });
  
});