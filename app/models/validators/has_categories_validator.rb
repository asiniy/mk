class HasCategoriesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :blank) unless record.categories.any?
  end
end
