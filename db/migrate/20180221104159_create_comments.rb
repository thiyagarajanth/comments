class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :notes
      t.string :ip_address
      t.string :user_id
      t.timestamps
    end
  end
end
