ThinkingSphinx::Index.define :post, with: :active_record do
  # fields
  indexes :heading
  indexes :short_description
  indexes :body
  indexes user.name, as: :user

  # attributes
  has published, category.id
end
