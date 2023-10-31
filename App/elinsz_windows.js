/*******************************************************************************
 * EIS::Elinsz.Manager
 * Elinsz version 1.1.1 - JavaScript
 * Copyright 2023 Elinsz 3D - elinsz - elinsz3d.com.br
 ******************************************************************************/

//Format thumbnail for materials and components
function formatMaterial (material) {
	if (!material.id) { return material.text; }
	var $material = $( '<span><img src="../../Images/Thumbs/' + material.element.value + '.png" class="img-material" /> ' + material.text + '</span>' );
	return $material;
};


$(document).ready(function() {

	// Init Smartmenu
	$(function() {
		$('#main-menu').smartmenus({
			mainMenuSubOffsetX: -1,
			subMenusSubOffsetX: 10,
			subMenusSubOffsetY: 0,
			showOnClick: true,
		});
	});


	// Smartmenu update hidden input element with id of selected value
	$("#main-menu li").click(function() {
		if ($(this).children("a").hasClass("has-submenu")) { return };
		$('.menu-selected').val(this.id);
		$('.menu-selected').trigger("change");
	});

	// Tagsbox init - is re-initiated in Elinsz::Manager after update
	$('.tagsbox').select2({ tags: true, tokenSeparators: [','], placeholder: 'Tag' });
	$('.control-listbox select').select2({ minimumResultsForSearch: 5 });
	$('.listboximage').select2({ templateResult: formatMaterial, templateSelection: formatMaterial, minimumResultsForSearch: 5 });

});
