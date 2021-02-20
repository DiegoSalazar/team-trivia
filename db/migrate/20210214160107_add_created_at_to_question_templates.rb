class AddCreatedAtToQuestionTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :question_templates, :created_at, :datetime
    add_column :question_templates, :updated_at, :datetime
  end
end
