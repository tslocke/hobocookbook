class AddSubjectToQuestionsAndBodyToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :body, :text
    
    add_column :questions, :subject, :string
  end

  def self.down
    remove_column :answers, :body
    
    remove_column :questions, :subject
  end
end
