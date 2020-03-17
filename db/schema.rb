Sequel.migration do
  change do
    create_table(:groups) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :name, "text"
      column :organisation_id, "uuid", :null=>false
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :updated_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      
      primary_key [:id]
    end
    
    create_table(:members) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :organisation_id, "uuid", :null=>false
      column :active, "boolean", :default=>true
      column :accepted, "boolean", :default=>false
      column :independent_contractor, "boolean", :default=>false
      column :role, "text", :default=>"employee"
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :updated_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      
      primary_key [:id]
    end
    
    create_table(:organisations) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :name, "text", :null=>false
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :updated_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      
      primary_key [:id]
    end
    
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
  end
end
