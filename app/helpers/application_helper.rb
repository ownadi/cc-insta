module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def meta_description(page_meta_description)
    content_for(:meta_description) { page_meta_description }
  end

  def heading(page_heading)
    content_for(:heading) { page_heading }
  end

  def total_pages_meta_tag
    tag('meta', name: 'total_pages', content: @images.total_pages) if images_index?
  end

  def link_to_if(*args, &block)
    args.insert 1, capture(&block) if block_given?

    super(*args)
  end

  private

  def images_index?
    controller_name == 'images' && action_name == 'index'
  end
end
