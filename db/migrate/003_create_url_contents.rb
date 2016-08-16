class CreateUrlContents < ActiveRecord::Migration[5.0]
  def change
    create_table :url_contents, id: :uuid do |t|
      t.text :name, :header_one, :header_two, :header_three
      t.hstore :links

      t.timestamps null: false
    end
  end
end
