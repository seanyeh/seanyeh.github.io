require "open3"

def gen_icon_item(icon, url, subtitle, desc = "")
    desc_html = desc == "" ? "" : "<p>#{desc}</p>"
    return %{
    <a class='list-item #{icon}' href='#{url}'>
        <div>
            <div class='icon'></div>
            <div class='right'>
                <div class='subtitle'>#{subtitle}</div>
                #{desc_html}
            </div>
        </div>
    </a>
    }
end


def gen_project_item(name, title: nil, desc: nil, url: nil, box_class: nil)
    # Default url is /projects/#{name}
    url = url ? url : "/projects/#{name}"

    box_class = box_class ? box_class : "box-3"

    title = title ? "<h3>#{title}</h3>" : ""
    desc = desc ? "<div class='desc'>#{desc}</div>" : ""

    return %{
        <a href="#{url}">
        <div class="#{box_class}">
        <img src="/images/projects/#{name}/thumb.png">
            <div class="caption">
                #{title}
                #{desc}
            </div>
        </div>
        </a>
    }
end


def gen_yt(video_id)
    return %{
            <div class="video-container">
                <iframe width="100%" src="https://www.youtube.com/embed/#{video_id}" frameborder="0" allowfullscreen></iframe>
            </div>
    }
end

def gen_yt_item(video_id)
    yt_html = gen_yt(video_id)
    return %{
        <div class="box-3">
        #{yt_html}
        </div>
    }
end



# Syntax Highlighting
def code(language, code)
    cmd = "pygmentize -f html -l #{language}"
    output, _ = Open3.capture2(cmd, :stdin_data => code)
    return output
end



