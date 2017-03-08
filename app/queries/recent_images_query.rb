class RecentImagesQuery
  def initialize(hashtag, page)
    @hashtag = hashtag
    @page = page || 1
  end

  def call
    result = Image.order(created_at: :desc)
    result = result.tagged_with(@hashtag) if @hashtag
    result.page(@page)
  end
end
