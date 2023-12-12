# Methods defined in the helpers block are available in templates
helpers do
  # bio is a text file with paragraphs separated with an extra \n
  def bio_to_html(filename = ENV["__SEANYEH_BIO_FILE"])
      contents = IO.readlines(filename).join()
      paragraphs = contents.split("\n\n").map{ |p|
          "<p>#{p.gsub("\n", " ")}</p>\n"
      }
      paragraphs.join()
  end


  def obfuscate_email(name, domain)
      nospam = content_tag "span", "NOSPAM"
      content_tag "span", "#{name}#{nospam}@#{nospam}#{domain}", :class => "obfuscate"
  end
end


set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'


ready do
    ## Create Tag Pages

    # Collect tags
    tags = sitemap.resources.map do |p|
        if p.data.tags then
            p.data.tags
        else
            []
        end
    end

    # Get Tags
    tags = Set.new(tags.reduce([], :+))

    # Create tag pages
    tags.each do |tag|
        pages = sitemap.resources.map.select do |p|
            p.data.tags and p.data.tags.include? tag
        end

        # Sort pages, most recent first
        pages.sort_by! {|item| item.data.created }.reverse!

        proxy "/pages/tags/#{tag}.html", "/pages/tag.html", :locals => {:tag_name => tag, :pages => pages}, :ignore => true
    end
end


# Pages
page "pages/tags/*.html", :layout => :layout

page "pages/*.html", :layout => :pages

proxy "pages.html", "pages_index.html", :ignore => true

# RSS
page "pages/feed.xml", :layout => false



# Teaching
# For each class page
# page "teaching/**/*", :layout => :teaching_base

# ignore "source/teaching/class//yo"

TEACH_DIR = "teaching/class"
def iter_dirs(dir, &block)
    Dir.entries("source/#{dir}/").select { |item|
        class_dir = "#{dir}/#{item}"
        if item =~ /^\.\.?$/ # Ignore ., ..

        elsif File.directory?("source/#{class_dir}")
            block.call(item)
        end
    }
end

iter_dirs("teaching/class") { |dir|
    ignore "teaching/class/#{dir}/*"
}

# For each teaching page (dir in teaching/class/),


# after_build do
#     iter_dirs("teaching/class") { |dir|
#         puts "Copying files from src -> build from dir: #{dir}"
#         class_dir = "teaching/class/#{dir}"

#         # Create directory in build/ if doesn't exist
#         FileUtils.mkdir_p("build/#{class_dir}")

#         FileUtils.cp_r "source/#{class_dir}/.", "build/#{class_dir}/"
#     }
# end




# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Make pretty urls
  activate :directory_indexes
end
