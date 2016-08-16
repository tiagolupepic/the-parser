class CreateUrlContents < ActiveRecord::Migration[5.0]
  def change
    create_table :url_contents, id: :uuid do |t|
      t.text :name
      t.hstore :headers_one  , array: true
      t.hstore :headers_two  , array: true
      t.hstore :headers_three, array: true
      t.hstore :links        , array: true

      t.timestamps null: false
    end
  end
end
