class CreateAdminUsersPagesJoin < ActiveRecord::Migration[6.1]
  # if we use create keyword, our migration will know to create a table
  def up
    create_table :admin_users_pages, id: false do |t|
      t.integer :admin_user_id
      t.integer :page_id

      t.timestamps
    end
    add_index(:admin_users_pages, %i(admin_user_id page_id))
    # Ex:- add_index("admin_users", "username")
  end

  def down
    drop_table :admin_users_pages
  end
end
