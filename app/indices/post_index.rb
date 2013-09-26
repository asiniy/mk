ThinkingSphinx::Index.define :post, with: :active_record do
  # fields
  indexes heading
  indexes short_description
  indexes body

  # attributes
  has published
  has categories(:id), as: :category_ids
  has taggings(:tag_id), as: :tag_ids
end
