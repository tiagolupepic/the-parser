class CreateUuid < ActiveRecord::Migration[5.0]
  def change
    ActiveRecord::Base.connection.execute('CREATE EXTENSION IF NOT EXISTS "uuid-ossp"');
  end
end
