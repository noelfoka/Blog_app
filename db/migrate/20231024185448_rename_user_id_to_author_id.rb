class RenameUserIdToAuthorId < ActiveRecord::Migration[7.1]
  def change
    change_table :posts do |t|
      t.rename "user_id", "author_id"
    end
  end
end
