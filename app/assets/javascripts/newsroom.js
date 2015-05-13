$(function() {

	var $container = $('.masonry-container');
	$container.imagesLoaded( function () {
		$container.masonry({
			//columnWidth: '.brick',
			itemSelector: '.brick'
		});   
	});

	$container.infinitescroll({
		navSelector: '.pagination',
		nextSelector: '.pagination .next_page',
		itemSelector: '.brick',
		loading: {
			finishedMsg: 'No more press releases to load.',
			img: '/assets/masonry/loader.gif'
		}
	}, function(newElements) {
		var $newElems;
		$newElems = $(newElements).css({
			opacity: 0
		});
		$newElems.imagesLoaded(function() {
			$newElems.animate({
				opacity: 1
			});
			$container.masonry('appended', $newElems, true);
		});
	});

	// var $container;
	// $container = $(".masonry-container");
	// $container.imagesLoaded(function() {
	// 	return $container.masonry({
	// 		itemSelector: ".brick",
	// 		gutterWidth: 0,
	// 		isFitWidth: true
	// 	});
	// });
	// ({
	// 	isAnimated: !Modernizr.csstransitions
	// });

});

// document.getElementById("uploadBtn").onchange = function () {
//     	document.getElementById("uploadFile").value = this.value;
// 	};