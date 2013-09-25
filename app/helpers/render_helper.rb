module RenderHelper
  def categories_list
    Category.all
  end

  def tags_list
    ActsAsTaggableOn::Tag.all
  end
end
