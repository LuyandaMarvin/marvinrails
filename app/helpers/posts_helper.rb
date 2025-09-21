module PostsHelper

  def youtube_id(url)
    regex = %r{
      (?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/|v\/))
      ([\w-]{11})
   }x
   match = url.match(regex)
   match[1] if match
  end

  def youtube_thumbnail(url, quality = "hqdefault")
    id = youtube_id(url)
    return unless id

    "https://img.youtube.com/vi/#{id}/#{quality}.jpg"

  end

end
