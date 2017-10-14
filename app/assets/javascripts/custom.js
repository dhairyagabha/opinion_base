$(document).on('turbolinks:load', function() {
    $( "select" ).select2({
        theme: "bootstrap",
        tags: true,
        tokenSeparators: [',', ' ']
    });
});