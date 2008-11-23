$(function() {
  $('#book_title').autocomplete({ url: '/search/by_title' });
  $('#book_str_authors').autocomplete({ url: '/search/by_author' });
  $('#book_orig_title').autocomplete({ url: '/search/by_title' });
});
