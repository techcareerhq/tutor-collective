class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :wepay_access_token
      t.integer :wepay_account_id

      t.timestamps
    end
  end
end
