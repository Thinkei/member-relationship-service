Sequel.migration do
  change do
    create_table(:groups_teams) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :group_id, "uuid", :null=>false
      column :team_id, "uuid", :null=>false
      
      primary_key [:id]
    end
    
    create_table(:members_teams) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :member_id, "uuid", :null=>false
      column :team_id, "uuid", :null=>false
      
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
    
    create_table(:groups) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :name, "text"
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :updated_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      foreign_key :organisation_id, :organisations, :type=>"uuid", :null=>false, :key=>[:id]
      
      primary_key [:id]
    end
    
    create_table(:members) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :active, "boolean", :default=>true
      column :accepted, "boolean", :default=>false
      column :independent_contractor, "boolean", :default=>false
      column :role, "text", :default=>"employee"
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :updated_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      foreign_key :organisation_id, :organisations, :type=>"uuid", :null=>false, :key=>[:id]
      
      primary_key [:id]
    end
    
    create_table(:groups_members) do
      foreign_key :group_id, :groups, :type=>"uuid", :null=>false, :key=>[:id]
      foreign_key :member_id, :members, :type=>"uuid", :null=>false, :key=>[:id]
      
      primary_key [:group_id, :member_id]
    end
    
    create_table(:teams) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :name, "text"
      column :created_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      column :updated_at, "timestamp without time zone", :default=>Sequel::CURRENT_TIMESTAMP
      foreign_key :organisation_id, :organisations, :type=>"uuid", :null=>false, :key=>[:id]
      foreign_key :leader_id, :members, :type=>"uuid", :key=>[:id]
      
      primary_key [:id]
    end
  end
end
