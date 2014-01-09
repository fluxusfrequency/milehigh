/* Author:

*/

$("code pre").each(function(i, e) { hljs.highlightBlock(e)});

// Show the top links
var social = Handlebars.compile($("#sociallinks").html());
$(".toplinks").append(social({links:DocuMateSettings.social}));
var other = Handlebars.compile($("#otherlinks").html());
$(".toplinks").append(other({links:DocuMateSettings.links}));
// Tooltips for those links
$(".toplinks a").tooltip({placement:"bottom"});


// Automatically renders the menubar :)
var menu = Handlebars.compile($("#menubar").html());
$.each(DocuMateSettings.menu,function(i,item) { 
	var compiled = menu({menu: DocuMateSettings.menu, title: item.title, tagline: item.tagline, tag: item.tag, hr: item.hr})
	var target = $(".heading-"+item.tag)
	target.attr("class","span12").html(compiled)
	$("li",target).each(function(i,e) {
		if($("a",e).attr("href") == "#"+item.tag)
		{
			$(e).addClass("active");
		}
	});
});
