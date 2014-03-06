README
======

nesta-plugin-taggr is a plugin for the Nesta CMS to support 'tags' metadata

Installation
------------

To install it as a gem add `nesta-plugin-taggr` to the `Gemfile` in your Nesta
project, and then re-run `bundle`:

    gem 'nesta-plugin-taggr'

Usage examples
--------------

My page has tags!

    - unless @page.tags.empty?
      - @page.tags.each do |tag|
        %a.btn.btn-info.btn-xs{ :href => "/tag?q=#{tag}", role: 'button' }= tag

Tag cloud buttons with Bootstrap. `tag_cloud` returns an array of `[tag, global_count]` pairs sorted by tag alphabetically.

    .panel
      - min_weight = 0
      - btn_class = [ 'btn-xs', 'btn-sm', '', 'btn-lg' ]
      - cloud = tag_cloud.select { |k,v| v > min_weight }
      - max_weight = cloud.max_by{|k,v| v}[1] - min_weight
      - cloud.each do |key, value|
        - weight = ((value * 1.0 / max_weight) * 4).ceil - 1
        %a{ :class => "tagcloud btn btn-info #{btn_class[weight]}", href: "/tag?q=#{key}", role: 'button' }= key

Similar articles are sorted by relevance in descending order; similarity is a number of common tags.

    %ul.list-group
      - @page.similar_articles_by_tags.first(3).each do |article, similarity|
        %li.list-group-item
          %a{ :href => article.abspath }= article.heading

To search for a tag create `/content/pages/tag.haml`. For safety in this example I'm not displaying a tag if it's not found.

    - if (results = pages_by_tag( params[:q] )) && !results.empty?
      %h1 Pages tagged '#{params[:q]}'
      %section.articles= article_summaries(results)
    - else
      %h1 Oops!
      %h3 Looks like there's no such tag.

Configuration
-------------

None so far

Usage Notes
-----------
Tags are down-cased.

If you're using `nesta-plugin-search` you'll need to add your `/tag` page to ignore list in `config.yaml`.

    search_ignore_list: 
    - /
    - /tag

    