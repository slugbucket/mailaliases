class CreateMailaliases < ActiveRecord::Migration
  def change
    create_table :mailaliases do |t|
      t.string :cn
      t.text :rfc822mailmember
      t.text :description

      t.timestamps
    end
  end
end
