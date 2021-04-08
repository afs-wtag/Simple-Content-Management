class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.string :first_name, limit: 25 # By default SQL String limit 255 character
      # Ex:- :limit => 40
      t.string :last_name, limit: 40 # By default SQL String limit 255 character
      # Ex:- :limit => 40
      t.string :email, null: false, default: ''
      # Ex:- :default =>''
      # Ex:- :null => false
      t.string :password, limit: 40

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
