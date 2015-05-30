$(function() {
	var $container = $('.masonry-container');
	$container.imagesLoaded( function () {
		$container.masonry({
			columnWidth: '.brick',
			itemSelector: '.brick'
		});   
	});

	$container.infinitescroll({
		navSelector: '.pagination',
		nextSelector: '.pagination .next_page',
		itemSelector: '.brick',
		loading: {
			finishedMsg: 'No more press releases to load.',
			img: 'data:image/gif;base64,R0lGODlhAQABAHAAACH5BAUAAAAALAAAAAABAAEAAAICRAEAOw==',
			msgText: '<i class="fa fa-refresh fa-spin fa-2x"></i>'
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

});

// document.getElementById("uploadBtn").onchange = function () {
//     	document.getElementById("uploadFile").value = this.value;
// 	};