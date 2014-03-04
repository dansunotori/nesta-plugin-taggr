module Nesta
#  module Plugin
#    module Taggr
#      module Helpers
        # If your plugin needs any helper methods,
        # add them here...
#      end
#    end
#  end

  class App
#    helpers Nesta::Plugin::Taggr::Helpers
    helpers do
      def tag_cloud
        $tag_cloud ||= Nesta::Page.tag_cloud
      end

      def pages_by_tag(tag)
        Nesta::Page.pages_by_tag(tag)
      end
    end 
  end

  class Page
    @@tag_cloud = {}

    # return hash of tags
    def self.tag_cloud
      @@tag_cloud = init_tag_cloud() if @@tag_cloud.nil? || @@tag_cloud.empty?
    end

    def self.pages_by_tag(tag)
      Page.find_all.select { |page| page.tags.include?( tag ) } unless tag.nil? || tag.empty?
    end

    def tags
      tag_strings
    end

    def similar_pages_by_tags
      similar_pages = Hash.new(0)
      Page.find_all.each do |page|
        similar_pages[page] = (self.tags & page.tags).size unless page == self 
      end
      similar_pages.reject { |page, similarity| similarity == 0 }.sort_by { |page, similarity| similarity }.reverse
    end

    def similar_articles_by_tags
      similar_articles = Hash.new(0)
      Page.find_articles.each do |page|
        similar_articles[page] = (self.tags & page.tags).size unless page == self
      end
      similar_articles.reject { |page, similarity| similarity == 0 }.sort_by { |page, similarity| similarity }.reverse
    end

    private
      def self.init_tag_cloud
        cloud = Hash.new(0)
        Page.find_all.each do |page| 
          page.tags.each { |t| cloud[t] += 1 } 
        end
        cloud.sort
      end

      def tag_strings
        strings = metadata('tags')
        strings.nil? ? [] : strings.split(',').map { |string| string.strip.downcase }.reject { |s| s.empty? }
      end
  end
end
