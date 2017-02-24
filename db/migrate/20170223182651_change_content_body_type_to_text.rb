class ChangeContentBodyTypeToText < ActiveRecord::Migration[5.0]
  def change
    change_column :contents, :body, :text
  end
end
