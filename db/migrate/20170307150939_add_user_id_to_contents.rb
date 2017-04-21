class AddUserIdToContents < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :user_id, :integer

    Content.find_each do |content|
      next if content.user_id
      content.user_id = User.first.id
    end

    change_column :contents, :user_id, :integer, null: false
  end
end
