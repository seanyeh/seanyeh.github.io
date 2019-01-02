require "rss"

# Blog/Pages

def to_abstract_html(post)
    anchor = link_to(post.data.title, "/#{post.path}")
    title = "<div class=\"h3\">#{anchor}</div>"
    created = "<span>#{post.data.created}</span>"
    tags = to_tags_html(post)

    # make created and title same line
    "<div class='page-heading'>#{title}<div>#{created}, #{tags}</div></div>"
end

def to_tags_html(page)

    anchors = page.data.tags.map do |tag|
        "<a href=\"/pages/tags/#{tag}/\">#{tag}</a>"
    end

    "<span class=\"tags\">tags:#{anchors.join(",")}</span>"
end

def get_posts()
    posts = sitemap.resources.select{|item| item.path =~ /pages\/[^\/]+\.html/}

    # Sort from newest to oldest
    posts.sort_by! {|item| item.data.created }.reverse!

    return posts
end


# Build RSS feed
def gen_rss()
    blog_posts = get_posts()

    rss = RSS::Maker.make("rss2.0") do |maker|
        maker.channel.author = "Sean Yeh"
        maker.channel.link = "https://seanyeh.com/pages"
        maker.channel.title = "Sean Yeh - Blog"
        maker.channel.description = "Short essays and thoughts"

        blog_posts.each do |p|
            # p.path is something like: pages/post.html
            #   -> change to https://seanyeh.com/pages/post/
            url = "https://seanyeh.com/#{p.path}"
            url = url.end_with?(".html") ? "#{url[0..-6]}/" : url

            # Description
            desc = p.data.abstract ? p.data.abstract : p.data.title
            read_more = link_to("Read More »", url)

            maker.items.new_item do |item|
                item.link = url
                item.title = p.data.title
                item.pubDate = p.data.created.to_s
                item.description = "#{desc}... #{read_more}"
            end
        end
    end

    return rss
end

