if @comment.persisted?
  json.success true
  json.name @comment.author_name.present? ? @comment.author_name : @comment.user.name
  json.content @comment.content
else
  json.success false
  json.errors render_errors errors_for(@comment)
end
