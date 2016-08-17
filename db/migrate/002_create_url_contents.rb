class CreateUrlContents < ActiveRecord::Migration[5.0]
  def change
    create_table :url_contents, id: :uuid do |t|
      t.text :name
      t.text :headers_one  , array: true, default: []
      t.text :headers_two  , array: true, default: []
      t.text :headers_three, array: true, default: []
      t.text :links        , array: true, default: []

      t.timestamps null: false
    end
  end
end
