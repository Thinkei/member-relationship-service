Sequel.migration do
  change do
    create_table(:events) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :name, "text"
      column :uuid, "uuid"
      column :create_time, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :receive_time, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      
      primary_key [:id]
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
  end
end
