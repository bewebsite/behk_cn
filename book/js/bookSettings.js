//flippingBook.pages = [
//	"pages/page-001.jpg",
//	"pages/page-002.jpg",
//	"pages/page-010.jpg",
//	"pages/page-004.jpg",
//	"pages/page-005.jpg",
//	"pages/page-006.jpg",
//	"pages/page-007.jpg",
//	"pages/page-008.jpg",
//	"pages/page-009.jpg",
//	"pages/page-010.jpg",
//	"pages/page-011.jpg",
//	"pages/page-012.jpg",
//	"pages/page-013.jpg",
//	"pages/page-014.jpg",
//	"pages/page-015.jpg",
//	"pages/page-016.jpg",
//    "pages/page-017.jpg",
//	"pages/page-018.jpg",
//	"pages/page-019.jpg",
//	"pages/page-020.jpg",
//];

//flippingBook.contents = [
//	[ "Cover", 1 ],
//	[ "Modern", 4 ]
//];

flippingBook.contents = new Array();
for (var i = 0; i < flippingBook.pages.length; i++) {
    flippingBook.contents[i] = ["第 " + (i + 1) + " 页", i + 1];
}

// define custom book settings here
flippingBook.settings.bookWidth = 769;
flippingBook.settings.bookHeight = 800;
flippingBook.settings.pageBackgroundColor = 0x5b7414;
flippingBook.settings.backgroundColor = 0x83a51c;
flippingBook.settings.zoomUIColor = 0x919d6c;
flippingBook.settings.useCustomCursors = false;
flippingBook.settings.dropShadowEnabled = false,
flippingBook.settings.zoomImageWidth = 590;
flippingBook.settings.zoomImageHeight = 1228;
flippingBook.settings.downloadURL = "/book/js/html-edition-documentation.pdf";
flippingBook.settings.flipSound = "/book/sounds/02.mp3";
flippingBook.settings.flipCornerStyle = "first page only";
flippingBook.settings.zoomHintEnabled = true;
//alert(flippingBook.pages.length);
// default settings can be found in the flippingbook.js file
flippingBook.create();
