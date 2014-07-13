class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :handle
      t.string :url
      t.string :location
      t.text :bio

      t.timestamps
    end
  end
end
