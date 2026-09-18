class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title,        null: false
      t.string :author,       null: false
      t.date   :published_on
      t.text   :description

      t.timestamps
    end
  end
end